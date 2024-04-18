return {
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",         -- required
      "sindrets/diffview.nvim",        -- optional - Diff integration
    },
    config = true
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
}
