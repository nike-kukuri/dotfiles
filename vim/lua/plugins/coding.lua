--- TODO: move utils
_G.nike = {}
local fs = {}
nike.fs = fs

---@param fname string
---@return string
function fs.read(fname)
  local fd = assert(vim.uv.fs_open(fname, "r", 292)) -- 0444
  local stat = assert(vim.uv.fs_fstat(fd))
  local buffer = assert(vim.uv.fs_read(fd, stat.size, 0))
  assert(vim.uv.fs_close(fd))
  return buffer
end

local nvim_cmp_config = function()
  local cmp = require('cmp')
  cmp.setup({
    window = {
      -- completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },
    preselect = cmp.PreselectMode.None,
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ["<C-p>"] = cmp.mapping.select_prev_item(),
      ["<C-n>"] = cmp.mapping.select_next_item(),
      -- ['<Tab>'] = cmp.mapping.complete(),
      ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    }),
    sources = {
      { name = 'nvim_lsp' },
      { name = 'vsnip' },
      { name = 'buffer', option = {
        get_bufnrs = function()
          local bufs = {}
          for _, win in ipairs(api.nvim_list_wins()) do
            bufs[api.nvim_win_get_buf(win)] = true
          end
          return vim.tbl_keys(bufs)
        end
      } },
      { name = 'path' },
    },
    view = {
      entries = 'native'
    },
    snippet = {
      expand = function(args)
        fn['vsnip#anonymous'](args.body)
      end
    },
  })
end

-- rust-tools.nvim
local rust_tools_config = function()
  local rt = require("rust-tools")
  rt.setup({
    server = {
      on_attach = function(client, bufnr)
        local bufopts = { silent = true, buffer = bufnr }
        Lsp_on_attach(client, bufnr)
        nmap('K', rt.hover_actions.hover_actions, bufopts)
        nmap('<Leader>gl', rt.code_action_group.code_action_group, bufopts)
        nmap('gO', function()
          vim.lsp.buf_request(0, 'experimental/externalDocs', vim.lsp.util.make_position_params(),
            function(err, url)
              if err then
                error(tostring(err))
              else
                fn.jobstart({ 'open', url })
              end
            end)
        end, bufopts)
      end,
      standalone = true,
      settings = {
        ['rust-analyzer'] = {
          -- files = {
          --   excludeDirs = { '/root/path/to/dir' },
          -- },
        }
      }
    },
    tools = {
      hover_actions = {
        border = {
          { '╭', 'NormalFloat' },
          { '─', 'NormalFloat' },
          { '╮', 'NormalFloat' },
          { '│', 'NormalFloat' },
          { '╯', 'NormalFloat' },
          { '─', 'NormalFloat' },
          { '╰', 'NormalFloat' },
          { '│', 'NormalFloat' },
        },
        -- auto_focus = true,
      },
    },
  })
end

return {
  {
    'hrsh7th/nvim-cmp',
    -- module = { "cmp" },
    dependencies = {
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-path' },
      { 'hrsh7th/cmp-vsnip' },
      { 'hrsh7th/vim-vsnip' },
      { 'hrsh7th/cmp-cmdline' },
    },
    config = nvim_cmp_config,
    event = { 'InsertEnter' },
  },
  {
    'monaqa/dial.nvim',
    config = function()
      local dial = require("dial.map")
      nmap("<C-a>", dial.inc_normal())
      nmap("<C-x>", dial.dec_normal())
      nmap("g<C-a>", dial.inc_normal())
      nmap("g<C-a>", dial.dec_normal())
      vmap("<C-a>", dial.inc_visual())
      vmap("<C-x>", dial.dec_visual())
      vmap("g<C-a>", dial.inc_gvisual())
      vmap("g<C-x>", dial.dec_gvisual())
    end
  },

  {
    'machakann/vim-sandwich'
  },

  {
    'thinca/vim-qfreplace',
    event = { 'BufNewFile', 'BufRead' }
  },

  {
    'junegunn/vim-easy-align',
    config = function()
      nmap('ga', '<Plug>(EasyAlign)')
      vmap('ga', '<Plug>(EasyAlign)')
    end
  },

  {
    'vim-skk/skkeleton',
    dependencies = {
      'vim-denops/denops.vim',
      'delphinus/skkeleton_indicator.nvim',
      config = function()
        require("skkeleton_indicator").setup()
      end
    },
    config = function()
      imap('<C-j>', '<Plug>(skkeleton-toggle)')
      cmap('<C-j>', '<Plug>(skkeleton-toggle)')

      vim.fn["denops#plugin#wait_async"]("skkeleton", function()
        vim.g["skkeleton#mapped_keys"] = { "<C-l>", "<C-q>" }
        vim.fn["skkeleton#register_keymap"]("input", "<C-q>", "katakana")
        vim.fn["skkeleton#register_keymap"]("input", "<C-l>", "zenkaku")
        vim.fn["skkeleton#register_keymap"]("input", "'", "henkanPoint")
        local path = vim.fn.expand("~/.config/skk/azik_kanatable.json")
        local buffer = nike.fs.read(path)
        local kanaTable = vim.json.decode(buffer)
        kanaTable[" "] = "henkanFirst"
        vim.fn["skkeleton#register_kanatable"]("azik", kanaTable, true)

        vim.fn["skkeleton#config"]({
          kanaTable = "azik",
          eggLikeNewline = true,
          keepState = true,
          globalDictionaries = {
            vim.fn.expand("~/.config/skk/SKK-JISYO.L")
          },
        })

        vim.fn["skkeleton#initialize"]()
      end)

    end
  },

  {
    'simrat39/rust-tools.nvim',
    ft = { 'rust' },
    config = rust_tools_config,
    dependencies = {
      { 'neovim/nvim-lspconfig' },
    },
  },

  {
    'windwp/nvim-autopairs',
    event = { 'InsertEnter' },
    config = function()
      require("nvim-autopairs").setup({ map_c_h = true })
    end,
  },
}
