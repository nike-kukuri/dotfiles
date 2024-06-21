return {
  {
    'zbirenbaum/copilot.lua',
    event = 'InsertEnter',
    config = function()
      require('copilot').setup({
        suggestion = { enabled = false },
        panel = { enabled = false },
        filetypes = {
          ["*"] = true,
          --yaml = true,
          --markdown = true,
          --help = true,
          --gitcommit = true,
          --lua = true,
          --vim = true,
          --rust = true,
        },
      })
    end,
  },
  {
    'zbirenbaum/copilot-cmp',
    config = function ()
      require("copilot_cmp").setup()
    end
  },
  {
    'CopilotC-NVim/CopilotChat.nvim',
    event = 'VeryLazy',
    branch = 'canary',
    dependencies = {
      'zbirenbaum/copilot.lua',
      'nvim-lua/plenary.nvim',
    },
  }
}
