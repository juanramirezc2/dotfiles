local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  'numToStr/Comment.nvim', -- "gc" to comment visual regions/lines
  'tpope/vim-sleuth',      -- Detect tabstop and shiftwidth automatically
  'tpope/vim-unimpaired',  -- [] bracket shorcuts
  'ggandor/leap.nvim', -- jump to places
  'ggandor/flit.nvim',
  'onsails/lspkind.nvim', -- vscode-like pictograms for neovim lsp completion items
  'stevearc/dressing.nvim',  -- Better UI for neovim
  "gbprod/yanky.nvim",
  "RRethy/vim-illuminate", -- automatically highlighting other uses of the word under the cursor
  "windwp/nvim-autopairs",
  'famiu/bufdelete.nvim', -- Delete Neovim buffers without losing window layout
  "windwp/nvim-ts-autotag",
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',
  'lewis6991/gitsigns.nvim' ,
  "SmiteshP/nvim-navic",
  -- colorschemes
  'folke/tokyonight.nvim',
  'navarasu/onedark.nvim', -- Theme inspired by Atom
  "ellisonleao/gruvbox.nvim",
  'shaunsingh/solarized.nvim',
  'Shatur/neovim-ayu',
  'savq/melange-nvim',
  'Th3Whit3Wolf/onebuddy',
  'Th3Whit3Wolf/one-nvim',
  'ishan9299/modus-theme-vim',
  'sainnhe/edge',
  'jim-at-jibba/ariake-vim-colors',
  'marko-cerovac/material.nvim',
  "EdenEast/nightfox.nvim", -- Packer
  "catppuccin/nvim",
  {
    'neovim/nvim-lspconfig', -- LSP Configuration & Plugins
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'jose-elias-alvarez/typescript.nvim',
      -- Useful status updates for LSP
      -- Additional lua configuration, makes nvim stuff amazing
      'folke/neodev.nvim',
    },
  },
  { 'NvChad/nvim-colorizer.lua',
    config = function()
      require 'colorizer'.setup()
    end
  },
  {
    'rcarriga/nvim-notify', -- Better Notifications
    config = function()
      local notify = require('notify')
      notify.setup({
        top_down = true,
        timeout = 3000,
        max_height = function()
          return math.floor(vim.o.lines * 0.75)
        end,
        max_width = function()
          return math.floor(vim.o.columns * 0.75)
        end,
      })
    end
  },
  {
    'andymass/vim-matchup',
    setup = function()
      -- may set any options here
      vim.g.matchup_matchparen_offscreen = { method = "popup" }
    end
  },
  {
    'nvim-treesitter/nvim-treesitter', -- Highlight, edit, and navigate code
    build = function()
      pcall(require('nvim-treesitter.install').update { with_sync = true })
    end,
  },
  {
    "nvim-neo-tree/neo-tree.nvim", -- file navigation
    branch = "v2.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    }
  },
  {
    "folke/trouble.nvim", -- A pretty diagnostics, references, telescope results, quickfix and location list to help you solve all the trouble your code is causing.
    dependencies = "nvim-tree/nvim-web-devicons",
  },
  {
    'pwntester/octo.nvim', -- About Edit and review GitHub issues and pull requests from the comfort of your favorite editor-- About Edit and review GitHub issues and pull requests from the comfort of your favorite editor
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
      'nvim-tree/nvim-web-devicons',
    }
  },
  { 'jose-elias-alvarez/null-ls.nvim', dependencies = 'nvim-lua/plenary.nvim' },
  { 'sindrets/diffview.nvim', dependencies = 'nvim-lua/plenary.nvim' },
  { 'TimUntersberger/neogit', dependencies = {
    "nvim-lua/plenary.nvim",         -- required
    "nvim-telescope/telescope.nvim", -- optional
    "sindrets/diffview.nvim",        -- optional
  }},
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    build = ":Copilot auth",
    opts = {
      suggestion = { enabled = false },
      panel = { enabled = false },
      filetypes = {
        markdown = true,
        help = true,
      },
    },
  },
  {
    "L3MON4D3/LuaSnip",
    -- follow latest release.
    tag = "v<CurrentMajor>.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
    -- install jsregexp (optional!:).
    build = "make install_jsregexp"
  },
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-path",
  "hrsh7th/cmp-cmdline",
  -- auto completion
  {
    "hrsh7th/nvim-cmp",
    version = false, -- last release is way too old
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",
    },
    opts = function()
      vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
      local cmp = require("cmp")
      local defaults = require("cmp.config.default")()
      return {
        completion = {
          completeopt = "menu,menuone,noinsert",
        },
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
          ["<S-CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        }),
        formatting = {
          format = function(_, item)
            local icons = require("lazyvim.config").icons.kinds
            if icons[item.kind] then
              item.kind = icons[item.kind] .. item.kind
            end
            return item
          end,
        },
        experimental = {
          ghost_text = {
            hl_group = "CmpGhostText",
          },
        },
        sorting = defaults.sorting,
      }
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      local Util = require("util")
      local colors = {
        [""] = Util.fg("Special"),
        ["Normal"] = Util.fg("Special"),
        ["Warning"] = Util.fg("DiagnosticError"),
        ["InProgress"] = Util.fg("DiagnosticWarn"),
      }
      table.insert(opts.sections.lualine_x, 2, {
        function()
          local icon = require("config").icons.kinds.Copilot
          local status = require("copilot.api").status.data
          return icon .. (status.message or "")
        end,
        cond = function()
          local ok, clients = pcall(vim.lsp.get_active_clients, { name = "copilot", bufnr = 0 })
          return ok and #clients > 0
        end,
        color = function()
          if not package.loaded["copilot"] then
            return
          end
          local status = require("copilot.api").status.data
          return colors[status.status] or colors[""]
        end,
      })
    end,
  },
  {
    'lukas-reineke/indent-blankline.nvim', -- Add indentation guides even on blank lines
  },
  { 'nvim-telescope/telescope.nvim', branch = '0.1.x',  dependencies = { 'nvim-lua/plenary.nvim' } },
  { "nvim-telescope/telescope-file-browser.nvim", -- File Browser extension for telescope.nvim
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
  },
})

-- ColorScheme settings
require("gruvbox").setup({
  contrast = "hard", -- can be "hard", "soft" or empty string
  italic = {
    strings = true,
    comments = true,
    operators = true,
    folds = true,
  },
})
require('material').setup({
  high_visibility = {
    lighter = true, -- Enable higher contrast text for lighter style
    darker = true   -- Enable higher contrast text for darker style
  },
})
-- Set colorscheme
vim.g.material_style = "lighter"
vim.o.background = "light"
vim.o.termguicolors = true
vim.api.nvim_set_hl(0, 'Cursor1', { bg = '#39d939' })
vim.api.nvim_set_hl(0, 'Cursor2', { bg = '#ff6666' })
vim.opt.guicursor = "n-v-c:block-Cursor1/lCursor,i-ci-ve:ver25-Cursor2/lCursor2,r-cr:hor20,o:hor50"

-- require('solarized').set()
vim.cmd [[colorscheme dayfox]]

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- Set lualine as statusline
-- See `:help lualine.txt`
require('lualine').setup({
  sections = { lualine_c = { "%{expand('%:~:.')}" }, lualine_x ={ "%{fnamemodify(getcwd(), ':t')}"} }
})

-- Enable Comment.nvim
require('Comment').setup()


-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
local trouble = require("trouble.providers.telescope")
local actions = require "telescope.actions"
require('telescope').setup {
  defaults = {
    vimgrep_arguments = { --To trim the indentation at the beginning of presented line in the result window,
      "rg",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
      "--trim" -- add this value
    },
    layout_config = { height = 0.95 },
    mappings = {
      i = {
        ["<c-t>"] = trouble.open_with_trouble,
        ["<c-d>"] = actions.delete_buffer + actions.move_to_top,
        ["<C-u>"] = false,
        ["<C-d>"] = false,
        ["<c-n>"] = actions.move_selection_next,
        ["<c-p>"] = actions.move_selection_previous
      },
      n = {
        ["j"] = actions.move_selection_next,
        ["k"] = actions.move_selection_previous,
      }
    },
  },
}
-- Enable telescope file browser
require("telescope").load_extension "file_browser"

-- open file_browser with the path of the current buffer
vim.keymap.set("n", "<leader>fb", require "telescope".extensions.file_browser.file_browser, { noremap = true })

-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>fr', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer]' })

-- Telescope Mappings
vim.api.nvim_set_keymap('n', '<leader><space>', "<cmd>Telescope buffers show_all_buffers=true<cr>",
  { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>fc', function() require('telescope.builtin').colorscheme({ enable_preview = true }) end,
  { desc = '[S]earch [C]olorscheme' })
vim.keymap.set('n', '<leader>fg', require('telescope.builtin').git_files, { desc = 'Search [G]it [F]iles' })
vim.keymap.set('n', '<leader>ff', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.api.nvim_set_keymap('n', '<leader>:', "<cmd>Telescope command_history<cr>", { desc = 'Command History' })
vim.api.nvim_set_keymap('n', '<leader>sm', "<cmd>Telescope marks<cr>", { desc = 'Jump to Mark' })
vim.api.nvim_set_keymap('n', '<leader>sd', "<cmd>Telescope diagnostics<cr>", { desc = 'Diagnostics' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sl', require('telescope.builtin').resume, { desc = '[S]earch [L]ast' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
-- vim.keymap.set('n', '<leader>sg', Util("live_grep"), { desc = '[S]earch by [G]rep' })
-- vim.keymap.set('n', '<leader>sG', Util("live_grep", { cwd = false }), { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- LSP settings ------------------------{{{{{{{{{{{{{{{{{{{{{{{{
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(client, bufnr)
  if client.name == "tsserver" then
    -- stylua: ignore
    vim.keymap.set("n", "<leader>co", "<cmd>TypescriptOrganizeImports<CR>", { buffer = bufnr, desc = "Organize Imports" })
    vim.keymap.set("n", "<leader>cR", "<cmd>TypescriptRenameFile<CR>", { desc = "Rename File", buffer = bufnr })
  end
  -- In this case, we create a function that lets us more easily define mappings specific
  -- for LSP related items. It sets the mode, buffer and description for us each time.
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end
  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

  nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
  nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
  nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
  nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  -- See `:help K` for why this keymap
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

  -- Lesser used LSP functionality
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist Folders')

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
end

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
local servers = {
  pyright = {},
  tsserver = {},
  lua_ls = {},
}

-- Setup neovim lua configuration
require('neodev').setup()
--
-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Setup mason so it can manage external tooling
require('mason').setup()

-- Ensure the servers above are installed
local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {
  function(server_name)
    require('lspconfig')[server_name].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = servers[server_name],
    }
  end,
  ["tsserver"] = function()
    require("typescript").setup({
      disable_commands = false, -- prevent the plugin from creating Vim commands
      debug = false,            -- enable debug logging for commands
      go_to_source_definition = {
        fallback = true,        -- fall back to standard LSP definition on failure
      },
      server = {
        capabilities = capabilities,
        on_attach = on_attach
      }
    })
  end
}
-- end LSP Settings ---------------}}}}}}}}}}}}}}}}}}}}}}}}
-- Turn on lsp status information

require("nvim-autopairs").setup {}

-- Neogit
local neogit = require('neogit')
vim.api.nvim_set_keymap('n', '<leader>gs', ':Neogit<CR>', {})
vim.api.nvim_set_keymap('n', '<leader>gd', ':DiffviewOpen<CR>', {})
vim.api.nvim_set_keymap('n', '<leader>gD', ':DiffviewOpen main<CR>', {})
neogit.setup {
  -- Neogit refreshes its internal state after specific events, which can be expensive depending on the repository size.
  -- Disabling `auto_refresh` will make it so you have to manually refresh the status after you open it.
  auto_refresh = true,
  disable_builtin_notifications = false,
  use_magit_keybindings = false,
  commit_popup = {
    kind = "split",
  },
  integrations = {
    diffview = true
  },
}

-- nvim tree

-- Yanky
vim.keymap.set({ "n", "x" }, "p", "<Plug>(YankyPutAfter)")
vim.keymap.set({ "n", "x" }, "P", "<Plug>(YankyPutBefore)")
vim.keymap.set({ "n", "x" }, "gp", "<Plug>(YankyGPutAfter)")
vim.keymap.set({ "n", "x" }, "gP", "<Plug>(YankyGPutBefore)")
---- kill ring
vim.keymap.set("n", "<c-n>", "<Plug>(YankyCycleForward)")
vim.keymap.set("n", "<c-p>", "<Plug>(YankyCycleBackward)")

local utils = require("yanky.utils")
local mapping = require("yanky.telescope.mapping")

require("yanky").setup({
  ring = {
    history_length = 100,
    storage = "shada",
    sync_with_numbered_registers = true,
    cancel_event = "update",
    ignore_registers = { "_" },
  },
  system_clipboard = {
    sync_with_ring = true,
  },
  highlight = {
    on_put = true,
    on_yank = true,
    timer = 500,
  },
  picker = {
    telescope = {
      use_default_mappings = false,
      mappings = {
        default = mapping.put("p"),
        i = {
          ["<c-l>"] = mapping.put("p"),
          ["<c-k>"] = mapping.put("P"),
          ["<c-d>"] = mapping.delete(),
          ["<c-r>"] = mapping.set_register(utils.get_default_register()),
        },
        n = {
          p = mapping.put("p"),
          P = mapping.put("P"),
          d = mapping.delete(),
          r = mapping.set_register(utils.get_default_register())
        },
      }
    }
  }
})

vim.keymap.set('n', '<leader>p', function() require("telescope").extensions.yank_history.yank_history({}) end,
  { desc = 'Open Yank History' })
require("telescope").load_extension("yank_history")
-- Leap config
require('leap').add_default_mappings()
-- Flit config
require('flit').setup()

-- blank line
-- See `:help indent_blankline.txt`
require('indent_blankline').setup {
  -- char = "│",
  -- show_trailing_blankline_indent = false,
  -- show_current_context = true,
  -- show_current_context_start = false,
  space_char_blankline = " ",
  show_current_context = true,
  show_current_context_start = true,
}


-- null ls nvim
local null_ls = require("null-ls")
vim.cmd('map <Leader>ln :NullLsInfo<CR>')
-- format on save using lsp format
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
require("null-ls").setup({
  sources = {
    null_ls.builtins.code_actions.eslint_d,
    null_ls.builtins.formatting.prettierd,
    null_ls.builtins.diagnostics.eslint_d,
    null_ls.builtins.diagnostics.commitlint,
    -- null_ls.builtins.diagnostics.cspell,
    -- null_ls.builtins.code_actions.cspell
    -- null_ls.builtins.completion.spell,
  },
  -- you can reuse a shared lspconfig on_attach callback here
  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({ bufnr = bufnr })
        end,
      })
    end
  end,
})

-- trouble
require("trouble").setup({ use_diagnostic_signs = true })
-- Lua
vim.keymap.set("n", "<leader>xx", "<cmd>TroubleToggle<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>xl", "<cmd>TroubleToggle loclist<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "gr", "<cmd>TroubleToggle lsp_references<cr>", { silent = true, noremap = true })

-- Unless you are still migrating, remove the deprecated commands from v1.x
vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

-- If you want icons for diagnostic errors, you'll need to define them somewhere:
vim.fn.sign_define("DiagnosticSignError", { text = " ", texthl = "DiagnosticSignError" })
vim.fn.sign_define("DiagnosticSignWarn", { text = " ", texthl = "DiagnosticSignWarn" })
vim.fn.sign_define("DiagnosticSignInfo", { text = " ", texthl = "DiagnosticSignInfo" })
vim.fn.sign_define("DiagnosticSignHint", { text = "", texthl = "DiagnosticSignHint" })
-- NOTE: this is changed from v1.x, which used the old style of highlight groups
-- in the form "LspDiagnosticsSignWarning"

-- Neo-tree configs {{{{
require("neo-tree").setup({
  sync_root_with_cwd = true,
  filesystem = {
    follow_current_file = true,
    use_libuv_file_watcher = true,
  },
  window = {
    width = 40,
    mappings = {
      ["<space>"] = "none",
      ["l"] = "open",
      ["h"] = "close_node",
    },
  },
  default_component_configs = {
    indent = {
      with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
      expander_collapsed = "",
      expander_expanded = "",
      expander_highlight = "NeoTreeExpander",
    },
  },
})

-- vim.keymap.set('n', '<leader>fe', function() require("neo-tree.command").execute({ toggle = true }) end, { desc = 'Explorer NeoTree (root dir)' })
-- vim.keymap.set('n', '<leader>fE', function() require("neo-tree.command").execute({ toggle = true, dir = Get_root() }) end, { desc = 'Explorer NeoTree (cwd)' })

vim.api.nvim_set_keymap('n', [[\]], "<cmd>Neotree toggle current reveal_force_cwd<cr>", { noremap = true })
vim.api.nvim_set_keymap('n', [[|]], "<cmd>Neotree reveal<cr>", { noremap = true })
vim.api.nvim_set_keymap('n', [[gd]], "<cmd>Neotree float reveal_file=<cfile> reveal_force_cwd<cr>", { noremap = true })
vim.api.nvim_set_keymap('n', [[<leader>b]], "<cmd>Neotree toggle show buffers right<cr>", { noremap = true })
vim.api.nvim_set_keymap('n', [[<leader>s]], "<cmd>Neotree float git_status<cr>", { noremap = true })

-- vim.cmd([[nnoremap \ :Neotree reveal<cr>]])
-- }}}}

-- Treesitter config

require('nvim-treesitter.configs').setup {
  ensure_installed = {
    "bash",
    "html",
    "javascript",
    'jsdoc',
    "json",
    "lua",
    "luadoc",
    "luap",
    "markdown",
    "markdown_inline",
    "python",
    "query",
    "regex",
    "tsx",
    "typescript",
    "vim",
    "vimdoc",
    "yaml",
  },
  highlight = { enable = true },
  indent = { enable = true, disable = { 'python' } },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<c-space>',
      node_incremental = '<c-space>',
      scope_incremental = '<c-s>',
      node_decremental = '<c-backspace>',
    },
  },
  matchup = {
    enable = true, -- mandatory, false will disable the whole extension
  },
  autotag = {
    enable = true,
  }
}

vim.o.foldmethod = "expr"
-- vim.o.foldexpr = "nvim_treesitter#foldexpr()"
vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.o.foldlevelstart = 99
--vim.o.foldcolumn = "auto"
vim.o.foldtext = [[v:folddashes.substitute(getline(v:foldstart),'/\\*\\\|\\*/\\\|{{{\\d\\=','','g')]]

vim.api.nvim_set_hl(0, 'Folded', { bg = 'grey', fg = 'blue' })
vim.api.nvim_set_hl(0, 'FoldColumn', { bg = 'darkgrey', fg = 'white' })

-- bufdelete.nvim mappings
vim.keymap.set('n', '<leader>bd', function() require('bufdelete').bufdelete(0, true) end, { desc = '[B]uffer [D]elete' })

-- Git signs setup
require('gitsigns').setup({
  debug_mode                   = true,
  signs                        = {
    add = { text = "▎" },
    change = { text = "▎" },
    delete = { text = "" },
    topdelete = { text = "" },
    changedelete = { text = "▎" },
    untracked = { text = "▎" },
  },
  signcolumn                   = true,  -- Toggle with `:Gitsigns toggle_signs`
  numhl                        = false, -- Toggle with `:Gitsigns toggle_numhl`
  linehl                       = false, -- Toggle with `:Gitsigns toggle_linehl`
  word_diff                    = false, -- Toggle with `:Gitsigns toggle_word_diff`
  watch_gitdir                 = {
    interval = 1000,
    follow_files = true
  },
  attach_to_untracked          = true,
  current_line_blame           = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
  current_line_blame_opts      = {
    virt_text = true,
    virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
    delay = 700,
    ignore_whitespace = true,
  },
  current_line_blame_formatter = '<author>, <author_time:%R> - <summary>',
  sign_priority                = 6,
  update_debounce              = 100,
  status_formatter             = nil,   -- Use default
  max_file_length              = 40000, -- Disable if file is longer than this (in lines)
  preview_config               = {
    -- Options passed to nvim_open_win
    border = 'single',
    style = 'minimal',
    relative = 'cursor',
    row = 0,
    col = 1
  },
  yadm                         = {
    enable = false
  },
  on_attach                    = function(bufnr)
    local gs = package.loaded.gitsigns

    local function map(mode, l, r, desc)
      vim.keymap.set(mode, l, r, { desc = desc })
    end

    -- Navigation
    map("n", "]c", gs.next_hunk, "Next Hunk")
    map("n", "[c", gs.prev_hunk, "Prev Hunk")

    -- Actions
    map({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
    map({ "n", "v" }, "<leader>hr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
    map("n", "<leader>hS", gs.stage_buffer, "Stage Buffer")
    map("n", "<leader>hu", gs.undo_stage_hunk, "Undo Stage Hunk")
    map("n", "<leader>hR", gs.reset_buffer, "Reset Buffer")
    map("n", "<leader>hp", gs.preview_hunk, "Preview Hunk")
    map("n", "<leader>hb", function() gs.blame_line({ full = true }) end, "Blame Line")
    map("n", "<leader>hd", gs.diffthis, "Diff This")
    map("n", "<leader>hD", function() gs.diffthis("~") end, "Diff This ~")
    map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")

    -- Text object
    map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
  end
})
-- Octo nvim
require "octo".setup({
  default_remote = { "upstream", "origin" }, -- order to try remotes
  ssh_aliases = {}, -- SSH aliases. e.g. `ssh_aliases = {["github.com-work"] = "github.com"}`
  reaction_viewer_hint_icon = "", -- marker for user reactions
  user_icon = " ", -- user icon
  timeline_marker = "", -- timeline marker
  timeline_indent = "2", -- timeline indentation
  right_bubble_delimiter = "", -- bubble delimiter
  left_bubble_delimiter = "", -- bubble delimiter
  github_hostname = "", -- GitHub Enterprise host
  snippet_context_lines = 4, -- number or lines around commented lines
  gh_env = {}, -- extra environment variables to pass on to GitHub CLI, can be a table or function returning a table
  timeout = 5000, -- timeout for requests between the remote server
  ui = {
    use_signcolumn = true, -- show "modified" marks on the sign column
  },
  issues = {
    order_by = {
      -- criteria to sort results of `Octo issue list`
      field = "CREATED_AT", -- either COMMENTS, CREATED_AT or UPDATED_AT (https://docs.github.com/en/graphql/reference/enums#issueorderfield)
      direction =
      "DESC"                -- either DESC or ASC (https://docs.github.com/en/graphql/reference/enums#orderdirection)
    }
  },
  pull_requests = {
    order_by = {
      -- criteria to sort the results of `Octo pr list`
      field = "CREATED_AT",                  -- either COMMENTS, CREATED_AT or UPDATED_AT (https://docs.github.com/en/graphql/reference/enums#issueorderfield)
      direction =
      "DESC"                                 -- either DESC or ASC (https://docs.github.com/en/graphql/reference/enums#orderdirection)
    },
    always_select_remote_on_create = "false" -- always give prompt to select base remote repo when creating PRs
  },
  file_panel = {
    size = 10,       -- changed files panel rows
    use_icons = true -- use web-devicons in file panel (if false, nvim-web-devicons does not need to be installed)
  },
  mappings = {
    issue = {
      close_issue = { lhs = "<space>ic", desc = "close issue" },
      reopen_issue = { lhs = "<space>io", desc = "reopen issue" },
      list_issues = { lhs = "<space>il", desc = "list open issues on same repo" },
      reload = { lhs = "<C-r>", desc = "reload issue" },
      open_in_browser = { lhs = "<C-b>", desc = "open issue in browser" },
      copy_url = { lhs = "<C-y>", desc = "copy url to system clipboard" },
      add_assignee = { lhs = "<space>aa", desc = "add assignee" },
      remove_assignee = { lhs = "<space>ad", desc = "remove assignee" },
      create_label = { lhs = "<space>lc", desc = "create label" },
      add_label = { lhs = "<space>la", desc = "add label" },
      remove_label = { lhs = "<space>ld", desc = "remove label" },
      goto_issue = { lhs = "<space>gi", desc = "navigate to a local repo issue" },
      add_comment = { lhs = "<space>ca", desc = "add comment" },
      delete_comment = { lhs = "<space>cd", desc = "delete comment" },
      next_comment = { lhs = "]c", desc = "go to next comment" },
      prev_comment = { lhs = "[c", desc = "go to previous comment" },
      react_hooray = { lhs = "<space>rp", desc = "add/remove 🎉 reaction" },
      react_heart = { lhs = "<space>rh", desc = "add/remove ❤️ reaction" },
      react_eyes = { lhs = "<space>re", desc = "add/remove 👀 reaction" },
      react_thumbs_up = { lhs = "<space>r+", desc = "add/remove 👍 reaction" },
      react_thumbs_down = { lhs = "<space>r-", desc = "add/remove 👎 reaction" },
      react_rocket = { lhs = "<space>rr", desc = "add/remove 🚀 reaction" },
      react_laugh = { lhs = "<space>rl", desc = "add/remove 😄 reaction" },
      react_confused = { lhs = "<space>rc", desc = "add/remove 😕 reaction" },
    },
    pull_request = {
      checkout_pr = { lhs = "<space>po", desc = "checkout PR" },
      merge_pr = { lhs = "<space>pm", desc = "merge commit PR" },
      squash_and_merge_pr = { lhs = "<space>psm", desc = "squash and merge PR" },
      list_commits = { lhs = "<space>pc", desc = "list PR commits" },
      list_changed_files = { lhs = "<space>pf", desc = "list PR changed files" },
      show_pr_diff = { lhs = "<space>pd", desc = "show PR diff" },
      add_reviewer = { lhs = "<space>va", desc = "add reviewer" },
      remove_reviewer = { lhs = "<space>vd", desc = "remove reviewer request" },
      close_issue = { lhs = "<space>ic", desc = "close PR" },
      reopen_issue = { lhs = "<space>io", desc = "reopen PR" },
      list_issues = { lhs = "<space>il", desc = "list open issues on same repo" },
      reload = { lhs = "<C-r>", desc = "reload PR" },
      open_in_browser = { lhs = "<C-b>", desc = "open PR in browser" },
      copy_url = { lhs = "<C-y>", desc = "copy url to system clipboard" },
      goto_file = { lhs = "gf", desc = "go to file" },
      add_assignee = { lhs = "<space>aa", desc = "add assignee" },
      remove_assignee = { lhs = "<space>ad", desc = "remove assignee" },
      create_label = { lhs = "<space>lc", desc = "create label" },
      add_label = { lhs = "<space>la", desc = "add label" },
      remove_label = { lhs = "<space>ld", desc = "remove label" },
      goto_issue = { lhs = "<space>gi", desc = "navigate to a local repo issue" },
      add_comment = { lhs = "<space>ca", desc = "add comment" },
      delete_comment = { lhs = "<space>cd", desc = "delete comment" },
      next_comment = { lhs = "]c", desc = "go to next comment" },
      prev_comment = { lhs = "[c", desc = "go to previous comment" },
      react_hooray = { lhs = "<space>rp", desc = "add/remove 🎉 reaction" },
      react_heart = { lhs = "<space>rh", desc = "add/remove ❤️ reaction" },
      react_eyes = { lhs = "<space>re", desc = "add/remove 👀 reaction" },
      react_thumbs_up = { lhs = "<space>r+", desc = "add/remove 👍 reaction" },
      react_thumbs_down = { lhs = "<space>r-", desc = "add/remove 👎 reaction" },
      react_rocket = { lhs = "<space>rr", desc = "add/remove 🚀 reaction" },
      react_laugh = { lhs = "<space>rl", desc = "add/remove 😄 reaction" },
      react_confused = { lhs = "<space>rc", desc = "add/remove 😕 reaction" },
    },
    review_thread = {
      goto_issue = { lhs = "<space>gi", desc = "navigate to a local repo issue" },
      add_comment = { lhs = "<space>ca", desc = "add comment" },
      add_suggestion = { lhs = "<space>sa", desc = "add suggestion" },
      delete_comment = { lhs = "<space>cd", desc = "delete comment" },
      next_comment = { lhs = "]c", desc = "go to next comment" },
      prev_comment = { lhs = "[c", desc = "go to previous comment" },
      select_next_entry = { lhs = "]q", desc = "move to previous changed file" },
      select_prev_entry = { lhs = "[q", desc = "move to next changed file" },
      close_review_tab = { lhs = "<C-c>", desc = "close review tab" },
      react_hooray = { lhs = "<space>rp", desc = "add/remove 🎉 reaction" },
      react_heart = { lhs = "<space>rh", desc = "add/remove ❤️ reaction" },
      react_eyes = { lhs = "<space>re", desc = "add/remove 👀 reaction" },
      react_thumbs_up = { lhs = "<space>r+", desc = "add/remove 👍 reaction" },
      react_thumbs_down = { lhs = "<space>r-", desc = "add/remove 👎 reaction" },
      react_rocket = { lhs = "<space>rr", desc = "add/remove 🚀 reaction" },
      react_laugh = { lhs = "<space>rl", desc = "add/remove 😄 reaction" },
      react_confused = { lhs = "<space>rc", desc = "add/remove 😕 reaction" },
    },
    submit_win = {
      approve_review = { lhs = "<C-a>", desc = "approve review" },
      comment_review = { lhs = "<C-m>", desc = "comment review" },
      request_changes = { lhs = "<C-r>", desc = "request changes review" },
      close_review_tab = { lhs = "<C-c>", desc = "close review tab" },
    },
    review_diff = {
      add_review_comment = { lhs = "<space>ca", desc = "add a new review comment" },
      add_review_suggestion = { lhs = "<space>sa", desc = "add a new review suggestion" },
      focus_files = { lhs = "<leader>e", desc = "move focus to changed file panel" },
      toggle_files = { lhs = "<leader>b", desc = "hide/show changed files panel" },
      next_thread = { lhs = "]t", desc = "move to next thread" },
      prev_thread = { lhs = "[t", desc = "move to previous thread" },
      select_next_entry = { lhs = "]q", desc = "move to previous changed file" },
      select_prev_entry = { lhs = "[q", desc = "move to next changed file" },
      close_review_tab = { lhs = "<C-c>", desc = "close review tab" },
      toggle_viewed = { lhs = "<leader><space>", desc = "toggle viewer viewed state" },
    },
    file_panel = {
      next_entry = { lhs = "j", desc = "move to next changed file" },
      prev_entry = { lhs = "k", desc = "move to previous changed file" },
      select_entry = { lhs = "<cr>", desc = "show selected changed file diffs" },
      refresh_files = { lhs = "R", desc = "refresh changed files panel" },
      focus_files = { lhs = "<leader>e", desc = "move focus to changed file panel" },
      toggle_files = { lhs = "<leader>b", desc = "hide/show changed files panel" },
      select_next_entry = { lhs = "]q", desc = "move to previous changed file" },
      select_prev_entry = { lhs = "[q", desc = "move to next changed file" },
      close_review_tab = { lhs = "<C-c>", desc = "close review tab" },
      toggle_viewed = { lhs = "<leader><space>", desc = "toggle viewer viewed state" },
    }
  }
})

-- vim illuminate
-- default configuration
require("illuminate").configure(
  {
    -- providers: provider used to get references in the buffer, ordered by priority
    providers = {
      'lsp',
      'treesitter',
      'regex',
    },
    -- delay: delay in milliseconds
    delay = 200,
    -- filetype_overrides: filetype specific overrides.
    -- The keys are strings to represent the filetype while the values are tables that
    -- supports the same keys passed to .configure except for filetypes_denylist and filetypes_allowlist
    filetype_overrides = {},
    -- filetypes_denylist: filetypes to not illuminate, this overrides filetypes_allowlist
    filetypes_denylist = {
      'dirvish',
      'fugitive',
      'ql',
      'NeogitStatus',
      'NeogitCommitMessage',
      'telescope'

    },
    -- filetypes_allowlist: filetypes to illuminate, this is overriden by filetypes_denylist
    filetypes_allowlist = {},
    -- modes_denylist: modes to not illuminate, this overrides modes_allowlist
    -- See `:help mode()` for possible values
    modes_denylist = {},
    -- modes_allowlist: modes to illuminate, this is overriden by modes_denylist
    -- See `:help mode()` for possible values
    -- See `:help mode()` for possible values
    modes_allowlist = {},
    -- providers_regex_syntax_denylist: syntax to not illuminate, this overrides providers_regex_syntax_allowlist
    -- Only applies to the 'regex' provider
    -- Use :echom synIDattr(synIDtrans(synID(line('.'), col('.'), 1)), 'name')
    providers_regex_syntax_denylist = {},
    -- providers_regex_syntax_allowlist: syntax to illuminate, this is overriden by providers_regex_syntax_denylist
    -- Only applies to the 'regex' provider
    -- Use :echom synIDattr(synIDtrans(synID(line('.'), col('.'), 1)), 'name')
    providers_regex_syntax_allowlist = {},
    -- under_cursor: whether or not to illuminate under the cursor
    under_cursor = true,
    -- large_file_cutoff: number of lines at which to use large_file_config
    -- The `under_cursor` option is disabled when this cutoff is hit
    large_file_cutoff = nil,
    -- large_file_config: config to use for large files (based on large_file_cutoff).
    -- Supports the same keys passed to .configure
    -- If nil, vim-illuminate will be disabled for large files.
    large_file_overrides = nil,
    -- min_count_to_highlight: minimum number of matches required to perform highlighting
    min_count_to_highlight = 1,
  }
)

local function map(key, dir, buffer)
  vim.keymap.set("n", key, function()
    require("illuminate")["goto_" .. dir .. "_reference"]()
  end, { desc = dir:sub(1, 1):upper() .. dir:sub(2) .. " Reference", buffer = buffer })
end

map("]]", "next")
map("[[", "prev")

-- also set it after loading ftplugins, since a lot overwrite [[ and ]]
vim.api.nvim_create_autocmd("FileType", {
  callback = function()
    local buffer = vim.api.nvim_get_current_buf()
    map("]]", "next", buffer)
    map("[[", "prev", buffer)
  end,
})

-- vim.api.nvim_set_hl(0,'IlluminatedWordText',{ bg='#ff6666' })
vim.api.nvim_set_hl(0, 'IlluminatedWordRead', { link = "WildMenu" })
vim.api.nvim_set_hl(0, 'IlluminatedWordWrite', { link = 'Visual' })

-- git blame shorter
-- vim.g.gitblame_message_template = '   <summary> • <date> • <author>'
-- vim.g.gitblame_message_template = '   <author> • <date>'
-- vim.g.gitblame_date_format = '%r'
-- vim.g.gitblame_delay = 500
-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
