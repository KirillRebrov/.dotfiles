" VIMrc.

let &t_SI = "\<Esc>[6 q" " Normal: Block kursor
let &t_SR = "\<Esc>[4 q" " Insert: Ibeam Cursor
let &t_EI = "\<Esc>[2 q" " Replace: Under Cursor
let mapleader = "<space>"

filetype plugin indent on " on/off Plugins.
" `matchit.vim` is built-in so let's enable it!
" Hit `%` on `if` to jump to `else`.
runtime macros/matchit.vim

" Enable syntax highlighting
syntax on
syntax enable

colorscheme default
highlight Visual ctermfg=white ctermbg=black " For terminal Vim
highlight Visual guifg=#FFFFFF guibg=#000000 " For gVim

" Customize vim-go highlighting options
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

" various settings
set encoding=utf-8
set noeb
set ls=2
set fileencoding=utf-8
set number
set relativenumber
set visualbell
set autoindent                 " Minimal automatic indenting for any filetype.
set backspace=indent,eol,start " Intuitive backspace behavior.
set hidden                     " Possibility to have more than one unsaved buffers.
set incsearch                  " Incremental search, hit `<CR>` to stop.
set ruler                      " Shows the current line number at the bottom-right
                               " of the screen.
set wildmenu                   " Great command-line completion, use `<Tab>` to move
                               " around and `<CR>` to validate.
set directory=~/.vim/swapfiles// " where Vim stores swap files.
" set noswapfile " disable swap files entirely.

		" Vim plugins

function! s:packager_init(packager) abort
	call a:packager.add('sheerun/vim-polyglot')
endfunction

let g:polyglot_disabled = ['sensible']

" go-vim plugin specific commands.
" Also run `goimports` on your current file on every save.
" Might be be slow on large codebases, if so, just comment it out.
let g:go_fmt_command = "goimports"

" Status line types/signatures.
let g:go_auto_type_info = 1

"au filetype go inoremap <buffer> . .<C-x><C-o>

" If you want to disable gofmt on save
" let g:go_fmt_autosave = 0
" air-line plugin specific commands
let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'

" airline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''
