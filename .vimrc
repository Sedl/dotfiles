
execute pathogen#infect()

" remap mapleader to ,
let mapleader = ","
vnoremap <Leader>s :sort<CR>
" use ,, to clear search highlight
noremap <Leader>, :nohlsearch<CR>

" toggle paste mode
noremap <Leader>p :set paste!<CR>

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

set viminfo=%,<100,'100,/50,:100,h,f0

if filereadable(glob("~/.vimrc.local"))
    source ~/.vimrc.local
endif

" Commenting blocks of code.
" Shamelessly stolen and modified from http://stackoverflow.com/questions/1676632/whats-a-quick-way-to-comment-uncomment-lines-in-vim
autocmd FileType c,cpp,java,scala let b:comment_leader = '// '
autocmd FileType sh,ruby,python   let b:comment_leader = '# '
autocmd FileType conf,fstab       let b:comment_leader = '# '
autocmd FileType tex              let b:comment_leader = '% '
autocmd FileType mail             let b:comment_leader = '> '
autocmd FileType vim              let b:comment_leader = '" '
noremap <silent> <Leader>cc :<C-B>silent <C-E>s/^/<C-R>=escape(b:comment_leader,'\/')<CR>/<CR>:nohlsearch<CR>gv
noremap <silent> <Leader>cu :<C-B>silent <C-E>s/^\V<C-R>=escape(b:comment_leader,'\/')<CR>//e<CR>:nohlsearch<CR>gv
