{-# LANGUAGE TypeSynonymInstances, DeriveDataTypeable, MultiParamTypeClasses#-}
import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.SetWMName
import XMonad.Hooks.Place
import XMonad.Layout.BorderResize
import XMonad.Layout.NoBorders
import XMonad.Layout.Spacing
import XMonad.Layout.BinarySpacePartition
import XMonad.Layout.EqualSpacing
import XMonad.Layout.LayoutModifier
import XMonad.Layout.MouseResizableTile
import XMonad.Layout.MultiToggle
import XMonad.Layout.MultiToggle.Instances
import XMonad.Layout.Simplest
import XMonad.Layout.Tabbed
import XMonad.Layout.Decoration
import XMonad.Layout.WindowArranger
import XMonad.StackSet hiding (workspaces)
import XMonad.Util.Run
import XMonad.Util.SpawnOnce
import XMonad.Util.NamedScratchpad
import XMonad.Util.EZConfig(additionalKeys, removeKeys)
import qualified XMonad.StackSet as W
import System.IO
import Data.List
import XMonad.Actions.MouseResize
import XMonad.Actions.WindowGo
import XMonad.Actions.CycleRecentWS
import XMonad.Actions.CycleWS
import XMonad.Actions.WindowMenu
import XMonad.Actions.WindowBringer
import XMonad.Actions.Navigation2D
import Graphics.X11.Xlib
import Control.Conditional (notM)

--Manage hook which floats full screen windows, dialogs and any window with the title in the myFloatsC list
myManageHook = namedScratchpadManageHook scratchpads <+> (composeAll . concat $ 
    [ [className =? c --> placeHook myPlacement <+> doCenterFloat | c <- myFloatsC]
    , [appName =? c --> placeHook myPlacement <+> doCenterFloat | c <- myFloatsC]
    , [appName =? "conky" --> doFloat]
    , [className =? "dolphin" <&&> fmap ("Copying" `isInfixOf`) title --> doCenterFloat]
    , [className =? "Krusader" <&&> fmap ("Copying" `isInfixOf`) title --> doCenterFloat]
    , [className =? "ark" <&&> fmap ("Extracting" `isInfixOf`) title --> doCenterFloat]
    , [className =? "dolphin" <&&> fmap ("Moving" `isInfixOf`) title --> doCenterFloat]
    , [className =? "Krusader" <&&> fmap ("Moving" `isInfixOf`) title --> doCenterFloat]
    , [className =? "Oblogout" --> doFullFloat]
    , [isFullscreen --> doFullFloat]
    , [isDialog --> doCenterFloat]
    ]) <+>  manageDocks 

    where myFloatsC = ["Mathematica", "XMathematica", "Pidgin", "Gimp-2.8", "Gimp", "gimp-2.8", "gimp", "GNU Image Manipulation Program", "kcalc", "Kmix", "ImageJ", "fiji-Main", "Blockify", "eperiodique", "gxmessage", "Xmessage", "equate", "e_jeweled", "r_x11", "gnome-mines", "xcalc", "ACQ4 Manager", "org.gnome.Weather.Application", "sddm-config-editor", "mpv", "Conky", "Cinelerra", "cinelerra", "edu-cmu-cs-sb-stem-ST", "gnome-clocks"]

--Startup hook to launch other applications
myStartupHook = do
    ewmhDesktopsStartup >> setWMName "LG3D"
    spawn "mkfifo /tmp/wifistatus"
    spawn "/home/daniel/.xmonad/wifistatus.sh"
    spawn "xsetroot -solid black -cursor_name left_ptr"
    spawn "compton -b"
    --spawnOnce "urxvtd -q -f -o"
    spawn "export XDG_CURRENT_DESKTOP=KDE"
    spawn "imlibsetroot -s h -p c /usr/share/wallpapers/Next/contents/images/2560x1440.png"
    --spawn "imlibsetroot -s f -p c ~/Pictures/Amazing Wallpapers/MTMwMjg4MjE4Mzk3NTc4NTE0.jpg"
    spawn "xrdb /home/daniel/.Xresources"

--Placement hook for floating windows
myPlacement = inBounds (withGaps (30,0,0,0) (fixed(0.5,0.5)))
myMousePlacement = inBounds (withGaps (37,10,0,0) (fixed (1,0)))

--Create the transformer for toggle the tabbed layout
data TABBED = TABBED deriving (Read ,Show, Eq, Typeable)
instance Transformer TABBED Window 
    where transform TABBED x k = k (smartBorders (tabbedBottom shrinkText myTabConfig)) (const x)

--Layout setup which sets BSP as the main layout with tabbed and mirrored modes as toggles.  Cycling to the next layout enables fullscreen
myLayout = avoidStruts ( mkToggle (single TABBED) . mkToggle (single MIRROR) $ myBSP ||| smartBorders Full)
    where myBSP = lessBorders OnlyFloat (equalSpacing 24 4 0 1  emptyBSP)

--Setup 2D navigation -- does not work with tabbed layout!
myNavigation2DConfig = defaultNavigation2DConfig { layoutNavigation = [("Full", centerNavigation), ("BSP", centerNavigation)] 
                                                 }
--Use a less terrible font for the tab titles than the awful x default
myTabConfig = defaultTheme { fontName = "xft:Oxygen-Sans:size=10:style=Book:antialias=true"
        }

--Function to generate escape sequences for all workspaces
xmobarEscape = concatMap doubleLts
  where doubleLts '<' = "<<"
        doubleLts x   = [x]
 
--Create clickable workspacesdefaultFloating
myWorkspaces :: [String]        
myWorkspaces = clickable . (map xmobarEscape) $ ["1","2","3","4","5","6","7","8","9"]
  where clickable l = [ "<action=xdotool key alt+" ++ show (n) ++ ">" ++ ws ++ "</action>" | (i,ws) <- zip [1..9] l, let n = i ]

scratchpads =
    [ NS "ncmpcpp" "urxvt -e ncmpcpp" (title =? "ncmpcpp") nonFloating
    , NS "calendar" "gsimplecal" (appName =? "gsimplecal") (placeHook myMousePlacement <+> doFloat)
    ]

main = do
    --Get screen width
    dpy <- openDisplay ""
    let myScreenWidth = round ((fromIntegral (displayWidth dpy 0) - 1680) / 8) + 26

    --Pipe xmonad output to xmobar
    xmproc <- spawnPipe "xmobar /home/daniel/.xmobarrc"

    --Main monad call
    xmonad $ withNavigation2DConfig myNavigation2DConfig 
           $ defaultConfig { startupHook = myStartupHook
        , manageHook = myManageHook 
        , layoutHook = myLayout
        , logHook = dynamicLogWithPP . namedScratchpadFilterOutWorkspacePP $ xmobarPP
                        { ppOutput = hPutStrLn xmproc
                        , ppTitle = xmobarColor "#369be2" "" . shorten myScreenWidth 
                        , ppCurrent = xmobarColor "#369be2" ""
                        , ppSep = " <icon=arrow1.xpm/> "
                        }
        , terminal = myTerminal
        , handleEventHook = fullscreenEventHook
        , borderWidth = myBorderWidth
        , focusedBorderColor = myFocusedBorderColor
        , workspaces = myWorkspaces
        , normalBorderColor = myNormalBorderColor } `additionalKeys`

        --Set shortcut keys
        --Launch or locate specific applications
        [((mod1Mask, xK_p), spawn "rofi -show run")
        , ((mod1Mask .|. shiftMask, xK_p), spawn "dmenu_extended_run")
        , ((mod1Mask, xK_f), spawn "dolphin")
        , ((mod1Mask .|. controlMask, xK_f), raise (className =? "dolphin"))
        
        , ((mod1Mask .|. shiftMask, xK_f), spawn "krusader")
        , ((mod1Mask .|. controlMask .|. shiftMask, xK_f), raise (className =? "Krusader"))
        
        --, ((mod1Mask, xK_e), spawn "thunderbird")
        --, ((mod1Mask .|. controlMask, xK_e), raise (className =? "Thunderbird"))

        , ((mod1Mask, xK_b), spawn "google-chrome-stable --proxy-pac-url=http://proxy.ucla.edu/cgi/proxy")
        --, ((mod1Mask .|. controlMask, xK_b), raise (className =? "google-chrome" <&&> stringProperty "WM_WINDOW_ROLE" =? "browser"))
        , ((mod1Mask .|. controlMask, xK_b), raise (className =? "google-chrome" <&&> notM ((fmap("Google Drive" `isInfixOf`) title) <||> (fmap("Google Docs" `isInfixOf`) title) <||> (fmap("Google Sheets" `isInfixOf`) title) <||> (fmap("Google Slides" `isInfixOf`) title)) <&&> stringProperty "WM_WINDOW_ROLE" =? "browser"))

        --, ((mod1Mask, xK_b), spawn "palemoon")
        --, ((mod1Mask .|. controlMask, xK_b), raise (className =? "Pale moon"))

        , ((mod1Mask, xK_c), spawn "kcalc")
        , ((mod1Mask .|. controlMask, xK_c), raise (className =? "Kcalc"))

        , ((mod1Mask .|. shiftMask, xK_b), spawn "chromium")
        , ((mod1Mask .|. controlMask .|. shiftMask, xK_b), raise (className =? "chromium"))

        , ((mod1Mask, xK_s), spawn "mendeleydesktop")
        , ((mod1Mask .|. controlMask, xK_s), raise (className =? "Mendeleydesktop.x86_64"))

        , ((mod1Mask, xK_a), spawn "kwrite")
        , ((mod1Mask .|. controlMask, xK_a), raise (className =? "Kwrite"))

        , ((mod1Mask .|. shiftMask, xK_a), spawn "kate")
        , ((mod1Mask .|. controlMask .|. shiftMask, xK_a), raise (className =? "Kate"))

        , ((mod1Mask, xK_v), spawn "libreoffice") 
        , ((mod1Mask .|. controlMask, xK_v), raise (className =? "libreoffice-writer"))

        , ((mod1Mask .|. shiftMask, xK_v), spawn "/opt/google/chrome/google-chrome '--profile-directory=Profile 4' --app-id=apdfllckaahabafndbhieahigkjlhalf") 
        , ((mod1Mask .|. controlMask .|. shiftMask, xK_v), raise (className =? "google-chrome" <&&> ((fmap("Google Drive" `isInfixOf`) title) <||> (fmap("Google Docs" `isInfixOf`) title) <||> (fmap("Google Sheets" `isInfixOf`) title) <||> (fmap("Google Slides" `isInfixOf`) title))))
        
        , ((mod1Mask, xK_i), spawn "/opt/google/chrome/google-chrome '--profile-directory=Profile 2' --app-id=knipolnnllmklapflnccelgolnpehhpl")
        , ((mod1Mask .|. controlMask, xK_i), raise (fmap ("Hangouts" `isInfixOf`) title))

        , ((mod1Mask .|. shiftMask, xK_i), spawn "scudcloud")
        , ((mod1Mask .|. controlMask .|. shiftMask, xK_i), raise (className =? "Scudcloud"))

        , ((mod1Mask .|. shiftMask, xK_n), spawn "spotify")
        , ((mod1Mask .|. controlMask .|. shiftMask, xK_n), raise (className =?  "Spotify"))

        , ((mod1Mask, xK_n), spawn "clementine") 
        , ((mod1Mask .|. controlMask, xK_n), raise (className =? "Clementine"))

        , ((mod1Mask, xK_r), runInTerm "-title ranger" "ranger")
        , ((mod1Mask .|. controlMask, xK_r), raise (fmap ("ranger" `isInfixOf`) title))

        , ((mod1Mask .|. controlMask, xK_o), raise (fmap ("tmuxinator" `isInfixOf`) title))

        , ((mod1Mask, xK_u), spawn "/opt/google/chrome/google-chrome '--profile-directory=Profile 2' --app-id=hmjkmjkepdijhoojdojkdfohbdgmmhki" )
        , ((mod1Mask .|. controlMask, xK_u), raise (fmap ("Google Keep" `isInfixOf`) title))

        --, ((controlMask .|. mod1Mask, xK_Return), runInTerm "-title tmux" "exec tmux new-session -n$USER ")
        , ((controlMask .|. mod1Mask, xK_Return), spawn "urxvt -e tmuxinator start general")
        , ((controlMask .|. shiftMask, xK_Escape), spawn "ksysguard")

        --Scratchpads
        , ((mod1Mask, xK_KP_Home), namedScratchpadAction scratchpads "calendar")

        --Lock screen with screensaver
        , ((mod4Mask, xK_l), spawn "i3lock-wrapper")

        --Launch shutdown application
        , ((mod1Mask, xK_x), spawn "oblogout")
        , ((mod1Mask .|. shiftMask, xK_x), spawn "efibootmgr -n 0 & oblogout")

        --Scripts to connect or disconnect displays using xrandr
        , ((mod1Mask, xK_d), spawn "sh /home/daniel/.xmonad/connect_external.sh")
        , ((mod1Mask .|. shiftMask, xK_d), spawn "sh /home/daniel/.xmonad/disconnect_external.sh")

        --Enable or disable wireless and launch connection manager
        , ((mod1Mask .|. controlMask, xK_y), spawn "nm-connection-editor")
        , ((mod1Mask, xK_y), spawn "/home/daniel/.xmonad/wifion.sh")
        , ((mod1Mask .|. shiftMask, xK_y), spawn "/home/daniel/.xmonad/wifioff.sh")

        --Workspace navigation
        , ((mod1Mask, xK_Tab), moveTo Next NonEmptyWS)
        , ((mod1Mask .|. shiftMask, xK_Tab), moveTo Prev NonEmptyWS)
        , ((mod1Mask, xK_grave), toggleWS)
        , ((mod1Mask, xK_g), gotoMenuArgs ["-b", "-i", "-h", "26", "-sb", "#1D1F21", "-nb", "#3B3B4B", "-nf", "yellow", "-sf", "yellow", "-fn", "Oxygen Mono:size=10:antialias=true"])
        , ((mod1Mask .|. shiftMask, xK_g), bringMenuArgs ["-b", "-i", "-h", "26", "-sb", "#1D1F21", "-nb", "#3B3B4B", "-nf", "yellow", "-sf", "yellow", "-fn", "Oxygen Mono:size=10:antialias=true"])

        --Mac OS X has the best keybinding for closing windows 
        , ((mod1Mask, xK_w), kill) 

        --Navigate windows
        , ((mod1Mask, xK_l), windowGo R True)
        , ((mod1Mask, xK_h), windowGo L True)
        , ((mod1Mask, xK_j), windowGo D True)
        , ((mod1Mask, xK_k), windowGo U True)
        
        --Swap windows
        , ((mod1Mask .|. shiftMask, xK_l), windowSwap R True)
        , ((mod1Mask .|. shiftMask, xK_h), windowSwap L True)
        , ((mod1Mask .|. shiftMask, xK_j), windowSwap D True)
        , ((mod1Mask .|. shiftMask, xK_k), windowSwap U True)

        --Resize windows
        , ((mod1Mask .|. controlMask, xK_l), sendMessage $ ExpandTowards R)
        , ((mod1Mask .|. controlMask, xK_h), sendMessage $ ExpandTowards L)
        , ((mod1Mask .|. controlMask, xK_j), sendMessage $ ExpandTowards D)
        , ((mod1Mask .|. controlMask, xK_k), sendMessage $ ExpandTowards U)

        --Misc. window management
        , ((mod1Mask .|. controlMask, xK_space), sendMessage Swap)
        , ((mod1Mask, xK_comma), sendMessage Rotate)

        --Toggles
        , ((mod1Mask, xK_period), sendMessage $ Toggle MIRROR)
        , ((mod4Mask, xK_t), sendMessage $ Toggle TABBED)
        
        --Needed to navigate tabs
        , ((mod1Mask, xK_minus), windows W.focusUp)
        , ((mod1Mask, xK_equal), windows W.focusDown)

        --Adjust spacing
        , ((mod1Mask, xK_bracketleft), sendMessage  LessSpacing)
        , ((mod1Mask, xK_bracketright), sendMessage  MoreSpacing)

        --Volume key mapping
        , ((0, 0x1008FF11), spawn "amixer set Master 5%-")
        , ((0, 0x1008FF13), spawn "amixer set Master 5%+")
        , ((0, 0x1008FF12), spawn "amixer set Master toggle")
        ] 
--Set terminal
myTerminal = "urxvt"

--Set border info
myBorderWidth = 2
myFocusedBorderColor = "#b3b3bb"
myNormalBorderColor = "black"

