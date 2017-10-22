"Basic settings
filetype plugin indent on
syntax on

set guicursor=
set tabstop=4
set shiftwidth=4
set expandtab
set smarttab
set showcmd
set number
set showmatch
set hlsearch
set incsearch
set ignorecase
set smartcase
set backspace=2
set autoindent
set formatoptions=c,q,r,t
set ruler
set wrapscan
set mouse=a
set hidden
set laststatus=2
set encoding=utf-8
set termencoding=utf-8
set noequalalways
set timeoutlen=1000 ttimeoutlen=0
set noshowmode
set ffs=unix,dos,mac
set foldmethod=syntax
set foldlevel=99
set termguicolors
set omnifunc=syntaxcomplete#Complete
set cursorline
"set autochdir
"set winminheight=20

"What were these for?
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*


"Set buffer autocmds
autocmd BufWinEnter,WinEnter term://* startinsert 
autocmd BufWinEnter,WinEnter term://* :set cursorline 
autocmd BufLeave term://* stopinsert
autocmd BufLeave term://* :set nocursorline
autocmd BufEnter,WinEnter * silent! :lcd%:p:h
autocmd TermOpen * :resize 18

"Navigate buffers
noremap <C-J> <C-W>j
noremap <C-K> <C-W>k
noremap <C-H> <C-W>h
noremap <C-L> <C-W>l

tnoremap <C-J> <C-\><C-n><C-W>j
tnoremap <C-K> <C-\><C-n><C-W>k
tnoremap <C-H> <C-\><C-n><C-W>h
tnoremap <C-L> <C-\><C-n><C-W>l
tnoremap <Esc> <C-\><C-n>

"map leader to ,
let mapleader= ","
let maplocalleader = ","

"function! BuildYCM(info)
  "" info is a dictionary with 3 fields
  "" - name:   name of the plugin
  "" - status: 'installed', 'updated', or 'unchanged'
  "" - force:  set on PlugInstall! or PlugUpdate!
  "if a:info.status == 'installed' || a:info.force
    "!python2 ./install.py --all
  "endif
"endfunction

let g:plug_timeout = 240
call plug#begin('~/.nvim/plugged')

"Miscellaneous
Plug 'vim-airline/vim-airline' "status bar
Plug 'vim-airline/vim-airline-themes' "status bar
Plug 'edkolev/tmuxline.vim' "tmux theme
Plug 'chrisbra/csv.vim' "display CSV
Plug 'sjl/gundo.vim' "undo history
Plug 'ervandew/supertab' "multiple functions for tab key
Plug 'tpope/vim-repeat' "repeat complex actions (make sure it works)
Plug 'christoomey/vim-tmux-navigator' "tmux shortcuts
Plug 'tpope/vim-unimpaired' "miscellaneous paired mappings
Plug 'tpope/vim-abolish' "act on word variants
Plug 'christoomey/vim-system-copy' "use system clipboard
Plug 'zhaocai/goldenview.vim' "split buffers
"Plug 'nhooyr/neoman.vim' "use neovim to read man pages

"Plug 'vim-scripts/a.vim'
"Plug 'vim-jp/vital.vim'
"Plug 'vim-scripts/sudo.vim' "save as sudo - probably remove
"Plug 'mrtazz/DoxygenToolkit.vim'
"Plug 'Shougo/vimproc.vim', {'do' : 'make'} "still needed?
"Plug 'vim-scripts/TaskList.vim'

"Colorschemes
Plug 'NLKNguyen/papercolor-theme'
Plug 'lifepillar/vim-solarized8'
Plug 'nightsense/seabird'
"Plug 'liuchengxu/space-vim-dark'
"Plug 'joshdick/onedark.vim'
"Plug 'dracula/vim'
"Plug 'chriskempson/base16-vim'
"Plug 'morhetz/gruvbox'
"Plug 'nanotech/jellybeans.vim'
"Plug 'dikiaap/minimalist'
"Plug 'arcticicestudio/nord-vim'
"Plug 'tomasr/dracula'
"Plug 'rakr/vim-one'
"Plug 'vim-scripts/Color-Sampler-Pack'
"Plug 'thinca/vim-guicolorscheme'

"Comments
Plug 'scrooloose/nerdcommenter' "shortcuts to comment out
"Plug 'tpope/vim-commentary'

"Completion
Plug 'Shougo/deoplete.nvim' "completion engine
Plug 'Shougo/neoinclude.vim' "completion engine
Plug 'Shougo/neco-syntax' "vimscript completion
Plug 'Shougo/neco-vim' "vimscript completion

Plug 'zchee/deoplete-clang' "C/C++/ObjC completion
Plug 'zchee/deoplete-go' "Go completion
Plug 'zchee/deoplete-jedi' "Python completion
Plug 'zchee/deoplete-zsh' "zsh completion

Plug 'davidhalter/jedi-vim' "python completion

Plug 'landaire/deoplete-d' "D completion
"Plug 'landaire/deoplete-swift' "Swift completion

Plug 'sebastianmarkow/deoplete-rust' "Rust completion

"Plug 'carlitux/deoplete-ternjs' "Javascript completion
"Plug 'clojure-vim/async-clj-omni' "Clojure completion

Plug 'SevereOverfl0w/deoplete-github' "Github completion

"Plug 'Valloric/YouCompleteMe', { 'do': function('BuildYCM') } "replace with deoplete
"Plug 'vim-scripts/OmniCppComplete' "c++ completion

"File Management
Plug 'scrooloose/nerdtree' "Open other files
Plug 'jistr/vim-nerdtree-tabs' "Keep nerdtree open in all tabs
Plug 'mhinz/vim-startify' "vim start screen!
Plug 'justinmk/vim-dirvish' "remote file editing
Plug 'amiorin/vim-project' "huh?
Plug 'tpope/vim-eunuch' "POSIX file commands
Plug 'Shougo/vimfiler.vim' "still requires Unite!
"Plug 'eiginn/netrw' "remote edit
"Plug 'airblade/vim-rooter' "set root dir correctly

"Haskell
Plug 'dag/vim2hs'
Plug 'lukerandall/haskellmode-vim'
Plug 'adinapoli/cumino'
Plug 'bitc/vim-hdevtools'
Plug 'eagletmt/ghcmod-vim'
Plug 'Twinside/vim-haskellFold'
Plug 'travitch/hasksyn'
Plug 'eagletmt/neco-ghc'
Plug 'enomsg/vim-HaskellConcealPlus'

"Indent - set up correctly
Plug 'michaeljsmith/vim-indent-object'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'godlygeek/tabular' "align to specific characters
Plug 'tommcdo/vim-lion'

"Java - why the hell is this installed?
"Plug 'vim-scripts/JavaDecompiler.vim'

"Kana
Plug 'kana/vim-smartchr' "replace characters
Plug 'kana/vim-smartinput' "better version of auto-pair
Plug 'kana/vim-niceblock' "better visual block mode
Plug 'kana/vim-fakeclip' "better clipboard
Plug 'kana/vim-submode' "create submodes
Plug 'kana/vim-altercmd' "alter existing command
Plug 'kana/vim-narrow'
Plug 'kana/vim-advice' "alter commands?

"LaTeX
Plug 'lervag/vimtex' "LaTeX continuous compile

"Markdown
Plug 'suan/vim-instant-markdown' "Markdown contiuous compile

"Movement
Plug 'easymotion/vim-easymotion' "use letters to jump to words
Plug 'terryma/vim-multiple-cursors' "sublime text multiple cursor
Plug 'kana/vim-smartword' "better word movement
Plug 'kana/vim-better-tag-jump' "tag jump
Plug 'kana/vim-exjumplist' "jumplist motions

"Operators
Plug 'kana/vim-operator-user' "define own operator
Plug 'kana/vim-operator-replace' "replace existing operator
Plug 'kana/vim-operator-siege'

"Python
Plug 'fs111/pydoc.vim' "python documentation?
Plug 'alfredodeza/pytest.vim' "test python code
"python-mode
"Plug 'ivanov/vim-ipython' "python REPL

"REPL
Plug 'jalvesaq/Nvim-R' "R plugin
Plug 'jalvesaq/vimcmdline' "Generic REPL
Plug 'Shougo/deol.nvim' "Shell plugin
Plug 'kassio/neoterm' "Term plugin
"Plug 'jpalardy/vim-slime' "probably redundant with above

"Search - all hail FZF
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } "search with fzf
Plug 'junegunn/fzf.vim' "search commands
Plug 'rking/ag.vim' "keep around
Plug 'Shougo/denite.nvim' "more interfaces when fzf not available
Plug 'Shougo/unite.vim' "replace with dark version - replace with FZF
"Plug 'tacahiroy/ctrlp-funky' "navigate to functions - replace with FZF
"Plug 'kien/ctrlp.vim' "Launch recently used files - FZF
Plug 'mileszs/ack.vim'
"Plug 'wincent/Command-T'

"Snippets
Plug 'SirVer/ultisnips' "snippets engine - check others
Plug 'honza/vim-snippets' "snippets definition

"Surround
Plug 'tpope/vim-endwise' "add end of conditional statements, loops, etc.
Plug 'tpope/vim-surround' "to add quotes etc. around word
Plug 'wellle/targets.vim' "more text targets (i.e. parentheses)
"Plug 'jiangmiao/auto-pairs' "add parentheses

"Syntax checking
Plug 'scrooloose/syntastic' "check syntax
"Plug 'reinh/vim-makegreen'

"Tabs/buffers - slim down!
Plug 'szw/vim-ctrlspace' "navigate tabs - replace with FZF?
"Plug 'jlanzarotta/bufexplorer'
"Plug 'fholgado/minibufexpl.vim'

"Tags - redundant?
Plug 'majutsushi/tagbar' "show tags in navigable bar
Plug 'vim-scripts/taglist.vim' "show tags in bar - prob. redundant

"Text objects
Plug 'kana/vim-textobj-user' "whole buffer text object
Plug 'kana/vim-textobj-entire' "whole buffer text object
Plug 'kana/vim-textobj-function' "function text object
Plug 'kana/vim-textobj-line' "line text object
Plug 'kana/vim-textobj-help' "help text object
Plug 'kana/vim-textobj-syntax' "syntax text object
Plug 'kana/vim-textobj-lastpat' "lastpattern text object
Plug 'kana/vim-textobj-indent' "indent text object
Plug 'kana/vim-textobj-fold' "fold text object


"VCS
Plug 'tpope/vim-fugitive' "git plugin
"Plug 'vim-scripts/vcscommand.vim' "is this needed?

Plug 'ryanoasis/vim-devicons' "unicode icons everywhere
call plug#end()

"tpope/dispatch - async - needed?
"skywind3000/asyncrun.vim - async

"Ag
map <leader>a <Esc>:FzfAg!

"Airline
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
"let g:arline_solarized_bg='dark'
let g:airline_theme='papercolor'

"Cmdline
let cmdline_app = {}
let cmdline_app["python"] = "ptipython"
let cmdline_app["ruby"] = "pry"
let cmdline_app["sh"] = "zsh"
let cmdline_follow_colorscheme = 1
let cmdline_outhl = 1
let cmdline_in_buffer = 1

"CSV
let g:csv_autocmd_arrange      = 1
"let g:csv_autocmd_arrange_size = 1024*1024

"Ctrlp
let g:ctrlp_cmd = 'CtrlPMRU'
"let g:ctrlp_map = '<c-w>'
" narrow the list down with a word under cursor
"nnoremap <leader>fu :CtrlPFunky<CR>
"nnoremap <Leader>fU :execute 'CtrlPFunky ' . expand('<cword>')<Cr>

"Deoplete
let g:deoplete#enable_at_startup = 1
let g:deoplete#file#enable_buffer_path = 0
let g:deoplete#sources#go#gocode_binary = '/usr/bin/gocode'
let g:SuperTabDefaultCompletionType = 'context'
let g:SuperTabCompletionContexts = ['s:ContextText', 's:ContextDiscover']
let g:SuperTabContextTextOmniPrecedence = ['&omnifunc', '&completefunc']
let g:SuperTabContextDiscoverDiscovery = ["&completefunc:<c-x><c-u>", "&omnifunc:<c-x><c-o>"]

"Fugitive
"Command to automatically commit and push changes
map <leader>vv :Gcommit -a -m "HEAD"<CR> :Gpush -q<CR>

"FZF
noremap <C-P> :FzfHistory<CR>
nnoremap <leader>lu :FzfBLines<CR>
let g:fzf_command_prefix = 'Fzf'
let g:fzf_layout = {'down' : '~25%'}

"Goldenview
let g:goldenview__enable_default_mapping = 0

"Gundo
map <leader>g :GundoToggle<CR>

"Haskell
let g:haddock_browser="/usr/bin/google-chrome"
let g:cumino_default_terminal="konsole"

"Jedi-vim
let g:jedi#completions_enabled = 0

"Multiple Cursor
"let g:multi_cursor_quit_key='<Shift><Esc>'

"Neoterm
let g:neoterm_repl_python = "ipython"

"Nerd Tree
map <leader>n :NERDTreeToggle<CR>

"Nvim-R
let r_syntax_folding = 1 "Enable folding
let R_nvimpager = "vertical" "Split vertical
let R_help_w = 80 "set help width
let R_assign = 0 "don't autoinsert <-
let Rout_more_colors = 1 "use more colors
let R_esc_term = 0
let R_rconsole_width = 0
"let R_hl_term = 1
"let R_vsplit = 1
"let R_tmux_split = 1
"let R_in_buffer = 1
"let R_notmuxconf = 1
"let R_nvim_wd = 1
"let R_wait = 60000
"let R_tmpdir = "~/tmp"
"let R_compldir = "~/tmp"

" Use Ctrl+Space to do omnicompletion:
if has("gui_running")
    inoremap <C-Space> <C-x><C-o>
else
    inoremap <Nul> <C-x><C-o>
endif

" Press the space bar to send lines (in Normal mode) and selections to R:
vmap <Space> <Plug>RDSendSelection
nmap <Space> <Plug>RDSendLine
nmap <silent> <LocalLeader>rk :call RAction("levels")<CR>
nmap <silent> <LocalLeader>t :call RAction("tail")<CR>
nmap <silent> <LocalLeader>h :call RAction("head")<CR>
nmap <silent> <LocalLeader>p :call RAction("print")<CR>
nmap <silent> <LocalLeader>d :call RAction("dim")<CR>
nmap <silent> <LocalLeader>s :call RAction("str")<CR>

"Rooter
"let g:rooter_change_directory_for_non_project_files = 'current'

"Syntastic
"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 0
"let g:syntastic_check_on_wq = 0

"Tagbar
nmap <F10> :TagbarOpenAutoClose<CR>
let g:tagbar_type_r = {
    \ 'ctagstype' : 'r',
    \ 'kinds'     : [
        \ 'f:Functions',
        \ 'g:GlobalVariables',
        \ 'v:FunctionVariables',
    \ ]
\ }

"Tasklist
map <leader>td <Plug>TaskList

"Tmux-navigator
let g:tmux_navigator_no_mappings = 1

"Tmuxline
"if exists('$TMUX')
    "autocmd VimEnter * call tmuxline#set_statusline('airline')
"endif
let g:airline#extensions#tmuxline#enabled = 0

"UltiSnips
"better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
let g:UltiSnipsEditSplit="vertical"
"let g:UltiSnipsExpandTrigger="<c-/>"
"let g:UltiSnipsJumpForwardTrigger="<c-x>"
"let g:UltiSnipsJumpBackwardTrigger="<c-z>"

"Vimtex
"let g:vimtex_latexmk_options="-xelatex" "Use XeLaTeX to compile for better font support
let g:vimtex_compiler_progname='/usr/bin/nvr' "Use NeoVim remote to allow feedback about errors
let g:vimtex_fold_enabled = 1 "Auto fold (not working!)
let g:vimtex_view_general_viewer = 'okular'
let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'
let g:vimtex_view_general_options_latexmk = '--unique'
let g:vimtex_compiler_latexmk = {
    \ 'backend' : 'nvim',
    \}

set background=light
colorscheme seagull

"Color overrides
"hi Visual ctermfg=0 ctermbg=222
"hi Folded ctermbg=NONE
"highlight Normal ctermbg=NONE
"highlight nonText ctermbg=NONE
"highlight LineNr ctermbg=NONE
"hi Visual ctermbg=11
"hi Spellbad ctermbg=1 ctermfg=15
"hi Search ctermfg=0 ctermbg=59

