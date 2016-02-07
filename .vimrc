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
set nocompatible
set hidden
nmap <F10> :TagbarOpenAutoClose<CR>
set laststatus=2
set encoding=utf-8
set termencoding=utf-8

"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 0
"let g:syntastic_check_on_wq = 0

"filetype plugin on
filetype off
filetype plugin indent on
syntax on
set ffs=unix,dos,mac
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_semantic_triggers = {'haskell' : ['.']}
let g:ycm_confirm_extra_conf = 0
let g:jedi#completions_enabled = 0
"let g:multi_cursor_quit_key='<Shift><Esc>'
let g:haddock_browser="/usr/bin/palemoon"
"let r_syntax_folding = 1
set foldmethod=syntax
set foldlevel=99
let g:vimtex_latexmk_options="-xelatex"

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

"command W w !sudo tee % > /dev/null
"execute pathogen#infect()
set rtp+=/usr/share/vim/vimfiles/autoload/neobundle.vim 
call neobundle#begin(expand('~/.vim/bundle/'))
NeoBundle 'Shougo/neobundle.vim'
NeoBundle 'fs111/pydoc.vim'
NeoBundle 'reinh/vim-makegreen'
NeoBundle 'vim-scripts/TaskList.vim'
NeoBundle 'alfredodeza/pytest.vim'
NeoBundle 'tacahiroy/ctrlp-funky'
NeoBundle 'jistr/vim-nerdtree-tabs'
NeoBundle 'dag/vim2hs'
NeoBundle 'lukerandall/haskellmode-vim'
NeoBundle 'adinapoli/cumino'
NeoBundle 'bitc/vim-hdevtools'
NeoBundle 'ivanov/vim-ipython'
NeoBundle 'kien/ctrlp.vim'
NeoBundle 'mrtazz/DoxygenToolkit.vim'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'michaeljsmith/vim-indent-object'
NeoBundle 'Valloric/YouCompleteMe'
NeoBundle 'jiangmiao/auto-pairs'
NeoBundle 'wincent/Command-T'
NeoBundle 'tpope/vim-endwise'
NeoBundle 'sjl/gundo.vim'
NeoBundle 'tomasr/molokai'
NeoBundle 'scrooloose/nerdcommenter'
NeoBundle 'jlanzarotta/bufexplorer'
NeoBundle 'nanotech/jellybeans.vim'
NeoBundle 'davidhalter/jedi-vim'
NeoBundle 'fholgado/minibufexpl.vim'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'eiginn/netrw'
NeoBundle 'vim-scripts/OmniCppComplete'
NeoBundle 'amiorin/vim-project'
NeoBundle 'tpope/vim-surround'
NeoBundle 'ervandew/supertab'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'SirVer/ultisnips'
NeoBundle 'honza/vim-snippets'
NeoBundle 'vim-scripts/vcscommand.vim'
NeoBundle 'szw/vim-ctrlspace'
NeoBundle 'tpope/vim-repeat'
NeoBundle 'godlygeek/tabular'
NeoBundle 'majutsushi/tagbar'
NeoBundle 'vim-scripts/taglist.vim'
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'vim-scripts/Color-Sampler-Pack'
NeoBundle 'thinca/vim-guicolorscheme'
NeoBundle 'vim-scripts/JavaDecompiler.vim'
NeoBundle 'vim-scripts/a.vim'
NeoBundle 'rking/ag.vim'
NeoBundle 'mileszs/ack.vim'
NeoBundle 'tpope/vim-commentary'
NeoBundle 'easymotion/vim-easymotion'
NeoBundle 'eagletmt/ghcmod-vim'
NeoBundle 'enomsg/vim-HaskellConcealPlus'
NeoBundle 'Twinside/vim-haskellFold'
NeoBundle 'travitch/hasksyn'
NeoBundle 'vim-jp/vital.vim'
NeoBundle 'nathanaelkane/vim-indent-guides'
NeoBundle 'terryma/vim-multiple-cursors'
NeoBundle 'eagletmt/neco-ghc'
NeoBundle 'kevinw/pyflakes-vim'
NeoBundle 'vim-scripts/sudo.vim'
NeoBundle 'Shougo/vimproc.vim', {
            \ 'build' : {
            \'linux' : 'make'
            \},
        \}
NeoBundle 'Shougo/unite.vim'
NeoBundle 'lervag/vimtex'
NeoBundle 'jcfaria/Vim-R-plugin'
NeoBundle 'christoomey/vim-tmux-navigator'
NeoBundle 'suan/vim-instant-markdown'

call neobundle#end()
NeoBundleCheck
NeoBundleClean
"colorscheme molokai
set background=light
"highlight Normal ctermbg=NONE
"highlight nonText ctermbg=NONE
"highlight LineNr ctermbg=NONE
""hi Visual ctermbg=11
"hi Spellbad ctermbg=1 ctermfg=15
hi Search ctermbg=59
hi Visual ctermfg=0 ctermbg=222

noremap <C-J> <C-W>j
noremap <C-K> <C-W>k
noremap <C-H> <C-W>h
noremap <C-L> <C-W>l
" Lines added by the Vim-R-plugin command :RpluginConfig (2014-Oct-14 16:27):
" Change the <LocalLeader> key:
let maplocalleader = ","
let mapleader= ","
let vimrplugin_term = "urxvt"
let vimrplugin_vimpager = "vertical"
let vimrplugin_help_w = 80
let vimrplugin_assign = 0
let vimrplugin_rconsole_height = 20
"let vimrplugin_vimpager = 
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
