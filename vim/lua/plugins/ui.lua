return {
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      lsp = {
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
        },
      },
      messages = {
        view = "mini",
        view_error = "mini",
        view_warn = "mini",
      },
      popupmenu = {
        enabled = true,
				backend = "nui", -- "cmp" or "nui"
      },
      notify = {
        enabled = true,
        view = "mini",
      },
      views = {
        cmdline_popup = {
          position = {
            row = 5,
            col = "50%",
          },
          size = {
            width = 60,
            height = "auto",
          },
        },
        popupmenu = {
          relative = "editor",
          position = {
            row = 8,
            col = "50%",
          },
          size = {
            width = 60,
            height = 10,
          },
          border = {
            style = "rounded",
            padding = { 0, 1 },
          },
          win_options = {
            winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" },
          },
        },
      },
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      "rcarriga/nvim-notify",
    },
    enabled = function()
      if vim.fn.has('mac') then
        return false
      else
        return true
      end
    end
  },

  {
    'j-hui/fidget.nvim',
    config = function() require('fidget').setup() end,
  },

  {
    'nvim-lualine/lualine.nvim',
    dependencies = 'kyazdani42/nvim-web-devicons',
    config = function()
      require('lualine').setup({
        sections = {
          lualine_c = {
            {
              'filename',
              path = 3,
            }
          }
        }
      })
    end,
  },

  --{
  --  'akinsho/bufferline.nvim',
  --  version = "v1.*",
  --  dependencies = 'kyazdani42/nvim-web-devicons',
  --  config = function()
  --    require('bufferline').setup({
  --      options = {
  --        mode = 'tabs',
  --        hover = {
  --          enabled = true,
  --        },
  --        diagnostics = 'nvim_lsp',
  --        diagnostics_indicator = function(count, level)
  --          local icon = level:match("error") and " " or " "
  --          return ' ' .. icon .. count
  --        end,
  --        indicator = {
  --          icon = '',
  --        },
  --        buffer_close_icon = 'x'
  --      }
  --    })
  --  end
  --},

  {
    'lukas-reineke/indent-blankline.nvim',
    event = 'BufReadPre',
    config = function()
      require("indent_blankline").setup({
        space_char_blankline = " ",
      })
    end,
  },

  {
    'shellRaining/hlchunk.nvim',
    event = { 'UIEnter' },
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      require('hlchunk').setup({
        ---@diagnostic disable-next-line: missing-fields
        blank = {
          enable = false,
        }
      })
    end
  },
}
