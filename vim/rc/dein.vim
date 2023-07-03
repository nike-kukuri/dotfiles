" if not installed `dein.vim`, install
let $CACHE = '~/.cache'->expand()
if !isdirectory($CACHE)
  call mkdir($CACHE, 'p')
endif

" Install plugin manager Automatically
if &runtimepath !~# '/dein.vim'
  let s:dein_dir = fnamemodify('dein.vim', ':p')
  if !isdirectory(s:dein_dir)
    let s:dein_dir = $CACHE .. '/dein/repos/github.com/Shougo/dein.vim'
    if !isdirectory(s:dein_dir)
      execute $'!git clone https://github.com/Shougo/dein.vim' s:dein_dir
    endif
  endif
  execute 'set runtimepath^=' .. substitute(
        \ fnamemodify(s:dein_dir, ':p') , '[/\\]$', '', '')
endif

"------------------------------------------------------------
" dein configuration
"------------------------------------------------------------

let g:dein#auto_remote_plugins = v:false
let g:dein#enable_notification = v:true
let g:dein#install_check_diff = v:true
let g:dein#install_check_remote_threshold = 24 * 60 * 60
let g:dein#install_progress_type = 'floating'
let g:dein#lazy_rplugins = v:true
let g:dein#types#git#enable_partial_clone = v:true

let g:dein#inline_vimrcs = [
      \ '$BASE_DIR/options.vim',
      \ '$BASE_DIR/keymaps.vim',
      \ ]

" Set dein base path
let s:dein_base = '~/.cache/dein/'

" Set dein source path
let s:dein_src = '~/.cache/dein/repos/github.com/Shougo/dein.vim'

" Set dein runtime path
execute 'set runtimepath+=' .. s:dein_src

call dein#begin(s:dein_base)

call dein#add(s:dein_src)

call dein#add('itchyny/lightline.vim')

" color scheme
call dein#add('EdenEast/nightfox.nvim')

" filer
call dein#add('lambdalisue/fern.vim')
call dein#add('lambdalisue/fern-renderer-nerdfont.vim')
call dein#add('lambdalisue/nerdfont.vim')

" parenthesis auto completion
call dein#add('cohama/lexima.vim')

" denops
call dein#add('vim-denops/denops.vim')

" lsp
call dein#add('prabirshrestha/vim-lsp')
call dein#add('mattn/vim-lsp-settings')

" popup
call dein#add('Shougo/pum.vim')

" call dein#load_toml('$BASE_DIR/')
" --- ddc plugins --- {{{
" ddc main
call dein#add('Shougo/ddc.vim')

" ddc-source
call dein#add('Shougo/ddc-source-around')
call dein#add('Shougo/ddc-source-vim-lsp')

" ddc-filter
call dein#add('Shougo/ddc-matcher_head')
call dein#add('Shougo/ddc-sorter_rank')
call dein#add('Shougo/ddc-converter_remove_overlap')
call dein#add('tani/ddc-fuzzy')

" ddc-ui
call dein#add('Shougo/ddc-ui-native')
call dein#add('Shougo/ddc-ui-pum')

" --- ddc plugins --- }}}

" --- ddu plugins --- {{{
" ddu main
call dein#add('Shougo/ddu.vim')

" ddu ui
call dein#add('Shougo/ddu-ui-ff')

" ddu source
call dein#add('shun/ddu-source-rg')
call dein#add('Shougo/ddu-source-file_rec')

" ddu filter
call dein#add('Shougo/ddu-filter-matcher_substring')
call dein#add('Shougo/ddu-ui-filer')
call dein#add('yuki-yano/ddu-filter-fzf')

" ddu kind
call dein#add('Shougo/ddu-kind-file')

" --- ddu plugins --- }}}

" convenient tools
call dein#add('thinca/vim-quickrun')
call dein#add('thinca/vim-qfreplace')

" document
call dein#add('vim-jp/vimdoc-ja')
call dein#end()

if dein#check_install()
  call dein#install()
endif

