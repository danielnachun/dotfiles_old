set nocompatible
let g:plug_timeout = 240

function! BuildYCM(info)
  " info is a dictionary with 3 fields
  " - name:   name of the plugin
  " - status: 'installed', 'updated', or 'unchanged'
  " - force:  set on PlugInstall! or PlugUpdate!
  if a:info.status == 'installed' || a:info.force
    !python2 ./install.py --all
  endif
endfunction

call plug#begin('~/.vim/plugged')
Plug 'Shougo/dein.vim'
Plug 'jalvesaq/Nvim-R'
Plug 'jalvesaq/vimcmdline'
Plug 'jpalardy/vim-slime'
Plug 'fs111/pydoc.vim'
Plug 'reinh/vim-makegreen'
Plug 'vim-scripts/TaskList.vim'
Plug 'alfredodeza/pytest.vim'
Plug 'tacahiroy/ctrlp-funky'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'dag/vim2hs'
Plug 'lukerandall/haskellmode-vim'
Plug 'adinapoli/cumino'
Plug 'bitc/vim-hdevtools'
Plug 'ivanov/vim-ipython'
Plug 'kien/ctrlp.vim'
Plug 'mrtazz/DoxygenToolkit.vim'
Plug 'tpope/vim-fugitive'
Plug 'michaeljsmith/vim-indent-object'
Plug 'jiangmiao/auto-pairs'
Plug 'wincent/Command-T'
Plug 'tpope/vim-endwise'
Plug 'sjl/gundo.vim'
Plug 'tomasr/molokai'
Plug 'scrooloose/nerdcommenter'
Plug 'jlanzarotta/bufexplorer'
Plug 'nanotech/jellybeans.vim'
Plug 'davidhalter/jedi-vim'
Plug 'fholgado/minibufexpl.vim'
Plug 'scrooloose/nerdtree'
Plug 'eiginn/netrw'
Plug 'vim-scripts/OmniCppComplete'
Plug 'amiorin/vim-project'
Plug 'tpope/vim-surround'
Plug 'ervandew/supertab'
Plug 'scrooloose/syntastic'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'vim-scripts/vcscommand.vim'
Plug 'szw/vim-ctrlspace'
Plug 'tpope/vim-repeat'
Plug 'godlygeek/tabular'
Plug 'majutsushi/tagbar'
Plug 'vim-scripts/taglist.vim'
Plug 'altercation/vim-colors-solarized'
Plug 'vim-scripts/Color-Sampler-Pack'
Plug 'thinca/vim-guicolorscheme'
Plug 'vim-scripts/JavaDecompiler.vim'
Plug 'vim-scripts/a.vim'
Plug 'rking/ag.vim'
Plug 'mileszs/ack.vim'
Plug 'tpope/vim-commentary'
Plug 'easymotion/vim-easymotion'
Plug 'eagletmt/ghcmod-vim'
Plug 'Twinside/vim-haskellFold'
Plug 'travitch/hasksyn'
Plug 'vim-jp/vital.vim'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'terryma/vim-multiple-cursors'
Plug 'eagletmt/neco-ghc'
Plug 'vim-scripts/sudo.vim'
Plug 'Shougo/unite.vim'
Plug 'lervag/vimtex'
Plug 'christoomey/vim-tmux-navigator'
Plug 'suan/vim-instant-markdown'
Plug 'Valloric/YouCompleteMe', { 'do': function('BuildYCM') }
Plug 'Shougo/vimproc.vim', {'do' : 'make'}
Plug 'enomsg/vim-HaskellConcealPlus'
call plug#end()
filetype plugin indent on
syntax on

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
"set background=dark
set mouse=a
"set omnifunc=syntaxcomplete#Complete
set hidden
nmap <F10> :TagbarOpenAutoClose<CR>
set laststatus=2
set encoding=utf-8
set termencoding=utf-8
"set autochdir

"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 0
"let g:syntastic_check_on_wq = 0

"filetype plugin on
"filetype on
set ffs=unix,dos,mac
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_semantic_triggers = {'haskell' : ['.'], 'r' : ['re!\^\.\*$']}
let g:ycm_confirm_extra_conf = 0
let g:ycm_python_binary_path = '/usr/bin/python2'
let g:ycm_auto_trigger = 1
let g:jedi#completions_enabled = 0
"let g:multi_cursor_quit_key='<Shift><Esc>'
let g:haddock_browser="/usr/bin/google-chrome"
let r_syntax_folding = 1
set foldmethod=syntax
set foldlevel=99
let g:vimtex_latexmk_options="-xelatex"
let g:tmux_navigator_no_mappings = 1

" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-(>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-)>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-(>'

" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

"let g:UltiSnipsExpandTrigger="<c-/>"
"let g:UltiSnipsJumpForwardTrigger="<c-x>"
"let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsEditSplit="vertical" 
let g:cumino_default_terminal="terminator"

"command W w !sudo tee % > /dev/null
"execute pathogen#infect()
"NeoBundleCheck
"colorscheme molokai
set background=light
"highlight Normal ctermbg=NONE
"highlight nonText ctermbg=NONE
"highlight LineNr ctermbg=NONE
""hi Visual ctermbg=11
"hi Spellbad ctermbg=1 ctermfg=15
hi Search ctermfg=0 ctermbg=59
hi Visual ctermfg=0 ctermbg=222

" Lines added by the Vim-R-plugin command :RpluginConfig (2014-Oct-14 16:27):
" Change the <LocalLeader> key:
let maplocalleader = ","
let mapleader= ","
let R_nvimpager = "vertical"
let R_tmux_split = 1
let R_in_buffer = 1
let R_help_w = 80
let R_assign = 0
let R_rconsole_height = 20
let R_notmuxconf = 1
"let R_nvim_wd = 1
let R_nvimcom_wait = 60000
let Rout_more_colors = 1
" Use Ctrl+Space to do omnicompletion:
if has("gui_running")
    inoremap <C-Space> <C-x><C-o>
else
    inoremap <Nul> <C-x><C-o>
endif
" Press the space bar to send lines (in Normal mode) and selections to R:
vmap <Space> <Plug>RDSendSelection
nmap <Space> <Plug>RDSendLine

map <leader>td <Plug>TaskList
map <leader>g :GundoToggle<CR>
map <leader>n :NERDTreeToggle<CR>
map <leader>a <Esc>:Ag!
map <leader>vv :Gcommit -a -m "HEAD"<CR> :Gpush -q<CR>
" Force Vim to use 256 colors if running in a capable terminal emulator:
"if &term =~ "xterm" || &term =~ "256" || $DISPLAY != "" || $HAS_256_COLORS == "yes"
    set t_Co=256
    set term=xterm-256color
"endif

"let g:solarized_termcolors = 256
"let g:solarized_termtrans=1
let g:tagbar_type_r = {
    \ 'ctagstype' : 'r',
    \ 'kinds'     : [
        \ 'f:Functions',
        \ 'g:GlobalVariables',
        \ 'v:FunctionVariables',
    \ ]
\ }

autocmd BufEnter * silent! :lcd%:p:h

noremap <C-J> <C-W>j
noremap <C-K> <C-W>k
noremap <C-H> <C-W>h
noremap <C-L> <C-W>l

