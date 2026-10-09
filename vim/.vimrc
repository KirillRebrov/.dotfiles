" ==========================================
" 1. VIM PLUGINS (Automatic Bootstrap)
" ==========================================

" Automatic installation of vim-plug if it's missing (perfect for new machines)
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://githubusercontent.com
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
  " Language support and syntax
  Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
  Plug 'sheerun/vim-polyglot'
  
  " Status line interface
  Plug 'vim-airline/vim-airline'
call plug#end()

let g:polyglot_disabled = ['sensible']

" ==========================================
" 2. CORE SETTINGS & UI
" ==========================================
set encoding=utf-8
set fileencoding=utf-8
set number
set relativenumber
set autoindent                 " Minimal automatic indenting for any filetype
set backspace=indent,eol,start " Intuitive backspace behavior
set hidden                     " Possibility to have more than one unsaved buffer
set incsearch                  " Incremental search
set ruler                      " Shows the current line number at the bottom-right
set wildmenu                   " Great command-line completion
set noeb
set ls=2
set visualbell

" Cursor shapes for different modes
let &t_SI = "\<Esc>[6 q" " Insert: Ibeam Cursor
let &t_SR = "\<Esc>[4 q" " Replace: Underline Cursor
let &t_EI = "\<Esc>[2 q" " Normal: Block Cursor

let mapleader = "<space>"

" File management
set directory=~/.vim/swapfiles// " Where Vim stores swap files
filetype plugin indent on       " Enable plugins and indents based on filetype
runtime macros/matchit.vim      " Enable built-in matchit (%)

" Syntax & Colors
syntax on
syntax enable
colorscheme default
highlight Visual ctermfg=white ctermbg=black " For terminal Vim
highlight Visual guifg=#FFFFFF guibg=#000000 " For gVim

" ==========================================
" 3. VIM-GO CONFIGURATION
" ==========================================
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

" Run goimports on every save to format code and fix imports automatically
let g:go_fmt_command = "goimports"
let g:go_auto_type_info = 1

" ==========================================
" 4. AIRLINE STATUS LINE CONFIGURATION
" ==========================================
let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" Powerline symbols for modern terminals (like WezTerm)
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''
