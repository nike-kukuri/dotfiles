return {
  {
    "Shougo/ddu-ui-ff",
    dependencies = "Shougo/ddu.vim",
    config = function()
      local vimx = require('artemis')
      vim.keymap.set('n', '<Leader>zf', '<Cmd>call ddu#start({})<CR>')

      vimx.fn.ddu.custom.patch_global({
        ui = 'ff',
        sources = {
          name = 'file_rec',
          params = {},
        },
        sourceOptions = {
          _ = {
            matchers = { 'matcher_substring' },
          },
        },
        kindOptions = {
          file = {
            defaultAction = 'open'
          },
        },
      })

      vimx.fn.ddu.custom.patch_global({
       uiParams = {
         ff = {
           startFilter = true,
           split = 'floating',
           prompt = "> ",
           floatingBorder = "single",
           filterFloatingPosition = "top",
           autoAction = { name = "preview" },
           startAutoAction = true,
           previewFloating = true,
           previewFloatingBorder = "rounded",
           previewSplit = "vertical",
           previewFloatingTitle = "Preview",
           highlights = {
             floating = "Normal",
             floatingBorder = "Normal"
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

vim.cmd([[

function! s:ddu_my_settings() abort
  nnoremap <buffer><silent> <CR>
        \ <Cmd>call ddu#ui#ff#do_action('itemAction')<CR>
  nnoremap <buffer><silent> <Space>
        \ <Cmd>call ddu#ui#ff#do_action('toggleSelectItem')<CR>
  nnoremap <buffer><silent> i
        \ <Cmd>call ddu#ui#ff#do_action('openFilterWindow')<CR>
  nnoremap <buffer><silent> q
        \ <Cmd>call ddu#ui#ff#do_action('quit')<CR>
endfunction

]])
    end,
  },
}

    --\       'winCol': &columns / 9,
    --\       'winWidth': &columns / 10 * 3,
    --\       'winRow': &lines / 8,
    --\       'winHeight': &lines / 10 * 9,
    --\       'previewWidth': &columns / 10 * 5,
    --\       'previewHeight': &lines / 10 * 9,
