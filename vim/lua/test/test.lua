function TestGmatch()
  local s = "hello,world,from,Lua"
  for w1, w2 in string.gmatch(s, "(%w+),(%w+)") do
    print(w1 .. ": " .. w2)
  end
end

--- expamples below string in new buffer
--index,mike,elsa,wife,
--foo,x,x,-,
--baz,x,-,x,
--fuga,x,x,x,

--@param fpath_row string|string[]
--@param fpath_col string|string[]
function MakeStarMatrix(file_path)
  --fpath_row = vim.fn.expand(fpath_row)
  --fpath_col = vim.fn.expand(fpath_col)
  file_path = vim.fn.expand("~/develop/vim/lua_test/sampleA.csv")
  local file = io.open(file_path, "r")

  if not file then
      print("File not found: " .. file_path)
      return
  end

  local table_by_line = {}

  for line in file:lines() do
    table.insert(table_by_line, line)
  end

  -- data arrangement
  local col1 = CsvToTableTwoCol(table_by_line, 1)
  local col2 = CsvToTableTwoCol(table_by_line, 2)

  local output_row = UniqueTable(col1)
  local output_col = UniqueTable(col2)

  -- output string
  -- header
  local header = "index,"
  for _, str in ipairs(output_col) do
    header = header .. str .. ","
  end

  header = header .. "\n"

  -- body prepare
  local matrix = {}
  for _, row in ipairs(output_row) do
    local tmp_table = {}
    for _, line in ipairs(table_by_line) do
      local t = SplitCSVString(line)
      col1 = t[1]
      col2 = t[2]
      if row == col1 then
        table.insert(tmp_table, col2)
      end
    end
    matrix[row] = tmp_table
  end

  -- body string
  local body = ""
  for _, row in ipairs(output_row) do
    body = body .. row .. ","
    for _, col in ipairs(output_col) do
      if IsCheckMatrix(row, col, matrix) == true then
        body = body .. "x" .. ","
      else
        body = body .. "-" .. ","
      end
    end
    body = body .. "\n"
  end

  local whole_line = header .. body

  -- make buffer & write
  local bufnr = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, vim.split(whole_line, '\n'))
  vim.api.nvim_set_current_buf(bufnr)

  --print(vim.inspect(whole_lines)) -- debug

  file:close()

end



--- examples
--{
--  baz = { "mike", "wife" },
--  foo = { "mike", "elsa" },
--  fuga = { "mike", "elsa", "wife" }
--}
-- target_row: "foo"
-- target_col: "mike"
--   => true
-- target_row: "foo"
-- target_col: "wife"
--   => false



-- @return bool
function IsCheckMatrix(target_row, target_col, matrix)
  for _, v in ipairs(matrix[target_row]) do
    if v == target_col then
      return true
    end
  end

  return false
end

function SplitCSVString(str)
  local values = {}
  for value in str:gmatch("[^,]+") do
      table.insert(values, value)
  end
  return values
end

function TestAweSome()
  local csvString = "foo,bar"
  -- カンマ区切りの文字列を分解して変数に格納
  local elements = SplitCSVString(csvString)

  -- 変数に格納された値を表示
  for i, element in ipairs(elements) do
    print("Variable " .. i .. ": " .. element)
  end
end

function CsvToTableTwoCol(input_table, n_col)
  local t = {}
  if n_col == 1 then
    for _, line in pairs(input_table) do
      for v, _ in string.gmatch(line, "(%w+),(%w+)") do
        table.insert(t, v)
      end
    end
  elseif n_col == 2 then
    for _, line in pairs(input_table) do
      for _, v in string.gmatch(line, "(%w+),(%w+)") do
        table.insert(t, v)
      end
    end
  else
    print("Error: CsvToTableTwoCol function")
  end
  return t
end

function UniqueTable(input_table)
    local uniqueTable = {}
    local resultArray = {}

    for _, value in ipairs(input_table) do
        if not uniqueTable[value] then
            uniqueTable[value] = true
            table.insert(resultArray, value)
        end
    end

    return resultArray
end

-- Experimantal function for me
function CreateBufferWithText()
    local text = "foo \n bar"
    local bufnr = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, vim.split(text, '\n'))
    vim.api.nvim_set_current_buf(bufnr)
end

-- 既存のバッファにテキストを連結する関数
function AppendTextToBuffer(bufnr, text)
    -- 既存のバッファの最終行を取得
    local lines_count = vim.api.nvim_buf_line_count(bufnr)
    local last_line_index = lines_count - 1

    -- 連結するテキストを行に分割して挿入
    local lines_to_append = vim.split(text, '\n')
    vim.api.nvim_buf_set_lines(bufnr, last_line_index, -1, false, lines_to_append)
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


