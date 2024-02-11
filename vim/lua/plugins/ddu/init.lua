return {
  {
    'Shougo/ddu.vim',
    lazy = true,
    dependencies = {
      { 'vim-denops/denops.vim' },
      { 'yuki-yano/denops-lazy.nvim' },
      { 'Shougo/ddu-ui-ff' },
      { 'Shougo/ddu-kind-file' },
      { 'yuki-yano/ddu-filter-fzf' },
      { 'yuki-yano/lazy_on_func.nvim' },
      { 'lambdalisue/mr.vim' },
      { 'kuuote/ddu-source-mr' },
      { 'matsui54/ddu-source-help' },
      { 'Shougo/ddu-source-action' },
    },
    init = function()
      local on_func = require('lazy_on_func').on_func
      local ddu = on_func('ddu.vim', 'ddu')

      vim.api.nvim_create_user_command('DduFile', function()
        ddu('start')({
          sources = {
            {
              name = 'mr',
              params = {
                current = true,
              },
            },
          },
        })
      end, {})

      vim.api.nvim_create_user_command('DduHelp', function()
        ddu('start')({
          sources = {
            {
              name = 'help',
            },
          },
          kindParams = {
            help = {
              histadd = true,
            },
          },
        })
      end, {})

      vim.keymap.set({ 'n' }, '<Plug>(ff)h', '<Cmd>DduHelp<CR>')
    end,
    config = function()
      require('denops-lazy').load('ddu.vim', { wait_load = false })

      local vimx = require('artemis')

      vimx.fn.ddu.custom.patch_global({
        ui = 'ff',
        uiParams = {
          ff = {
            -- startFilter = true,
            split = 'floating',
            prompt = '> ',
            floatingBorder = 'rounded',
            highlights = {
              floatingCursorLine = 'Visual',
              filterText = 'Statement',
              floating = 'Normal',
              floatingBorder = 'Special',
            },
            autoAction = {
              name = 'preview',
            },
            startAutoAction = true,
            previewFloating = true,
            previewFloatingBorder = 'rounded',
            previewSplit = 'vertical',
            previewWindowOptions = {
              { '&signcolumn', 'no' },
              { '&foldcolumn', 0 },
              { '&foldenable', 0 },
              { '&number', 0 },
              { '&relativenumber', 0 },
              { '&wrap', 0 },
              { '&scrolloff', 0 },
            },
          },
        },
      })

      local resize = function()
        local width = math.floor(vim.o.columns * 0.8)
        local previewWidth = math.floor(width * 0.5)
        local height = math.floor(vim.o.lines * 0.8)
        local previewHeight = height - 2
        local row = math.floor((vim.o.lines - height) / 2)
        local previewRow = row + 1
        local col = math.floor(vim.o.columns * 0.1)
        local halfWidth = math.floor(vim.o.columns * 0.5)
        local previewCol = halfWidth - 2

        vimx.fn.ddu.custom.patch_global({
          uiParams = {
            ff = {
              winWidth = width,
              winHeight = height,
              winRow = row,
              winCol = col,
              previewWidth = previewWidth,
              previewHeight = previewHeight,
              previewRow = previewRow,
              previewCol = previewCol,
            },
          },
        })
      end
      vim.api.nvim_create_autocmd({ 'VimResized' }, {
        pattern = { '*' },
        callback = resize,
      })
      resize()

      vim.api.nvim_create_autocmd({ 'FileType' }, {
        pattern = { 'ddu-ff' },
        callback = function()
          vim.opt_local.cursorline = true

          vim.keymap.set({ 'n' }, '<CR>', function()
            vim.cmd([[stopinsert]])
            vimx.fn.ddu.ui.ff.do_action('itemAction')
          end, { buffer = true })
          vim.keymap.set({ 'n' }, '<Space>', function()
            vimx.fn.ddu.ui.ff.do_action('toggleSelectItem')
            vimx.fn.ddu.ui.ff.do_action('cursorNext')
          end, { buffer = true })
          vim.keymap.set({ 'n' }, 'i', function()
            vimx.fn.ddu.ui.ff.do_action('openFilterWindow')
          end, { buffer = true })
          vim.keymap.set({ 'n' }, '>', function()
            vimx.fn.ddu.ui.ff.do_action('chooseAction')
          end, { buffer = true })

          vim.keymap.set({ 'n' }, 'q', function()
            vimx.fn.ddu.ui.ff.do_action('quit')
          end, { buffer = true })
          vim.keymap.set({ 'n' }, '<Esc><Esc>', function()
            vim.cmd([[stopinsert]])
            vimx.fn.ddu.ui.ff.do_action('quit')
          end, { buffer = true })
          vim.keymap.set({ 'n', 'i' }, '<C-g>', function()
            vim.cmd([[stopinsert]])
            vimx.fn.ddu.ui.ff.do_action('quit')
          end, { buffer = true, nowait = true })
          vim.keymap.set({ 'n', 'i' }, '<C-c>', function()
            vim.cmd([[stopinsert]])
            vimx.fn.ddu.ui.ff.do_action('quit')
          end, { buffer = true })

          vim.keymap.set({ 'n' }, 'j', function()
            vimx.fn.ddu.ui.ff.do_action('cursorNext')
          end, { buffer = true })
          vim.keymap.set({ 'n' }, 'k', function()
            vimx.fn.ddu.ui.ff.do_action('cursorPrevious')
          end, { buffer = true })
          vim.keymap.set({ 'n', 'i' }, '<C-n>', function()
            vimx.fn.ddu.ui.ff.do_action('cursorNext')
          end, { buffer = true })
          vim.keymap.set({ 'n', 'i' }, '<C-p>', function()
            vimx.fn.ddu.ui.ff.do_action('cursorPrevious')
          end, { buffer = true })

          vim.keymap.set({ 'n', 'i' }, '<C-d>', function()
            local ctrl_d = vim.api.nvim_replace_termcodes('<C-d>', true, true, true)
            vimx.fn.ddu.ui.ff.do_action('previewExecute', { command = 'normal! ' .. ctrl_d })
          end, { buffer = true })
          vim.keymap.set({ 'n', 'i' }, '<C-u>', function()
            local ctrl_u = vim.api.nvim_replace_termcodes('<C-u>', true, true, true)
            vimx.fn.ddu.ui.ff.do_action('previewExecute', { command = 'normal! ' .. ctrl_u })
          end, { buffer = true })
          vim.keymap.set({ 'n', 'i' }, '?', function()
            vimx.fn.ddu.ui.ff.do_action('toggleAutoAction')
          end, { buffer = true })
        end,
      })
      vim.api.nvim_create_autocmd({ 'FileType' }, {
        pattern = { 'ddu-ff-filter' },
        callback = function()
          vim.keymap.set({ 'n', 'i' }, '<CR>', function()
            vim.cmd([[stopinsert]])
            vimx.fn.ddu.ui.ff.do_action('itemAction')
          end, { buffer = true })
          vim.keymap.set({ 'n', 'i' }, '>', function()
            vimx.fn.ddu.ui.ff.do_action('chooseAction')
          end, { buffer = true })

          vim.keymap.set({ 'n' }, 'q', function()
            vimx.fn.ddu.ui.ff.do_action('quit')
          end, { buffer = true })
          vim.keymap.set({ 'n' }, '<Esc><Esc>', function()
            vim.cmd([[stopinsert]])
            vimx.fn.ddu.ui.ff.do_action('quit')
          end, { buffer = true })
          vim.keymap.set({ 'n', 'i' }, '<C-g>', function()
            vim.cmd([[stopinsert]])
            vimx.fn.ddu.ui.ff.do_action('quit')
          end, { buffer = true, nowait = true })
          vim.keymap.set({ 'n', 'i' }, '<C-c>', function()
            vim.cmd([[stopinsert]])
            vimx.fn.ddu.ui.ff.do_action('quit')
          end, { buffer = true })

          vim.keymap.set({ 'n', 'i' }, '<C-n>', function()
            vimx.fn.ddu.ui.ff.do_action('cursorNext')
          end, { buffer = true })
          vim.keymap.set({ 'n', 'i' }, '<C-p>', function()
            vimx.fn.ddu.ui.ff.do_action('cursorPrevious')
          end, { buffer = true })
          vim.keymap.set({ 'n', 'i' }, '<Tab>', function()
            vimx.fn.ddu.ui.ff.do_action('toggleSelectItem')
            vimx.fn.ddu.ui.ff.do_action('cursorNext')
          end, { buffer = true })

          vim.keymap.set({ 'n', 'i' }, '<C-d>', function()
            local ctrl_d = vim.api.nvim_replace_termcodes('<C-d>', true, true, true)
            vimx.fn.ddu.ui.ff.do_action('previewExecute', { command = 'normal! ' .. ctrl_d })
          end, { buffer = true })
          vim.keymap.set({ 'n', 'i' }, '<C-u>', function()
            local ctrl_u = vim.api.nvim_replace_termcodes('<C-u>', true, true, true)
            vimx.fn.ddu.ui.ff.do_action('previewExecute', { command = 'normal! ' .. ctrl_u })
          end, { buffer = true })
          vim.keymap.set({ 'n', 'i' }, '?', function()
            vimx.fn.ddu.ui.ff.do_action('toggleAutoAction')
          end, { buffer = true })

          vim.keymap.set({ 'i' }, "'", "'", { buffer = true })
        end,
      })

      vimx.fn.ddu.custom.patch_global({
        kindOptions = {
          action = {
            defaultAction = 'do',
          },
          file = {
            defaultAction = 'open',
          },
          help = {
            defaultAction = 'open',
          },
          ['ai-review-request'] = {
            defaultAction = 'open',
          },
          ['ai-review-log'] = {
            defaultAction = 'resume',
          },
        },
      })
      vimx.fn.ddu.custom.patch_global({
        sourceOptions = {
          _ = {
            matchers = { 'matcher_fzf' },
            sorters = { 'sorter_fzf' },
          },
        },
      })
      vimx.fn.ddu.custom.patch_global({
        filterParams = {
          matcher_fzf = {
            highlightMatched = 'Search',
          },
        },
      })
    end,
  },
}
