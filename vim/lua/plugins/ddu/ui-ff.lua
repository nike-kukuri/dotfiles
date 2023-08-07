return {
  {
    "Shougo/ddu-ui-ff",
    dependencies = "Shougo/ddu.vim",
    config = function()
vim.cmd([[
nnoremap <Leader>zf <Cmd>call ddu#start({})<CR>

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
    \       'previewFloatingBorder': "rounded",
    \       'previewSplit': "vertical",
    \       'previewFloatingTitle': "Preview",
    \       'highlights': { 'floating': "Normal", 'floatingBorder': "Normal" },
    \       'winCol': &columns / 9,
    \       'winWidth': &columns / 10 * 3,
    \       'winRow': &lines / 8,
    \       'winHeight': &lines / 10 * 9,
    \       'previewWidth': &columns / 10 * 5,
    \       'previewHeight': &lines / 10 * 9,
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

]])
    end,
  },
}

