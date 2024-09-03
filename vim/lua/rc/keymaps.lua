-- text object shortcuts
omap('\'', 'i\'')
omap('"', 'i"')
omap('9', 'i(')
omap('[', 'i[')
omap('{', 'i{')
omap('a9', 'a(')

nmap('v9', 'vi(')
nmap('v[', 'vi[')
nmap('v{', 'vi{')
nmap('va9', 'va(')

-- easier to type than `ct`
nmap('cm', 'ct')

-- emacs like
imap('<C-k>', '<C-o>C')
imap('<C-f>', '<Right>')
imap('<C-b>', '<Left>')
imap('<C-e>', '<C-o>A')
imap('<C-a>', '<C-o>I')
vmap('<M-w>', '"+y')
nmap('<M-v>', '"+P')
imap('<M-h>', '<C-w>')

-- toggle comment
vim.api.nvim_set_keymap('i', '<C-q>', '<C-o>gcc', {})

nmap('\'', ':', {})
xmap('\'', ':', {})

-- Open in VSCode
nmap('<Leader>o', function()
  local current_file = fn.expand('%:p')
  local current_line = fn.line('.')
  fn.system('code --goto ' .. current_file .. ':' .. current_line)
end, { expr = true })

xmap("*",
  table.concat {
    -- Store selected region to "m register
    -- Escape visual mode here
    [["my]],
    -- Search "m register
    -- Necessary characters must be escaped, and spaces must be expandable.
    [[/\V<C-R><C-R>=substitute(escape(@m, '/\'), '\_s\+', '\\_s\\+', 'g')<CR><CR>]],
    -- Cursor move to original position
    [[N]],
  },
  {}
)

-- help
api.nvim_create_autocmd("FileType", {
  pattern = "help",
  command = "nnoremap <buffer> <silent>q :bw!<CR>",
  group = api.nvim_create_augroup("helpKeymaps", { clear = true }),
})

-- command line
-- cmap defaults silent to true, but passes an empty setting because the cursor is not updated
cmap('<C-b>', '<Left>', {})
cmap('<C-f>', '<Right>', {})
cmap('<C-a>', '<Home>', {})
cmap('<Up>', '<C-p>')
cmap('<Down>', '<C-n>')
cmap('<C-n>', function()
  return fn.pumvisible() == 1 and '<C-n>' or '<Down>'
end, { expr = true })
cmap('<C-p>', function()
  return fn.pumvisible() == 1 and '<C-p>' or '<Up>'
end, { expr = true })
api.nvim_create_autocmd('FileType', {
  pattern = 'qf',
  callback = function()
    nmap('q', '<Cmd>q<CR>', { silent = true, buffer = true })
  end,
  group = api.nvim_create_augroup("qfInit", { clear = true }),
})

-- paste with <C-v>
map({ 'c', 'i' }, '<C-v>', 'printf("<C-r><C-o>%s", v:register)', { expr = true })

-- other keymap
local is_other_than_win = require('rc.utils').is_other_than_win()
if is_other_than_win then
  nmap('<Leader>.', ':tabnew ~/.config/nvim/init.lua<CR>')
else
  nmap('<Leader>.', ':tabnew ~/AppData/Local/nvim<CR>')
end

-- Disable "ZZ" & "ZQ" to quit
nmap('ZZ', '<Nop>')
nmap('ZQ', '<Nop>')

-- Disalbe 's' to substitute character on cursor
nmap('s', '<Nop>')

nmap('j', 'gj') -- move to visual line
nmap('k', 'gk') -- move to visual line
nmap('H', '^')  -- move to first character
nmap('L', 'g_') -- move to last character in visual line
nmap('R', 'gR') -- virtual replace
nmap('*', '*N') -- search under cursor word and return cursor to original position

-- Do NOT add register by using black hole register
nmap('x', '"_x')
nmap('s', '"_s')
nmap('c', '"_c')

nmap('<Esc><Esc>', '<Cmd>nohlsearch<CR>')

-- Do NOT add jumplist to move by <C-d>, <C-u>, { and }
nmap('<C-d>', '<Cmd>keepjumps normal! <C-d><CR>')
nmap('<C-u>', '<Cmd>keepjumps normal! <C-u><CR>')
vmap('<C-d>', '<Cmd>keepjumps normal! <C-d><CR>')
vmap('<C-u>', '<Cmd>keepjumps normal! <C-u><CR>')
nmap('<C-j>', '<Cmd>keepjumps normal! }<CR>')
nmap('<C-k>', '<Cmd>keepjumps normal! {<CR>')
vmap('<C-j>', '<Cmd>keepjumps normal! }<CR>')
vmap('<C-k>', '<Cmd>keepjumps normal! {<CR>')

nmap('<Leader><Tab>', '%')

-- Window manipulation
nmap('sv', ':vsplit<CR>')
nmap('ss', ':split<CR>')
nmap('sh', '<C-w>h')
nmap('sj', '<C-w>j')
nmap('sk', '<C-w>k')
nmap('sl', '<C-w>l')

nmap('[b', '<Cmd>bnext<CR>')
nmap(']b', '<Cmd>bprevious<CR>')
nmap('<', '<<')
nmap('>', '>>')
omap('H', '^')
omap('L', 'g_')
omap('<Tab>', '%')
nmap('<C-l>', 'gt')
nmap('<C-h>', 'gT')
nmap('<Leader>tt', [[:tabnew | terminal<CR>]])
tmap('<C-]>', [[<C-\><C-n>]])
vmap('H', '^')
vmap('L', 'g_')
vmap('<Tab>', '%')

--
vim.cmd [[
function! s:blank_above(type = '') abort
  if a:type == ''
    set operatorfunc=function('s:blank_above')
    return 'g@ '
  endif

  put! =repeat(nr2char(10), v:count1)
  normal! '[
endfunction

function! s:blank_below(type = '') abort
  if a:type == ''
    set operatorfunc=function('s:blank_below')
    return 'g@ '
  endif

  put =repeat(nr2char(10), v:count1)
endfunction

nnoremap <expr> ]<Space> <sid>blank_below()
nnoremap <expr> [<Space> <sid>blank_above()
]]


nmap('<Leader><Leader>', '<Cmd>call ToggleCheckBox()<CR>')
vmap('<Leader><Leader>', '<Cmd>call ToggleCheckBox()<CR>')

cmd [[
function! ToggleCheckBox()
  let l:line = getline('.')
  if l:line =~ '\-\s\[\s\]'
    let l:result = substitute(l:line, '-\s\[\s\]', '- [x]', '')
    call setline('.', l:result)
  elseif l:line =~ '\-\s\[x\]'
    let l:result = substitute(l:line, '-\s\[x\]', '- [ ]', '')
    call setline('.', l:result)
  end
endfunction
]]
