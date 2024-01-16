set nocompatible              " be iMproved, required
filetype off                  " required

call plug#begin()
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
Plug 'ctrlpvim/ctrlp.vim'
Plug 'davidhalter/jedi-vim'
Plug 'ervandew/supertab'
Plug 'preservim/nerdtree'
Plug 'psf/black'
Plug 'hashivim/vim-terraform'
Plug 'mhinz/vim-signify'
Plug 'doums/darcula'
Plug 'altercation/vim-colors-solarized'
Plug 'Kogia-sima/bufftab.vim'
call plug#end()

let g:python3_host_prog="/usr/local/python3/bin/python3"

" set the runtime path to include Vundle and initialize
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on

syntax on
" Use tab for trigger completion with characters ahead and navigate
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config


function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

set number

" NerdTree
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTreeToggle %<CR>
nnoremap <C-f> :NERDTreeFind<CR>

" Jedi
let g:jedi#goto_command = "gd"
augroup black_on_save
  autocmd!
  autocmd BufWritePre *.py Black
augroup end

let g:changes_vcs_check=1
"ctrlp
let g:ctrlp_max_files = 80000
let g:ctlp_show_hidden = 1
"bufftabs
let g:bufftab_numbers=1
set autowriteall
"highlight
let g:go_highlight_extra_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_parameters = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_variable_declarations = 1
let g:coc_disable_startup_warning = 1

nnoremap <Leader>b :ls<CR>:b<Space>
set ttymouse=xterm2
set mouse=a

au filetype go inoremap <buffer> . .<C-x><C-o>
