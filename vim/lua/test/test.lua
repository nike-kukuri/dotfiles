function test_gmatch()
  local s = "hello,world,from,Lua"
  for w1, w2  in string.gmatch(s, "(%w+),(%w+)") do
    print(w1 .. ": " .. w2)
  end
end

--@param fpath_row string|string[]
--@param fpath_col string|string[]
function make_star_matrix(fpath_row, fpath_col)
  fpath_row = vim.fn.expand(fpath_row)
  fpath_col = vim.fn.expand(fpath_col)
  local file_row = io.open(fpath_row, "r")
  local file_col = io.open(fpath_col, "r")

  if not file_row then
      print("File not found: " .. fpath_row)
      return
  end
  if not file_col then
      print("File not found: " .. fpath_col)
      return
  end

  local col = {}

  for line in file_row:lines() do
    table.insert(col, line)
  end

  file_row:close()
  file_col:close()

  local variables = {}
  for _, line in pairs(col) do
    for key, value in string.gmatch(line, "(%w+),(%w+)") do
      table.insert(variables, key .. ": " .. value)  -- debug
    end
  end

  print(vim.inspect(variables))
end


vim.cmd([[
set rtp^=~/.local/share/nvim/lazy/denops.vim
set rtp^=~/.local/share/nvim/lazy/ddu.vim
set rtp^=~/.local/share/nvim/lazy/ddu-ui-ff
set rtp^=~/.local/share/nvim/lazy/ddu-source-file_rec
set rtp^=~/.local/share/nvim/lazy/ddu-filter-matcher_substring
set rtp^=~/.local/share/nvim/lazy/ddu-kind-file

nnoremap <C-f> <Cmd>call ddu#start({})<CR>

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
    \       'previewSplit': "vertical",
    \       'previewFloatingTitle': "Preview",
    \       'highlights': { 'floating': "Normal", 'floatingBorder': "Normal" },
    \       'winCol': &columns / 6,
    \       'winWidth': &columns / 3,
    \       'winRow': &lines / 6,
    \       'winHeight': &lines / 3 * 2,
    \       'previewWidth': &columns / 3,
    \       'previewHeight': &lines / 3 * 2,
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

--vim.cmd([[
--  set rtp^=~/.local/share/nvim/lazy/denops.vim
--  set rtp^=~/.local/share/nvim/lazy/ddu.vim
--  set rtp^=~/.local/share/nvim/lazy/ddu-ui-ff
--  set rtp^=~/.local/share/nvim/lazy/ddu-source-file_rec
--  set rtp^=~/.local/share/nvim/lazy/ddu-filter-matcher_substring
--  set rtp^=~/.local/share/nvim/lazy/ddu-kind-file
--
--  call ddu#custom#patch_global({
--    \   'ui': 'ff',
--    \   'sources': [{'name': 'file_rec', 'params': {}}],
--    \   'sourceOptions': {
--    \     '_': {
--    \       'matchers': ['matcher_substring'],
--    \     },
--    \   },
--    \   'kindOptions': {
--    \     'file': {
--    \       'defaultAction': 'open',
--    \     },
--    \   }
--    \ })
--
--  call ddu#custom#patch_global({
--    \   'uiParams': {
--    \     'ff': {
--    \       'split': 'floating',
--    \     }
--    \   },
--    \ })
--
--  call ddu#custom#patch_global({
--    \   'uiParams': {
--    \     'ff': {
--    \       'startFilter': v:true,
--    \     }
--    \   },
--    \ })
--
--  nnoremap <C-f> <Cmd>call ddu#start({})<CR>
--
--  autocmd FileType ddu-ff call s:ddu_my_settings()
--  function! s:ddu_my_settings() abort
--    nnoremap <buffer><silent> <CR>
--          \ <Cmd>call ddu#ui#ff#do_action('itemAction')<CR>
--    nnoremap <buffer><silent> <Space>
--          \ <Cmd>call ddu#ui#ff#do_action('toggleSelectItem')<CR>
--    nnoremap <buffer><silent> i
--          \ <Cmd>call ddu#ui#ff#do_action('openFilterWindow')<CR>
--    nnoremap <buffer><silent> q
--          \ <Cmd>call ddu#ui#ff#do_action('quit')<CR>
--  endfunction
--  
--  autocmd FileType ddu-ff-filter call s:ddu_filter_my_settings()
--  function! s:ddu_filter_my_settings() abort
--    inoremap <buffer><silent> <CR>
--    \ <Esc><Cmd>close<CR>
--    nnoremap <buffer><silent> <CR>
--    \ <Cmd>close<CR>
--    nnoremap <buffer><silent> q
--    \ <Cmd>close<CR>
--  endfunction
--
--  " &lines	a:winHeight
--  " 50		30
--  " 63		38
--  " 69		42
--  " 76		47
--  " nnoremap i <Cmd>call ddu#ui#do_action('openFilterWindow')<CR>
--]])

--autocmd FileType ddu-ff call s:ddu_my_settings()
--function! s:ddu_my_settings() abort
--  setlocal cursorline
--  nnoremap <buffer><silent> <CR>
--        \ <Cmd>call ddu#ui#ff#do_action('itemAction')<CR>
--  nnoremap <buffer><silent> <Space>
--        \ <Cmd>call ddu#ui#ff#do_action('toggleSelectItem')<CR>
--  nnoremap <buffer><silent> i
--        \ <Cmd>call ddu#ui#ff#do_action('openFilterWindow')<CR>
--  nnoremap <buffer><silent> q
--        \ <Cmd>call ddu#ui#ff#do_action('quit')<CR>
--  nnoremap <buffer><silent> p
--        \ <Cmd>call ddu#ui#ff#do_action('preview')<CR>
--  inoremap <buffer><silent> <Esc>
--        \ <Cmd>call ddu#ui#ff#do_action('quit')<CR>
--endfunction
--
--autocmd FileType ddu-ff-filter call s:ddu_filter_my_settings()
--function! s:ddu_filter_my_settings() abort
--	inoremap <buffer> <CR>
--				\ <Cmd>call ddu#ui#ff#do_action('itemAction', { 'name' : 'open' })<CR>
--	inoremap <buffer> <C-o>
--				\ <Cmd>call ddu#ui#ff#do_action('itemAction', { 'name' : 'open', 'params' : { 'command' : 'split'} })<CR>
--	inoremap <buffer> <C-v>
--				\ <Cmd>call ddu#ui#ff#do_action('itemAction', { 'name' : 'open', 'params' : { 'command' : 'vsplit'} })<CR>
--	inoremap <buffer> <C-t>
--				\ <Cmd>call ddu#ui#ff#do_action('itemAction', { 'name' : 'open', 'params' : { 'command' : 'tabnew'} })<CR>
--	inoremap <buffer> <C-s>
--				\ <Cmd>call ddu#ui#ff#do_action('toggleSelectItem')<CR>
--	inoremap <buffer> <C-n>
--				\ <Cmd>call ddu#ui#ff#execute("call cursor(line('.')+1,0)<Bar>redraw")<CR>
--	inoremap <buffer> <C-p>
--				\ <Cmd>call ddu#ui#ff#execute("call cursor(line('.')-1,0)<Bar>redraw")<CR>
--	inoremap <buffer> q
--				\ <Cmd>call ddu#ui#ff#do_action('quit')<CR>
--endfunction
--
--nnoremap <C-p> <Cmd>Ddu
--      \ -name=files file
--      \ -source-option-path=`expand('$BASE_DIR')`
--      \ <CR>
--
--nnoremap <silent> <C-3> <Cmd>call ddu#start(#{
--      \ name: 'file',
--      \ ui: 'ff',
--      \ sync: v:true,
--      \ input: getcmdline()[: getcmdpos() - 2]->match('\f*$') + 1,
--      \ sources: [
--      \   #{ name: 'file', options: #{ defaultAction: 'feedkeys' } },
--      \ ],
--      \ uiParams: #{
--      \   ff: #{
--      \     startFilter: v:true,
--      \     replaceCol: getcmdline()[: getcmdpos() - 2]->match('\f*$') + 1,
--      \   },
--      \ },
--      \ })<CR><Cmd>call setcmdline('')<CR><CR>


--call ddu#custom#patch_global(#{
--        \ ui: 'ff',
--        \ sources: [
--        \   #{ 
--        \       name: 'file_rec',
--        \       params: {
--        \         'ignoredDirectories': ['.git', 'node_modules', 'vendor'],
--        \       },
--        \   },
--        \ ],
--        \ sourceOptions: #{
--        \   _: #{
--        \     matchers: ['matcher_substring'],
--        \   },
--        \   channel: #{
--        \     columns: ['filename'],
--        \   },
--        \ },
--        \ uiParams: #{
--        \   ff: #{
--        \     startFilter: v:true,
--        \     split: 'horizontal',
--        \     prompt: '> ',
--        \     autoAction: #{ name: 'preview' },
--        \     filterFloatingPosition: 'top',
--        \     highlights: #{
--        \       floating: 'Normal',
--        \       floatingBorder: 'Normal',
--        \     },
--        \     ignoreEmpty: v:true,
--        \   },
--        \ },
--        \ filterParams: #{
--        \   matcher_substring: #{
--        \     highlightMatched: 'Title',
--        \   },
--        \ },
--        \ kindOptions: #{
--        \   file: #{
--        \     defaultAction: 'open',
--        \   },
--        \ }
--        \ })


