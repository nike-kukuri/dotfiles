return {
  {
    'lambdalisue/fern-hijack.vim',
    dependencies = {
      'lambdalisue/fern.vim',
      cmd = 'Fern',
      config = function()
        g['fern#renderer'] = 'nerdfont'
        g['fern#window_selector_use_popup'] = true
        g['fern#default_hidden'] = 1
        g['fern#default_exclude'] = '.git$'

        api.nvim_create_autocmd('FileType', {
          pattern = 'fern',
          callback = function()
            nmap('q', ':q<CR>', { silent = true, buffer = true })
            nmap('<C-x>', '<Plug>(fern-action-open:split)', { silent = true, buffer = true })
            nmap('<C-v>', '<Plug>(fern-action-open:vsplit)', { silent = true, buffer = true })
            nmap('<C-t>', '<Plug>(fern-action-tcd)', { silent = true, buffer = true })
          end,
          group = api.nvim_create_augroup('fernInit', { clear = true }),
        })
      end,
    },
    init = function()
      nmap('<Leader>f', '<Cmd>Fern . -drawer<CR>', { silent = true })
    end,
    enabled = false
  },
  {
    'lambdalisue/fern-renderer-nerdfont.vim',
    dependencies = { 'lambdalisue/fern.vim' },
    enabled = false
  },
  {
    'lambdalisue/nerdfont.vim',
    dependencies = { 'lambdalisue/fern.vim' },
    enabled = false
  },
}
