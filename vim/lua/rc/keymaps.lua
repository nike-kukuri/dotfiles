-- text object
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

-- disable auto comment 
imap('<C-;>', '<C-o>cc')

nmap('\'', ':', {})
xmap('\'', ':', {})

xmap("*",
  table.concat {
    -- 選択範囲を検索クエリに用いるため、m レジスタに格納。
    -- ビジュアルモードはここで抜ける。
    [["my]],
    -- "m レジスタの中身を検索。
    -- ただし必要な文字はエスケープした上で、空白に関しては伸び縮み可能とする
    [[/\V<C-R><C-R>=substitute(escape(@m, '/\'), '\_s\+', '\\_s\\+', 'g')<CR><CR>]],
    -- 先ほど検索した範囲にカーソルが移るように、手前に戻す
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
nmap('<Leader>.', ':tabnew ~/.config/nvim/init.lua<CR>')

nmap('j', 'gj')
nmap('k', 'gk')
nmap('R', 'gR')
nmap('*', '*N')
nmap('x', '"_x')
nmap('s', '"_s')
nmap('c', '"_c')
nmap('<Esc><Esc>', '<Cmd>nohlsearch<CR>')
nmap('H', '^')
nmap('L', 'g_')
nmap('<C-j>', '}')
nmap('<C-k>', '{')
vmap('<C-j>', '}')
vmap('<C-k>', '{')
nmap('<Leader><Tab>', '%')
nmap('sv', ':vsplit<CR>')
nmap('ss', ':split<CR>')
nmap('sh', '<C-w>h')
nmap('sj', '<C-w>j')
nmap('sk', '<C-w>k')
nmap('sl', '<C-w>l')
nmap('[b', '<Cmd>bnext<CR>')
nmap(']b', '<Cmd>bprevious<CR>')
nmap('[ ', 'O<ESC>cc<ESC>')
nmap('] ', 'o<ESC>cc<ESC>')
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
