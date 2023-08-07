return {
  {
    'nvim-telescope/telescope.nvim',
    -- module = { "telescope" },
    dependencies = {
      { 'nvim-lua/plenary.nvim' },
      { 'nvim-telescope/telescope-ui-select.nvim' },
    },
    init = function()
      local function builtin(name)
        return function(opt)
          return function()
            return require('telescope.builtin')[name](opt or {})
          end
        end
      end

      nmap('<C-p>', builtin 'find_files' {})
      nmap('mg', builtin 'live_grep' {})
      nmap('md', builtin 'diagnostics' {})
      nmap('mf', builtin 'current_buffer_fuzzy_find' {})
      nmap('mh', builtin 'help_tags' { lang = 'ja' })
      nmap('mo', builtin 'oldfiles' {})
      nmap('ms', builtin 'git_status' {})
    end,
    config = function()
      local actions = require('telescope.actions')
      require('telescope').setup {
        pickers = {
          live_grep = {
            mappings = {
              i = {
                ['<C-o>'] = actions.send_to_qflist + actions.open_qflist,
                ['<C-l>'] = actions.send_to_loclist + actions.open_loclist,
              }
            }
          }
        },
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown {}
          }
        }
      }
      require("telescope").load_extension("ui-select")
    end,
    opts = {
      defaults = {
        layout_strategy = "horizontal",
        layout_config = { prompt_position = "top" },
        sorting_strategy = "ascending",
        winblend = 0,
      },
    },
  },
}
