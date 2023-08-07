g['quickrun_config'] = {
  ['rust/cargo'] = {
    command = 'cargo',
    exec = '%C run --quiet %s %a',
  },
}

return {
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
}
