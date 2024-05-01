return {
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      messages = {
        view = "mini",
        view_error = "mini",
        view_warn = "mini",
      },
      --popupmenu = {
      --  backend = "cmp"
      --},
      notify = {
        enabled = false,
        view = "notify",
      }
      -- add any options here
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      "rcarriga/nvim-notify",
    }
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
