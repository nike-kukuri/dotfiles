" dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=/Users/yamasotokeita/.cache/dein/repos/github.com/Shougo/dein.vim

" Required:
call dein#begin('/Users/yamasotokeita/.cache/dein')

" Let dein manage dein
" Required:
call dein#add('/Users/yamasotokeita/.cache/dein/repos/github.com/Shougo/dein.vim')

" Add or remove your plugins here like this:
"call dein#add('Shougo/neosnippet.vim')
"call dein#add('Shougo/neosnippet-snippets')

" Required:
call dein#end()

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
"if dein#check_install()
"  call dein#install()
"endif

"End dein Scripts-------------------------


" keymap
inoremap <silent> jj <ESC>
let g:mapleader = "\<Space>"

" space + w : save file
" スペース＋wでファイル保存
nnoremap <Leader>w :w<CR>
" Escを２回押すとハイライトを消す
nnoremap <Esc><Esc> :nohlsearch<CR>
" スペース＋.でvimrcを開く
nnoremap <Leader>. :new ~/.vimrc<CR>
" Home / End
noremap <Leader>h ^
noremap <Leader>H 0
noremap <Leader>l $
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

" line number
set number
set relativenumber
set cursorline

" tab
set shiftwidth=4
set tabstop=4

" auto indent
set smartindent
set autoindent

set incsearch
set wildmenu

" =========================
" dein.vim settings {{{
" =========================
" install dir {{{
let s:dein_dir = expand('~/.cache/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
" }}}

" dein installation check {{{
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . s:dein_repo_dir
endif
" }}}

" begin settings {{{
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  " .toml file
  let s:rc_dir = expand('~/.vim')
  if !isdirectory(s:rc_dir)
    call mkdir(s:rc_dir, 'p')
  endif
  let s:toml = s:rc_dir . '/dein.toml'

  " read toml and cache
  call dein#load_toml(s:toml, {'lazy': 0})

  " end settings
  call dein#end()
  call dein#save_state()
endif
" }}}

" plugin installation check {{{
if dein#check_install()
  call dein#install()
endif
" }}}

" plugin remove check {{{
let s:removed_plugins = dein#check_clean()
if len(s:removed_plugins) > 0
  call map(s:removed_plugins, "delete(v:val, 'rf')")
  call dein#recache_runtimepath()
endif
" }}}

call dein#add('vim-airline/vim-airline')
call dein#add('vim-airline/vim-airline-themes')

" vim-airline/vim-airline {{{
" let g:airline_theme = 'simple'
set laststatus=2
" Show branch name
let g:airline_theme = 'simple'
let g:airline#extensions#branch#enabled = 1
let g:airline_powerline_fonts = 1
" let g:airline_theme = 'deus'
" let g:airline_deus_bg = 'dark'
let g:airline#extensions#tabline#enabled = 1

nmap <C-p> <Plug>AirlineSelectPrevTab
nmap <C-n> <Plug>AirlineSelectNextTab

let g:molokai_original = 1

syntax enable
colorscheme molokai
