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
    enabled = true
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
  }
}
