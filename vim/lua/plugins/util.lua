g['quickrun_config'] = {
  ['rust/cargo'] = {
    command = 'cargo',
    exec = '%C run --quiet %s %a',
  },
}

return {
  {
    "akinsho/toggleterm.nvim",
		event = "VimEnter",
    config = function()
      require("toggleterm").setup({
        -- size can be a number or function which is passed the current terminal
        size = function(term)
          if term.direction == "horizontal" then
            return vim.o.lines * 0.25
          elseif term.direction == "vertical" then
            return vim.o.columns * 0.4
          end
        end,
        open_mapping = [[<c-z>]],
        hide_numbers = true, -- hide the number column in toggleterm buffers
        shade_filetypes = {},
        shade_terminals = true,
        shading_factor = "1", -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
        start_in_insert = false,
        insert_mappings = true, -- whether or not the open mapping applies in insert mode
        persist_size = false,
        direction = "float",
        close_on_exit = false, -- close the terminal window when the process exits
        shell = vim.o.shell, -- change the default shell
        -- This field is only relevant if direction is set to 'float'
        float_opts = {
          -- The border key is *almost* the same as 'nvim_win_open'
          -- see :h nvim_win_open for details on borders however
          -- the 'curved' border is a custom border type
          -- not natively supported but implemented in this plugin.
          border = "single",
          width = math.floor(vim.o.columns * 0.9),
          height = math.floor(vim.o.lines * 0.9),
          winblend = 3,
          highlights = { border = "ColorColumn", background = "ColorColumn" },
        },
      })
      vim.api.nvim_set_keymap("n", "<C-z>", '<Cmd>execute v:count1 . "ToggleTerm"<CR>', { noremap = true, silent = true })
    end,
  },
  {
    'tani/dmacro.nvim',
    config = function()
      require('dmacro').setup({
        dmacro_key = '<M-t>'
      })
    end,
    lazy = false,
  },
  {
    'haya14busa/vim-edgemotion',
    config = function()
      nmap('<Leader>j', '<Plug>(edgemotion-j)')
      nmap('<Leader>k', '<Plug>(edgemotion-k)')
      vmap('<Leader>j', '<Plug>(edgemotion-j)')
      vmap('<Leader>k', '<Plug>(edgemotion-k)')
    end
  },
  {
    'tani/vim-artemis'
  },
  {
    'lambdalisue/gin.vim'
  },
  {
    'lambdalisue/gina.vim',
    config = function()
      local gina_keymaps = {
        { map = 'nmap', buffer = 'status', lhs = 'gp', rhs = '<Cmd>Gina push<CR>' },
        { map = 'nmap', buffer = 'status', lhs = 'gr', rhs = '<Cmd>terminal gh pr create<CR>' },
        { map = 'nmap', buffer = 'status', lhs = 'gl', rhs = '<Cmd>Gina pull<CR>' },
        { map = 'nmap', buffer = 'status', lhs = 'cm', rhs = '<Cmd>Gina commit<CR>' },
        { map = 'nmap', buffer = 'status', lhs = 'ca', rhs = '<Cmd>Gina commit --amend<CR>' },
        { map = 'nmap', buffer = 'status', lhs = 'dp', rhs = '<Plug>(gina-patch-oneside-tab)' },
        { map = 'nmap', buffer = 'status', lhs = 'ga', rhs = '--' },
        { map = 'vmap', buffer = 'status', lhs = 'ga', rhs = '--' },
        { map = 'nmap', buffer = 'log', lhs = 'dd', rhs = '<Plug>(gina-changes-of)' },
        { map = 'nmap', buffer = 'branch', lhs = 'n', rhs = '<Plug>(gina-branch-new)' },
        { map = 'nmap', buffer = 'branch', lhs = 'D', rhs = '<Plug>(gina-branch-delete)' },
        { map = 'nmap', buffer = 'branch', lhs = 'p', rhs = '<Cmd>terminal gh pr create<CR>' },
        { map = 'nmap', buffer = 'branch', lhs = 'P', rhs = '<Cmd>terminal gh pr create<CR>' },
        { map = 'nmap', buffer = '/.*', lhs = 'q', rhs = '<Cmd>bw<CR>' },
      }
      for _, m in pairs(gina_keymaps) do
        fn['gina#custom#mapping#' .. m.map](m.buffer, m.lhs, m.rhs, { silent = true })
      end

      fn['gina#custom#command#option']('log', '--opener', 'new')
      fn['gina#custom#command#option']('status', '--opener', 'new')
      fn['gina#custom#command#option']('branch', '--opener', 'new')
      nmap('gs', '<Cmd>Gina status --short<CR>')
      nmap('gl', '<Cmd>Gina log<CR>')
      nmap('gm', '<Cmd>Gina blame<CR>')
      nmap('gb', '<Cmd>Gina branch<CR>')
      nmap('gu', ':Gina browse --exact --yank :<CR>')
      vmap('gu', ':Gina browse --exact --yank :<CR>')
    end,
  },
  {
    'lambdalisue/kensaku.vim'
  },
  {
    'lambdalisue/kensaku-search.vim',
    config = function()
      cmap('<CR>', '<Plug>(kensaku-search-replace)<CR>', {})
    end
  },
  {
    'kevinhwang91/nvim-bqf',
    ft = 'qf',
    event = { 'QuickFixCmdPre' }
  },
  {
    'lambdalisue/guise.vim',
  },
  {
    'simeji/winresizer',
    keys = {
      { '<C-e>', '<Cmd>WinResizerStartResize<CR>', desc = 'start window resizer' }
    },
  },
  { 'vim-denops/denops.vim' },
  {
    'thinca/vim-quickrun',
    dependencies = {
      { 'skanehira/quickrun-neoterm.vim' }
    },
    config = function()
      api.nvim_create_autocmd('FileType', {
        pattern = 'quickrun',
        callback = function()
          nmap('q', '<Cmd>bw!<CR>', { silent = true, buffer = true })
        end,
        group = api.nvim_create_augroup('quickrunInit', { clear = true }),
      })
    end,
  },
  {
    'tyru/open-browser-github.vim',
    dependencies = {
      {
        'tyru/open-browser.vim',
        config = function()
          nmap('gop', '<Plug>(openbrowser-open)')
          xmap('gop', '<Plug>(openbrowser-open)')
        end,
      },
    }
  },
  {
    'haya14busa/vim-edgemotion',
    config = function()
      nmap('M-j', '<Plug>(edgemotion-j)')
      nmap('M-k', '<Plug>(edgemotion-j)')
    end
  },
  {
    'previm/previm'
  },
  {
    'kat0h/bufpreview.vim'
  }
}
