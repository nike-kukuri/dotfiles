M = {}

function M.create_cmd(name, impl, options)
  if options == nil then
    options = {}
  end
  vim.api.nvim_create_user_command(name, impl, options)
end

function M.is_other_than_win()
  if vim.fn.has('wsl') then
    return true
  else
    if vim.fn.has('win32') then
      return true
    else
      return false
    end
  end
end

return M
