return {
  {
    'EdenEast/nightfox.nvim',
    lazy = false,
    config = function()
      opt.termguicolors = true
      cmd([[
          colorscheme nightfox
          hi VertSplit guifg=#535353
          hi Visual ctermfg=159 ctermbg=23 guifg=#b3c3cc guibg=#384851
          hi DiffAdd guifg=#25be6a
          hi DiffDelete guifg=#ee5396
      ]])
    end,
    enabled = false
  },
  {
    'cryptomilk/nightcity.nvim',
    lazy = false,
    version = '*',
    config = function()
      require('nightcity').setup({
        style = 'afterlife',
        invert_colors = {
          -- Invert colors for the following syntax groups
          cursor = false,
          diff = true,
          error = true,
          search = true,
          selection = false,
          signs = false,
          statusline = true,
          tabline = true,
        },
        font_style = {
          -- Style to be applied to different syntax groups
          comments = { italic = true },
          keywords = { italic = false },
          functions = { bold = false },
          variables = {},
          search = { bold = true },
        },
      })

      opt.termguicolors = true
      cmd('colorscheme nightcity')
    end,
    enabled = false
  },
  {
    {
      "catppuccin/nvim",
      name = "catppuccin",
      priority = 1000,
      config = function()
        require("catppuccin").setup({
          flavour = "mocha", -- latte, frappe, macchiato, mocha
          -- flavour = "auto" -- will respect terminal's background
          background = { -- :h background
              light = "latte",
              dark = "mocha",
          },
          transparent_background = false, -- disables setting the background color.
          show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
          term_colors = false, -- sets terminal colors (e.g. `g:terminal_color_0`)
          dim_inactive = {
              enabled = false, -- dims the background color of inactive window
              shade = "dark",
              percentage = 0.15, -- percentage of the shade to apply to the inactive window
          },
          no_italic = false, -- Force no italic
          no_bold = false, -- Force no bold
          no_underline = false, -- Force no underline
          styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
            comments = { "italic" }, -- Change the style of comments
            conditionals = { "italic" },
            loops = {},
            functions = {},
            keywords = {},
            strings = {},
            variables = {},
            numbers = {},
            booleans = {},
            properties = {},
            types = {},
            operators = {},
            -- miscs = {}, -- Uncomment to turn off hard-coded styles
          },
            color_overrides = {},
            custom_highlights = {},
              integrations = {
                cmp = true,
                gitsigns = true,
                nvimtree = true,
                treesitter = true,
                notify = false,
                mini = {
                    enabled = true,
                    indentscope_color = "",
              },
            },
          })

        opt.termguicolors = true
        vim.cmd.colorscheme "catppuccin"
      end
    }
  }
}
