return {
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
  end
}
