local lsp_on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  client.server_capabilities.semanticTokensProvider = nil
  --api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  local bufopts = { silent = true, buffer = bufnr }
  nmap('gd', vim.lsp.buf.definition, bufopts)
  nmap('gi', vim.lsp.buf.implementation, bufopts)
  nmap('gr', vim.lsp.buf.references, bufopts)
  nmap('<Leader>rn', vim.lsp.buf.rename, bufopts)
  nmap(']d', vim.diagnostic.goto_next, bufopts)
  nmap('[d', vim.diagnostic.goto_prev, bufopts)
  nmap('<C-g><C-d>', vim.diagnostic.open_float, bufopts)

  map({ 'n', 'x' }, 'ma', vim.lsp.buf.code_action(), bufopts)
  nmap('<Leader>gl', vim.lsp.codelens.run, bufopts)
  -- auto format when save the file
  local organize_import = function() end
  local actions = vim.tbl_get(client.server_capabilities, 'codeActionProvider', "codeActionKinds")
  if actions ~= nil and vim.tbl_contains(actions, "source.organizeImports") then
    organize_import = function()
      vim.lsp.buf.code_action({ context = { only = { "source.organizeImports" } }, apply = true })
    end
  end
  nmap('mi', organize_import)

  -- format on save: https://github.com/mrcjkb/rustaceanvim/issues/28#issuecomment-2054117845
  local format_sync_grp = vim.api.nvim_create_augroup("RustaceanFormat", {})
  vim.api.nvim_create_autocmd("BufWritePre", {
    buffer = bufnr,
    callback = function() vim.lsp.buf.format() end,
    group = format_sync_grp,
  })

  if client.supports_method("textDocument/formatting") then
    nmap(']f', vim.lsp.buf.format, { buffer = bufnr })
  end


  -- inlay hint default enable
  vim.lsp.inlay_hint.enable()
  -- toggle inlay_hint
  nmap('<Leader>gi', function()
    return vim.lsp.inlay_hint.enable(0, not vim.lsp.inlay_hint.is_enabled())
  end, { expr = true })
end

vim.g.rustaceanvim = {
  -- Plugin configuration
  tools = {
  },
  -- LSP configuration
  server = {
    on_attach = lsp_on_attach,
    default_settings = {
      -- rust-analyzer language server configuration
      ['rust-analyzer'] = {
      },
    },
  },
  -- DAP configuration
  dap = {
  },
}

local config = function()
  -- replace `J` command in rust
  nmap('J', '<Cmd>RustLsp joinLines<CR>')

  -- Hover action
  nmap('K', '<Cmd>RustLsp hover actions<CR>')
  -- Diagnostic
  nmap('<Leader>gd', '<Cmd>RustLsp explainError<CR>')

  vim.api.nvim_create_user_command('OpenCargoToml', function()
    vim.cmd.RustLsp('openCargo')
  end, {})
  vim.api.nvim_create_user_command('ViewHir', function()
    vim.cmd.RustLsp { 'view', 'hir' }
  end, {})
  vim.api.nvim_create_user_command('ViewMir', function()
    vim.cmd.RustLsp { 'view', 'mir' }
  end, {})
end

return {
  {
    'mrcjkb/rustaceanvim',
    version = '^4', -- Recommended
    ft = { 'rust' },
    config = config,
    enabled = function()
      if vim.fn.has('win32') then
        return false
      else
        return true
      end
    end,
  },
  {
    'saecki/crates.nvim',
    tag = 'stable',
    config = function()
      require('crates').setup()
    end,
    opts = {
      completion = {
        cmp = { enabled = true },
      },
    }
  }
}
