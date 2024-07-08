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

local has_words_before = function()
  if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then return false end
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_text(0, line-1, 0, line-1, col, {})[1]:match("^%s*$") == nil
end

local nvim_cmp_config = function()
  local lspkind = require('lspkind')
  local luasnip = require('luasnip')
  local cmp = require('cmp')
  cmp.setup({
    formatting = {
      format = lspkind.cmp_format({
        with_text = true,
        menu = {
          buffer = "[Buffer]",
          nvim_lsp = "[LSP]",
          luasnip = "[LuaSnip]",
          path = "[Path]",
          copilot = "[Copilot]",
        },
        mode = 'symbol',
        maxwidth = 50,
        ellipsis_char = '...',
        show_labelDetails = true,
      })
    },
    window = {
      --completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },
    preselect = cmp.PreselectMode.None,
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ["<C-p>"] = cmp.mapping.select_prev_item(),
      ["<C-n>"] = cmp.mapping.select_next_item(),
      ['<CR>'] = cmp.mapping.confirm({ select = false }),
      ['<Tab>'] = cmp.mapping(function(fallback)
        if luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        elseif has_words_before() then
          cmp.complete()
        else
          fallback()
        end
      end, { "i", "s" }),
      ['<S-Tab>'] = cmp.mapping(function(fallback)
        if luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, { "i", "s" }),
    }),
    sources = {
      { name = 'nvim_lsp', priority = 100 },
      { name = 'luasnip', priority = 50 },
      { name = 'buffer', option = {
        get_bufnrs = function()
          local bufs = {}
          for _, win in ipairs(api.nvim_list_wins()) do
            bufs[api.nvim_win_get_buf(win)] = true
          end
          return vim.tbl_keys(bufs)
        end
      }, priority = 40 },
      { name = 'path', priority = 90 },
      { name = 'copilot', priority = 90 },
      { name = 'crates', priority = 80 },
    },
    snippet = {
      expand = function(args)
        --fn['vsnip#anonymous'](args.body)
        luasnip.lsp_expand(args.body) -- For `luasnip` users.
      end
    },
  })

  ---- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
  --cmp.setup.cmdline({ '/', '?' }, {
  --  mapping = cmp.mapping.preset.cmdline(),
  --  sources = {
  --    { name = 'buffer' }
  --  }
  --})

  ---- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  --cmp.setup.cmdline(':', {
  --  mapping = cmp.mapping.preset.cmdline(),
  --  sources = cmp.config.sources({
  --    { name = 'path' }
  --  }, {
  --    { name = 'cmdline' }
  --  }),
  --  matching = { disallow_symbol_nonprefix_matching = false }
  --})
end

local skkeleton_indicator_enable = function()
  if vim.fn.has('win32') then
    return false
  else
    return true
  end
end

return {
  {
    'hrsh7th/nvim-cmp',
    -- module = { "cmp" },
    dependencies = {
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-path' },
      { 'hrsh7th/cmp-cmdline' },
      { 'saadparwaiz1/cmp_luasnip' },
      {
        'onsails/lspkind.nvim',
        config = function()
          require("lspkind").init({
            -- enables text annotations
            --
            -- default: true
            mode = "symbol_text",

            -- default symbol map
            -- can be either 'default' (requires nerd-fonts font) or
            -- 'codicons' for codicon preset (requires vscode-codicons font)
            --
            -- default: 'default'
            preset = "codicons",

            -- override preset symbols
            --
            -- default: {}
            -- TODO: change symbols
            -- reference: https://code.visualstudio.com/api/references/icons-in-labels
            -- for Cica font: https://miiton.github.io/Cica/
            symbol_map = {
              Text = "",
              Method = "",
              Function = "",
              Constructor = "",
              Field = "󿚦",
              Variable = "󿚦",
              Class = "",
              Interface = "",
              Module = "",
              Property = "",
              Unit = "U",
              Value = "V",
              Enum = "",
              Keyword = "",
              Snippet = "",
              Color = "󿚗",
              File = "󿜣",
              Reference = "",
              Folder = "󿝕",
              EnumMember = "",
              Constant = "",
              Struct = "",
              Event = "E",
              Operator = "O",
              TypeParameter = "T",
              Copilot = "",
            },
        })
        end
      },
    },
    config = nvim_cmp_config,
    event = { 'VimEnter' },
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
    },
    config = function()
      imap('<C-j>', '<Plug>(skkeleton-toggle)')
      cmap('<C-j>', '<Plug>(skkeleton-toggle)')

      vim.fn["denops#plugin#wait_async"]("skkeleton", function()
        vim.g["skkeleton#mapped_keys"] = { "<C-l>" }
        vim.fn["skkeleton#register_keymap"]("input", "[", "katakana")
        vim.fn["skkeleton#register_keymap"]("input", "'", "disable")
        vim.fn["skkeleton#register_keymap"]("input", "<C-l>", "zenkaku")
        vim.fn["skkeleton#register_keymap"]("input", ";", "henkanPoint")
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

        --vim.fn["skkeleton#initialize"]()
      end)

    end
  },
  {
    "delphinus/skkeleton_indicator.nvim",

    init = function()
      require("skkeleton_indicator").setup{
        nord = function(colors)
          api.set_hl(0, "SkkeletonIndicatorEiji", { fg = colors.cyan, bg = colors.dark_black, bold = true })
          api.set_hl(0, "SkkeletonIndicatorHira", { fg = colors.dark_black, bg = colors.green, bold = true })
          api.set_hl(0, "SkkeletonIndicatorKata", { fg = colors.dark_black, bg = colors.yellow, bold = true })
          api.set_hl(0, "SkkeletonIndicatorHankata", { fg = colors.dark_black, bg = colors.magenta, bold = true })
          api.set_hl(0, "SkkeletonIndicatorZenkaku", { fg = colors.dark_black, bg = colors.cyan, bold = true })
          api.set_hl(0, "SkkeletonIndicatorAbbrev", { fg = colors.white, bg = colors.red, bold = true })
        end,
      }
    end,
    enabled = skkeleton_indicator_enable,

    ---@type SkkeletonIndicatorOpts
    opts = { fadeOutMs = 0, ignoreFt = { "dropbar_menu" } },
  },

  {
    'windwp/nvim-autopairs',
    event = { 'InsertEnter' },
    config = function()
      require("nvim-autopairs").setup({ map_c_h = true })
    end,
  },
  {
		"L3MON4D3/LuaSnip",
		event = "VimEnter",
		build = "make install_jsregexp",
		config = function()
			require("luasnip").setup({})
		end,
  },
}
