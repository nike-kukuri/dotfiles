return {
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
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
    'lewis6991/gitsigns.nvim',
    event = 'BufRead',
    config = function()
      require('gitsigns').setup({
        current_line_blame = true,
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns

          -- Navigation
          map('n', ']c', function()
            if vim.wo.diff then return ']c' end
            vim.schedule(function() gs.next_hunk() end)
            return '<Ignore>'
          end, { expr = true })

          map('n', '[c', function()
            if vim.wo.diff then return '[c' end
            vim.schedule(function() gs.prev_hunk() end)
            return '<Ignore>'
          end, { expr = true })

          local opts = {
            buffer = bufnr,
            silent = true
          }
          -- Actions
          map({ 'n', 'x' }, ']g', ':Gitsigns stage_hunk<CR>', opts)
          map({ 'n', 'x' }, '[g', ':Gitsigns undo_stage_hunk<CR>', opts)
          map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', opts)
          nmap('mp', ':Gitsigns preview_hunk<CR>', opts)
        end
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
