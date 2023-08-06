return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter.configs').setup({
        ensure_installed = {
          'lua', 'rust', 'typescript', 'tsx',
          'go', 'gomod', 'sql', 'toml', 'yaml',
          'html', 'javascript', 'graphql',
          'markdown', 'markdown_inline', 'help',
        },
        auto_install = true,
        highlight = {
          enable = true,
          disable = { 'yaml' },
        }
      })
    end
  },
}
