
" remap mapleader to ,
let mapleader = ","
vnoremap <Leader>s :sort<CR>
" use ,, to clear search highlight
noremap <Leader>, :nohlsearch<CR>

set showcmd

filetype plugin indent on
syntax on


set tabstop=4
set shiftwidth=4
set shiftround
set expandtab

autocmd BufRead *.py set ts=4 sw=4 sta et sts=4 ai
autocmd BufRead *.php set ts=4 sw=4 sta et sts=4 ai syntax=php.doxygen
autocmd BufRead *.html,*.xml set ts=2 sw=2 sta et sts=2 ai
autocmd BufRead Makefile* set noexpandtab


let g:netrw_list_hide= '.*\.pyc$'

" highlight whitespace characters at end of line
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

set backup
set backupdir=~/.vimbackup
set dir=~/.vimbackup


" don't lose visual while indentation
vnoremap < <gv
vnoremap > >gv


set number
set tw=79
set nowrap
set fo-=t
set colorcolumn=80
highlight ColorColumn ctermbg=233

set hlsearch
set incsearch
set ignorecase
set smartcase

set background=dark
