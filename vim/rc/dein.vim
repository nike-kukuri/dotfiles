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


" start plugin read
call dein#begin(s:dein_base)

call dein#add(s:dein_src)

call dein#load_toml('$BASE_DIR/dein.toml', #{ lazy: 0 })
call dein#load_toml('$BASE_DIR/ddc.toml', #{ lazy: 1 })
" call dein#load_toml('$BASE_DIR/ddu.toml', #{ lazy: 1 })
call dein#load_toml('$BASE_DIR/ddu_min.toml', #{ lazy: 1 })
call ddu#custom#patch_global({
    \   'ui': 'ff',
    \   'sources': [{'name': 'file_rec', 'params': {}}],
    \   'sourceOptions': {
    \     '_': {
    \       'matchers': ['matcher_substring'],
    \     },
    \   },
    \   'kindOptions': {
    \     'file': {
    \       'defaultAction': 'open',
    \     },
    \   }
    \ })

call ddu#custom#patch_global({
    \   'uiParams': {
    \     'ff': {
    \       'startFilter': v:true,
    \       'split': 'floating',
    \       'prompt': "> ",
    \       'floatingBorder': "single",
    \       'filterFloatingPosition': "top",
    \       'autoAction': { 'name': "preview" },
    \       'startAutoAction': v:true,
    \       'previewFloating': v:true,
    \       'previewFloatingBorder': "single",
    \       'previewSplit': "horizontal",
    \       'previewFloatingTitle': "Preview",
    \       'highlights': { 'floating': "Normal", 'floatingBorder': "Normal" },
    \     },
    \   },
    \ })

function! s:ddu_my_settings() abort
  nnoremap <buffer><silent> <CR>
        \ <Cmd>call ddu#ui#ff#do_action('itemAction')<CR>
  nnoremap <buffer><silent> <Space>
        \ <Cmd>call ddu#ui#ff#do_action('toggleSelectItem')<CR>
  nnoremap <buffer><silent> i
        \ <Cmd>call ddu#ui#ff#do_action('openFilterWindow')<CR>
  nnoremap <buffer><silent> q
        \ <Cmd>call ddu#ui#ff#do_action('quit')<CR>
endfunction
call dein#load_toml('$BASE_DIR/dein_lazy.toml', #{ lazy: 1 })

" document
call dein#add('vim-jp/vimdoc-ja')
call dein#end()
" end plugin read
call dein#save_state()

" automatically install any plugins
if dein#check_install()
  call dein#install()
endif
