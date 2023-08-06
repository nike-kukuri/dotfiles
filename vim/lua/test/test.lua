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

  nnoremap <C-f> <Cmd>call ddu#start({})<CR>

  ""function Start(winHeight) abort
  ""  call ddu#start(#{
  ""        \ ui: 'ff',
  ""        \ uiParams: #{
  ""        \   ff: #{ winHeight: a:winHeight },
  ""        \ },
  ""        \ })
  ""endfunction

  " &lines	a:winHeight
  " 50		30
  " 63		38
  " 69		42
  " 76		47
  nnoremap i <Cmd>call ddu#ui#do_action('openFilterWindow')<CR>
]])
