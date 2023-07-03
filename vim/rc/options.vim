" --- setup options ---
syntax enable
filetype plugin indent on
set cursorline
set scrolloff=100
set expandtab
set smarttab
set smartindent
set autoindent
set incsearch
set ignorecase
set smartcase
set wildmenu
set showmatch
set matchtime=1
set completeopt=menu,menuone,preview
set matchpairs& matchpairs+=<:>
set noshowmode
set undolevels=1000
set helplang=ja,en
set autowrite 
set noswapfile
set laststatus=2
set showtabline=1
set wildcharm=<Tab> " enable <Tab> in cnnoremap <expr> 
set backspace=indent,eol,start " Allow backspace over everything

" grep
if executable('rg')
  set grepprg=rg\ --vimgrep
endif
set grepformat='%f:%l:%c:%m'

" indent
set tabstop=2 shiftwidth=2 softtabstop=2

" clipboard
set clipboard&
if has('mac') || has('win32') || has('win64')
  set clipboard^=unnamed
else
  set clipboard^=unnamedplus
endif

augroup fileTypeIndent
  autocmd!
  autocmd FileType go setlocal tabstop=4 shiftwidth=4
  autocmd FileType vim setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab
  autocmd FileType php setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab
  autocmd FileType html setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab
  autocmd FileType javascript,javascriptreact setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab
  autocmd FileType typescript,typescriptreact setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab
  autocmd FileType vue  setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab
  autocmd FileType yaml setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab
  autocmd FileType json setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab
  autocmd FileType sh setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab
  autocmd FileType fish setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab
  autocmd FileType zsh setlocal tabstop=2 shiftwidth=2 expandtab
  autocmd FileType rust setlocal tabstop=4 softtabstop=4 shiftwidth=4 expandtab
  autocmd FileType markdown setlocal tabstop=2 shiftwidth=2 expandtab
  autocmd FileType make setlocal tabstop=8 softtabstop=8 shiftwidth=8 noexpandtab
augroup END

" Automatically open quickfix/locationlist
augroup my_quickfix
  autocmd!
  autocmd QuickFixCmdPost [^l]* nested cwindow
  autocmd QuickFixCmdPost l* nested lwindow
augroup END
