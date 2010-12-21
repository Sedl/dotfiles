set tabstop=4
set nu
set shiftwidth=4
set expandtab

autocmd BufRead *.py set ts=4 sw=4 sta et sts=4 ai
autocmd BufRead *.php set ts=4 sw=4 sta et sts=4 ai syntax=php.doxygen
autocmd BufRead *.html set ts=2 sw=2 sta et sts=2 ai

let g:netrw_list_hide= '.*\.pyc$'
