"--- keymap ---
inoremap <silent> <C-j> <ESC>
let g:mapleader = "\<Space>"

" スペース＋wでファイル保存
nnoremap <Leader>w :w<CR>

" Escを２回押すとハイライトを消す
nnoremap <Esc><Esc> :nohlsearch<CR> " スペース＋.でvimrcを開く
nnoremap <Leader>. :new ~/.vimrc<CR>

" Home / End
noremap <Leader>h ^
noremap <Leader>H 0
noremap <Leader>l $

" lsp setting

" move pair ()
nnoremap <Leader>m %

if filereadable(expand('~/.vim/vimrc_parenthesis.plugin'))
  source ~/.vim/vimrc_parenthesis.plugin
endif


" Ctrl + j & Ctrl + k で段落前後移動
nnoremap <C-j> }
nnoremap <C-k> {

" 画面分割
nnoremap <Leader><Tab> <C-w>w
nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l
nnoremap sh <C-w>h
nnoremap ss :<C-u>sp<CR><C-w>j
nnoremap sv :<C-u>vs<CR><C-w>l

" lsp 定義ジャンプなど
nmap <silent> <Leader>d :LspDefinition<CR>
nmap <silent> <Leader>p :LspHover<CR>
nmap <silent> <Leader>r :LspReferences<CR>
nmap <silent> <Leader>i :LspImplementation<CR>
nmap <silent> <Leader>s :split \| :LspDefinition <CR>
nmap <silent> <Leader>v :vsplit \| :LspDefinition <CR>
nnoremap <silent> ]e  :LspNextError<CR>
nnoremap <silent> [e  :LspPreviousError<CR> 
nnoremap <silent> ]w  :LspNextWarning<CR>
nnoremap <silent> [w  :LspPreviousWarning<CR> 

" line number
set number
set relativenumber
set cursorline

" tab
set expandtab
set tabstop=4
set shiftwidth=4

" when you open Makefile, noexpandtab
let _curfile=expand("%:r")
if _curfile == 'Makefile'
  set noexpandtab
endif

" auto indent
set smartindent
set autoindent

set incsearch
set wildmenu

filetype plugin indent on

" highlight pair () 
set showmatch
set matchtime=1
set matchpairs& matchpairs+=<:>

" if you have not already installed lightline, commenn out.
set noshowmode

let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()

Plug 'ghifarit53/tokyonight-vim'
Plug 'itchyny/lightline.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'thinca/vim-quickrun'

call plug#end()

" set lightline
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'component_function': {
      \   'filename': 'LightlineFilename',
      \ },
      \ }

function! LightlineFilename()
  return &filetype ==# 'vimfiler' ? vimfiler#get_status_string() :
        \ &filetype ==# 'unite' ? unite#get_status_string() :
        \ &filetype ==# 'vimshell' ? vimshell#get_status_string() :
        \ expand('%:t') !=# '' ? expand('%:t') : '[No Name]'
endfunction

let g:unite_force_overwrite_statusline = 0
let g:vimfiler_force_overwrite_statusline = 0
let g:vimshell_force_overwrite_statusline = 0

"set termguicolors
"let g:tokyonight_style = 'storm' " available: night, storm
"let g:lightline = {'colorscheme' : 'tokyonight'}

" set quickrun config
nnoremap <Leader>q :QuickRun<CR>
let g:quickrun_config = get(g:, 'quickrun_config', {})
let g:quickrun_config._ = {
      \ 'outputter/buffer/opener': 'new',
      \ 'outputter/buffer/into': 1,
      \ 'outputter/buffer/close_on_empty': 1,
      \ }

"colorscheme tokyonight
syntax enable
