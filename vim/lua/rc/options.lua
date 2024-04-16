g.mapleader      = " "
opt.breakindent  = true
opt.number       = false
opt.incsearch    = true
opt.ignorecase   = true
opt.smartcase    = true
opt.hlsearch     = true
opt.autoindent   = true
opt.smartindent  = true
opt.virtualedit  = "block"
opt.showtabline  = 1
opt.tabstop      = 2
opt.shiftwidth   = 2
opt.softtabstop  = 2
opt.completeopt  = 'menu,menuone,noselect'
opt.laststatus   = 3
opt.scrolloff    = 10
opt.cursorline   = true
opt.helplang     = 'ja'
opt.autowrite    = true
opt.swapfile     = false
opt.showtabline  = 1
-- opt.diffopt   = 'vertical,internal'
-- opt.wildcharm = ('<Tab>'):byte()
opt.tabstop      = 2
opt.shiftwidth   = 2
opt.softtabstop  = 2
opt.grepprg      = 'rg --vimgrep'
opt.grepformat   = '%f:%l:%c:%m'
opt.mouse        = 'a'
opt.clipboard:append({ fn.has('mac') == 1 and 'unnamed' or 'unnamedplus' })
opt.termguicolors = true
-- if OS is Windows, powershell 5 or 7
if fn.has('win') == true then
  opt.shell = { fn.executable('pwsh') == 1 and 'pwsh' or 'powershell'}
end

