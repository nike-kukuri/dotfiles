if vim.fn.has('nvim') == 1 then
  require('init_win')
else
  require('init_darwin_linux')
end
