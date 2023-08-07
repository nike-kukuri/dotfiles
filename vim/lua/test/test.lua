vim.cmd([[
  set rtp^=~/.local/share/nvim/lazy/denops.vim
  set rtp^=~/.local/share/nvim/lazy/ddu.vim
  set rtp^=~/.local/share/nvim/lazy/ddu-ui-ff
  set rtp^=~/.local/share/nvim/lazy/ddu-source-file_rec
  set rtp^=~/.local/share/nvim/lazy/ddu-filter-matcher_substring
  set rtp^=~/.local/share/nvim/lazy/ddu-kind-file

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
    \       'split': 'floating',
    \     }
    \   },
    \ })

  call ddu#custom#patch_global({
    \   'uiParams': {
    \     'ff': {
    \       'startFilter': v:true,
    \     }
    \   },
    \ })

  nnoremap <C-f> <Cmd>call ddu#start({})<CR>

  autocmd FileType ddu-ff call s:ddu_my_settings()
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
  
  autocmd FileType ddu-ff-filter call s:ddu_filter_my_settings()
  function! s:ddu_filter_my_settings() abort
    inoremap <buffer><silent> <CR>
    \ <Esc><Cmd>close<CR>
    nnoremap <buffer><silent> <CR>
    \ <Cmd>close<CR>
    nnoremap <buffer><silent> q
    \ <Cmd>close<CR>
  endfunction

  " &lines	a:winHeight
  " 50		30
  " 63		38
  " 69		42
  " 76		47
  " nnoremap i <Cmd>call ddu#ui#do_action('openFilterWindow')<CR>
]])
