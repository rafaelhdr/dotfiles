
call plug#begin()
" Packages
Plug 'preservim/nerdtree'
Plug 'ryanoasis/vim-devicons'

Plug 'plasticboy/vim-markdown'
Plug 'stephpy/vim-yaml'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }
Plug 'eslint/eslint'
Plug 'leafgarland/typescript-vim'
Plug 'preservim/tagbar'  " F8

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'  " Search using :Rg

Plug 'tpope/vim-commentary'  " Comment w/ gcc (or select and gc)
call plug#end()

" python options
let g:pymode_lint_ignore = ["E501", "W605", "C901"]
let g:pymode_rope_autoimport = 1

" vim markdown options
let g:vim_markdown_folding_disabled = 1
set conceallevel=0

" NERDTree
" Open NERDTree if run 'vim'
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree
let NERDTreeIgnore = ['\.pyc$']
let NERDTreeCustomOpenArgs={'file':{'where': 't'}}
set encoding=UTF-8

" Indentation
autocmd FileType javascript set breakindentopt=shift:2
au Filetype javascript.jsx set expandtab shiftwidth=2 softtabstop=2
autocmd BufRead,BufNewFile *.tsx,*.ts setlocal expandtab shiftwidth=2 softtabstop=2
autocmd FileType json setlocal expandtab shiftwidth=2 softtabstop=2
autocmd BufRead,BufNewFile *.php,*.htm,*.html setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4

" Commands
ca tc tabclose
ca tm tabmove
ca tn tabnew

" Tagbar
nmap <F8> :TagbarToggle<CR>

" Other configurations
set incsearch
set hlsearch
syntax on
