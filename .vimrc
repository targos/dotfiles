set backspace=indent,eol,start

set splitright

set mouse=a

syntax enable

" Indentation stuff
set expandtab
set shiftwidth=2
set softtabstop=2
set autoindent
filetype plugin indent on

" Show line numbers
set number
autocmd BufNewFile,BufRead .*,COMMIT_EDITMSG set nonumber
