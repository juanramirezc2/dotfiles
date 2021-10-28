local fn = vim.fn
local opt = vim.opt
local cmd = vim.cmd
local g = vim.g
local o = vim.o
-- local env = vim.env
local utils = require("utils")
-- local nmap = utils.nmap
-- local vmap = utils.vmap
-- local imap = utils.imap
-- local xmap = utils.xmap
-- local omap = utils.omap
local inoremap = utils.inoremap
local nnoremap = utils.nnoremap
local vnoremap = utils.vnoremap  

-- Core mappings changed
inoremap("jk","<Esc>")
nnoremap("<C-h>", "^")
vnoremap("<C-h>", "^")
nnoremap("<C-l>", "g_")
vnoremap("<C-l>", "g_")
nnoremap("<C-j>", "<c-d>")
vnoremap("<C-j>", "<c-d>")
nnoremap("<C-k>", "<c-u>")
vnoremap("<C-k>", "<c-u>")
-- Get rid of annoying ex keybind
vim.api.nvim_set_keymap('', 'Q', '<Nop>', { noremap = true, silent = true })
-- Managing buffers
vim.api.nvim_set_keymap('n', '<leader>bd', ':bdelete<CR>', { noremap = true, silent = true })

-- Packer Config
local packer_bootstrap
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

require('packer').startup(function(use)
	use 'wbthomason/packer.nvim' -- Package manager
	use 'tpope/vim-fugitive'
	use 'tpope/vim-commentary' -- "gc" to comment visual regions/lines
	-- UI to select things (files, grep results, open buffers...)
	use { 'nvim-telescope/telescope.nvim', requires = { 'nvim-lua/plenary.nvim' } }
	use 'joshdick/onedark.vim' -- Theme inspired by Atom
  use { 'nvim-lualine/lualine.nvim', requires = {'kyazdani42/nvim-web-devicons', opt = true} }
  use 'arkav/lualine-lsp-progress' -- Integration with progress notifications
	use 'ludovicchabant/vim-gutentags' -- Automatic tags management
	-- Add indentation guides even on blank lines
	use 'lukas-reineke/indent-blankline.nvim'
	-- Add git related info in the signs columns and popups
	use { 'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' } }
	-- Highlight, edit, and navigate code using a fast incremental parsing library
	use {
		'nvim-treesitter/nvim-treesitter',
		run = ':TSUpdate',
    requires = {
      { 'p00f/nvim-ts-rainbow', after = 'nvim-treesitter' },
      { 'nvim-treesitter/nvim-treesitter-textobjects', after = 'nvim-treesitter' },
      { 'andymass/vim-matchup', after = 'nvim-treesitter' },
    }
  }
  use {
    "folke/which-key.nvim",
    config = function()
      require("which-key").setup (
        {
          window = {
            border = { '─', '─', '─', ' ', ' ', ' ', ' ', ' ' }, -- none, single, double, shadow
            position = 'bottom', -- bottom, top
            margin = { 0, 0, 0, 0 }, -- extra window margin [top, right, bottom, left]
            padding = { 0, 0, 1, 0 }, -- extra window padding [top, right, bottom, left]
          },
        }

      )
    end
  }
  use 'norcalli/nvim-colorizer.lua'
  use 'onsails/lspkind-nvim' -- vscode-like pictograms to neovim built-in lsp
  use 'mfussenegger/nvim-lint'
	use 'vim-test/vim-test'
	use 'tpope/vim-projectionist'
	use 'rhysd/git-messenger.vim'
	use 'maxbrunsfeld/vim-yankstack'
	use 'tpope/vim-unimpaired'
	use 'chaoren/vim-wordmotion'
	use 'neovim/nvim-lspconfig' -- Collection of configurations for built-in LSP client
	use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use({
    "SirVer/ultisnips",
    config = function()
      vim.g.UltiSnipsRemoveSelectModeMappings = 0
    end,
  })
  use 'hrsh7th/nvim-cmp'
  use 'quangnguyen30192/cmp-nvim-ultisnips'
	use 'wellle/targets.vim'
	use 'kyazdani42/nvim-web-devicons'
	use 'kyazdani42/nvim-tree.lua'
	use 'nvim-lua/lsp-status.nvim'
  use { 'tami5/lspsaga.nvim' }
	-- use 'sunjon/shade.nvim'
	use 'folke/twilight.nvim'
	use 'morhetz/gruvbox'
	use {'sbdchd/neoformat'}
	use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  if packer_bootstrap then
    require('packer').sync()
  end
end)

-- General
opt.backup = false -- don't use backup files
opt.writebackup = false -- don't backup the file while editing
opt.swapfile = false -- don't create swap files for new buffers
o.foldlevelstart = 6
o.autoindent = true
o.smartindent = true
-- Set highlight on search
--vim.o.hlsearch = false

--Make line numbers default
vim.wo.number = true
--Enable mouse mode
o.mouse = 'a'

--Enable break indent
o.breakindent = true

--Save undo history
opt.undofile = true

--Case insensitive searching UNLESS /C or capital in search
o.ignorecase = true
o.smartcase = true

--Decrease update time
o.updatetime = 250
vim.wo.signcolumn = 'yes'

--Remap space as leader key
vim.api.nvim_set_keymap('', '<Space>', '<Nop>', { noremap = true, silent = true })
g.mapleader = ' '
g.maplocalleader = ' '
--Remap for dealing with word wrap
vim.api.nvim_set_keymap('n', 'k', "v:count == 0 ? 'gk' : 'k'", { noremap = true, expr = true, silent = true })
vim.api.nvim_set_keymap('n', 'j', "v:count == 0 ? 'gj' : 'j'", { noremap = true, expr = true, silent = true })
--Set colorscheme (order is important here)
o.termguicolors = true
-- g.onedark_terminal_italics = 2
-- g.onedark_transparent_background = true
-- cmd [[colorscheme onedark]]
g.gruvbox_contrast_dark = 'soft'
-- o.background = 'light'
cmd [[colorscheme gruvbox]]

-----------------------------LSP CONFIG ---------------------------------------
local lsp_status = require('lsp-status')
lsp_status.register_progress()
local nvim_lsp = require('lspconfig')
-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  lsp_status.on_attach(client)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  --buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  --buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  ----buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  --buf_set_keymap('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  --buf_set_keymap('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  --buf_set_keymap('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  --buf_set_keymap('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  --buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  --buf_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  --buf_set_keymap('v', '<leader>ca', '<cmd>lua vim.lsp.buf.range_code_action()<CR>', opts)
  --buf_set_keymap('n', '<leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  --buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  --buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  --buf_set_keymap('n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '<leader>so', [[<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]], opts)
  buf_set_keymap('n', 'gr', [[<cmd>lua require('telescope.builtin').lsp_references()<cr>]], opts)
  -- cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]
  local map = buf_set_keymap
  map("n", "<leader>rn", "<cmd>Lspsaga rename<cr>", {silent = true, noremap = true})
  map("n", "<leader>ca", "<cmd>Lspsaga code_action<cr>", {silent = true, noremap = true})
  map("x", "gx", ":<c-u>Lspsaga range_code_action<cr>", {silent = true, noremap = true})
  map("n", "K",  "<cmd>Lspsaga hover_doc<cr>", {silent = true, noremap = true})
  map("n", "go", "<cmd>Lspsaga show_line_diagnostics<cr>", {silent = true, noremap = true})
  map("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<cr>", {silent = true, noremap = true})
  map("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<cr>", {silent = true, noremap = true})
  map("n", "<C-u>", "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<cr>",{})
  map("n", "<C-d>", "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<cr>",{})
end
-- nvim-cmp supports additional completion capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
-- Use a loop to conveniently call 'setup' on multiple servers andasdf
-- map buffer local keybindings when the language server attaches
local servers = { 'tsserver', 'tailwindcss' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup(
    {
      on_attach = on_attach,
      capabilities = capabilities,
    }
  )
end
----------------- LUA LSP Server --------------------
local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")
local sumneko_root_path = vim.fn.getenv 'HOME' .. '/.code/lua-language-server' -- custom folder ~/.code were lsp client was cloned and built
local sumneko_binary = sumneko_root_path .. '/bin/macOS/lua-language-server'

nvim_lsp.sumneko_lua.setup(
  {
    cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"};
    settings = {
      Lua = {
        runtime = {
          -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
          version = 'LuaJIT',
          -- Setup your lua path
          path = runtime_path,
        },
        diagnostics = {
          -- Get the language server to recognize the `vim` global
          globals = {'vim'},
        },
        workspace = {
          -- Make the server aware of Neovim runtime files
          library = vim.api.nvim_get_runtime_file("", true),
        },
        -- Do not send telemetry data containing a randomized but unique identifier
        telemetry = {
          enable = false,
        },
      },
    },
    on_attach = on_attach
  }
)
----------------------- nvim treesitter ---------------------
require'nvim-treesitter.configs'.setup(
  {
    ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
    highlight = {
      enable = true,              -- false will disable the whole extension
    },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "gnn",
        node_incremental = "grn",
        scope_incremental = "grc",
        node_decremental = "grm",
      },
    },
    indent = {
      enable = true
    },
    textobjects = {
      select = {
        enable = true,
        lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
        keymaps = {
          -- You can use the capture groups defined in textobjects.scm
          ['af'] = '@function.outer',
          ['if'] = '@function.inner',
          ['ac'] = '@class.outer',
          ['ic'] = '@class.inner',
        },
      },
      move = {
        enable = true,
        set_jumps = true, -- whether to set jumps in the jumplist
        goto_next_start = {
          [']]'] = '@function.outer',
          [']m'] = '@class.outer',
        },
        goto_next_end = {
          [']M'] = '@function.outer',
          [']['] = '@class.outer',
        },
        goto_previous_start = {
          ['[['] = '@function.outer',
          ['[m'] = '@class.outer',
        },
        goto_previous_end = {
          ['[M'] = '@function.outer',
          ['[]'] = '@class.outer',
        },
      },
      swap = {
        enable = true,
        swap_next = {
          ["<leader>a"] = "@parameter.inner",
        },
        swap_previous = {
          ["<leader>A"] = "@parameter.inner",
        },
      },
      lsp_interop = {
        enable = true,
        border = 'none',
        peek_definition_code = {
          ["<leader>df"] = "@function.outer",
          ["<leader>dF"] = "@class.outer",
        },
      },
    },
    rainbow = {
      enable = true,
      extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
      max_file_lines = nil, -- Do not enable for files with more than n lines, int
      -- colors = {
      --   'royalblue3',
      --   'darkorange3',
      --   'seagreen3',
      --   'firebrick',
      --   'darkorchid3',
      -- },
    },
    matchup = { --vim matchup has tree-sitter support
      enable = true,              -- mandatory, false will disable the whole extension
    },
    autopairs = { enable = true },
    query_linter = {
      enable = true,
      use_virtual_text = true,
      lint_events = { 'BufWrite', 'CursorHold' },
    },
  }
)
vim.api.nvim_exec([[
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
]], true)

-- telescope nvim
require('telescope').setup(
  {
    defaults = {
      mappings = {
        i = {
          ["<C-j>"] = "move_selection_next",
          ["<C-k>"] = "move_selection_previous",
          ["<C-d>"] = "delete_buffer"
        }
      },
      layout_strategy = 'vertical'
    },
    pickers = {
    },
    extensions = {
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true, -- override the file sorter
      case_mode = 'smart_case', -- or "ignore_case" or "respect_case"
      -- the default case_mode is "smart_case"
    }
  }
)
-- To get fzf loaded and working with telescope, you need to call
require('telescope').load_extension('fzf')
local map = vim.api.nvim_set_keymap 
--Add leader shortcuts
map('n', '<leader><space>', [[<cmd>lua require('telescope.builtin').buffers()<CR>]], { noremap = true, silent = true })
map('n', '<leader>sf', [[<cmd>lua require('telescope.builtin').find_files({previewer = false})<CR>]], { noremap = true, silent = true })
map('n', '<leader>sp', [[<cmd>lua require('telescope.builtin').live_grep()<CR>]], { noremap = true, silent = true })
map('n', '<leader>sd', [[<cmd>lua require('telescope.builtin').grep_string()<cr>]], { noremap = true, silent = true })
map('n', '<leader>?', [[<cmd>lua require('telescope.builtin').oldfiles()<CR>]], { noremap = true, silent = true })
map('n', '<leader>sl', [[<cmd>lua require('telescope.builtin').resume()<CR>]], { noremap = true, silent = true })
map('n', '<leader>sb', [[<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>]], { noremap = true, silent = true })
map('n', '<leader>sh', [[<cmd>lua require('telescope.builtin').help_tags()<CR>]], { noremap = true, silent = true })
map('n', '<leader>st', [[<cmd>lua require('telescope.builtin').tags()<CR>]], { noremap = true, silent = true })
map('n', '<leader>gc', [[<cmd>lua require('telescope.builtin').git_commits()<CR>]], { noremap = true, silent = true })
map('n', '<leader>gb', [[<cmd>lua require('telescope.builtin').git_branches()<CR>]], { noremap = true, silent = true })
map('n', '<leader>so', [[<cmd>lua require('telescope.builtin').tags{ only_current_buffer = true }<CR>]], { noremap = true, silent = true })
-------------------------nvim-web-devicons-------------------------------
require'nvim-web-devicons'.setup(
  {
    -- your personnal icons can go here (to override)
    -- DevIcon will be appended to `name`
    override = {
      zsh = {
        icon = "",
        color = "#428850",
        name = "Zsh"
      }
    };
    -- globally enable default icons (default to false)
    -- will get overriden by `get_icons` option
    default = true;
  }
)
-- nvim-tree.lua
local tree_cb = require'nvim-tree.config'.nvim_tree_callback
require'nvim-tree'.setup(
	{
		diagnostics     = {
			enable = true
		},
		view = {
			auto_resize = true,
			mappings = {
				-- custom only false will merge the list with the default mappings
				-- if true, it will only use your list to set the mappings
				custom_only = true,
				-- list of mappings to set on the tree manually
				list = {
					{ key = {"<CR>", "l", "<2-LeftMouse>"}, cb = tree_cb("edit") },
					{ key = "h",                         cb = tree_cb("close_node") },
					{ key = "u",                            cb = tree_cb("dir_up") },
					{ key = "s",                        cb = tree_cb("vsplit") },
					{ key = "I",                            cb = tree_cb("toggle_ignored") },
					{ key = "K",                            cb = tree_cb("first_sibling") },
					{ key = "J",                            cb = tree_cb("last_sibling") },
					{ key = "R",                            cb = tree_cb("refresh") },
					{ key = "r",                            cb = tree_cb("rename") },
					{ key = "d",                            cb = tree_cb("remove") },
					{ key = "a",                            cb = tree_cb("create") },
					{ key = {"<C-]>"},                      cb = tree_cb("cd") },
					{ key = "p",                            cb = tree_cb("preview") },
					{ key = "g?",                           cb = tree_cb("toggle_help") },
					{ key = "<C-x>",                        cb = tree_cb("split") },
					{ key = "<C-t>",                        cb = tree_cb("tabnew") },
					{ key = "<",                            cb = tree_cb("prev_sibling") },
					{ key = ">",                            cb = tree_cb("next_sibling") },
					{ key = "P",                            cb = tree_cb("parent_node") },
					{ key = "H",                            cb = tree_cb("toggle_dotfiles") },
          { key = "R",                            cb = tree_cb("refresh") },
					{ key = "<C-r>",                        cb = tree_cb("full_rename") },
					{ key = "x",                            cb = tree_cb("cut") },
					{ key = "c",                            cb = tree_cb("copy") },
					{ key = "p",                            cb = tree_cb("paste") },
					{ key = "y",                            cb = tree_cb("copy_name") },
					{ key = "Y",                            cb = tree_cb("copy_path") },
					{ key = "gy",                           cb = tree_cb("copy_absolute_path") },
					{ key = "[c",                           cb = tree_cb("prev_git_item") },
					{ key = "]c",                           cb = tree_cb("next_git_item") },
					{ key = "s",                            cb = tree_cb("system_open") },
					{ key = "q",                            cb = tree_cb("close") },
				}
			}
		}
	}
)

-- local onedark = require('lualine.themes.onedark')
-- for _, mode in pairs(onedark) do
--   mode.a.gui = nil
-- end
-- local onedark = require('lualine.themes.onedark')
--Set statusbar
require('lualine').setup {
  options = {
    icons_enabled = false,
    -- theme = onedark,
    component_separators = '|',
    section_separators = '',
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { 'filename' },
    -- lualine_c = { 'lsp_progress' },
    lualine_x = { 'filetype' },
    lualine_y = { 'progress' },
    lualine_z = { 'location' },
  },
}
-- Shade.nvim
-- require'shade'.setup({
--   overlay_opacity = 50,
--   opacity_step = 1,
--   keys = {
--     brightness_up    = '<C-Up>',
--     brightness_down  = '<C-Down>',
--     toggle           = '<Leader>s',
--   }
-- })
-- twilight.nvim
require("twilight").setup(
  {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  }
)
-- Gitsigns
require('gitsigns').setup {
  signs = {
    add = { hl = 'GitGutterAdd', text = '+' },
    change = { hl = 'GitGutterChange', text = '~' },
    delete = { hl = 'GitGutterDelete', text = '_' },
    topdelete = { hl = 'GitGutterDelete', text = '‾' },
    changedelete = { hl = 'GitGutterChange', text = '~' },
  },
}
-- Map blankline
vim.g.indent_blankline_char = '┊'
vim.g.indent_blankline_filetype_exclude = { 'help', 'packer' }
vim.g.indent_blankline_buftype_exclude = { 'terminal', 'nofile' }
vim.g.indent_blankline_char_highlight = 'LineNr'
vim.g.indent_blankline_show_trailing_blankline_indent = false
-- Highlight on yank
vim.api.nvim_exec(
  [[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
]],
  false
)
-- Setup nvim-cmp.
-- Snippet Helper functions
local has_any_words_before = function()
  if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then
    return false
  end
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local press = function(key)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), "n", true)
end
vim.o.completeopt = 'menu,menuone,noselect'
local lspkind = require('lspkind')
local cmp = require'cmp'
cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
    end,
  },
  formatting = {
    format = lspkind.cmp_format({with_text = false, maxwidth = 50,
    menu = {
        buffer = "[buf]",
        nvim_lsp = "[LSP]",
        nvim_lua = "[api]",
        path = "[path]",
        ultisnips = "[UltiSnips]",
        luasnip = "[LuaSnip]",
      },
    })
  },
  mapping = {
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        if vim.fn["UltiSnips#CanExpandSnippet"]() == 1 then
          return press("<C-R>=UltiSnips#ExpandSnippet()<CR>")
        end

        cmp.select_next_item()
      elseif has_any_words_before() then
        press("<Space>")
      else
        fallback()
      end
    end, { "i", "s", }),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    }),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if vim.fn.complete_info()["selected"] == -1 and vim.fn["UltiSnips#CanExpandSnippet"]() == 1 then
        press("<C-R>=UltiSnips#ExpandSnippet()<CR>")
      elseif vim.fn["UltiSnips#CanJumpForwards"]() == 1 then
        press("<ESC>:call UltiSnips#JumpForwards()<CR>")
      elseif cmp.visible() then
        cmp.select_next_item()
      elseif has_any_words_before() then
        press("<Tab>")
      else
        fallback()
      end
    end, { "i", "s", }
    ),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if vim.fn["UltiSnips#CanJumpBackwards"]() == 1 then
        press("<ESC>:call UltiSnips#JumpBackwards()<CR>")
      elseif cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end, { "i", "s", }
    ),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'ultisnips' }, -- For ultisnips users.
    { name = 'buffer', keyword_length = 5 },
  },
  experimental = {
    native_menu = false,
    ghost_text = true,
  },
})
-- vim fugitive

vim.g.fugitive_pty = 0
vim.api.nvim_set_keymap('n', '<leader>gg', ':Git<SPACE>',      {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>gr', ':Gread<CR>',       {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>gs', ':Git<CR>',         {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>gb', ':Git blame<CR>',   {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>gc', ':Git commit<CR>',  {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>gd', ':Gvdiffsplit<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>gl', ':Gclog<CR>',       {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>gp', ':Git push<CR>',    {noremap = true})

-- gutentags
vim.g.gutentags_ctags_exclude = {
	'*.git', '*.svg', '*.hg',
	'*/tests/*',
	'build',
	'dist',
	'*sites/*/files/*',
	'bin',
	'node_modules',
	'bower_components',
	'cache',
	'compiled',
	'docs',
	'example',
	'bundle',
	'vendor',
	'*.md',
	'*-lock.json',
	'*.lock',
	'*bundle*.js',
	'*build*.js',
	'.*rc*',
	'*.json',
	'*.min.*',
	'*.map',
	'*.bak',
	'*.zip',
	'*.pyc',
	'*.class',
	'*.sln',
	'*.Master',
	'*.csproj',
	'*.tmp',
	'*.csproj.user',
	'*.cache',
	'*.pdb',
	'tags*',
	'cscope.*',
	-- '*.css',
	-- '*.less',
	-- '*.scss',
	'*.exe', '*.dll',
	'*.mp3', '*.ogg', '*.flac',
	'*.swp', '*.swo',
	'*.bmp', '*.gif', '*.ico', '*.jpg', '*.png',
	'*.rar', '*.zip', '*.tar', '*.tar.gz', '*.tar.xz', '*.tar.bz2',
	'*.pdf', '*.doc', '*.docx', '*.ppt', '*.pptx',
}
vim.g.gutentags_add_default_project_roots = false
vim.g.gutentags_project_root = {'package.json', '.git'}
vim.g.gutentags_cache_dir = vim.fn.expand('~/.cache/nvim/ctags/')
vim.g.gutentags_generate_on_new = true
vim.g.gutentags_generate_on_missing = true
vim.g.gutentags_generate_on_write = true
vim.g.gutentags_file_list_command = 'fd' -- Make gutentags use ripgrep
vim.g.gutentags_generate_on_empty_buffer = true
vim.g.gutentags_trace = 1
cmd([[command! -nargs=0 GutentagsClearCache call system('rm ' . g:gutentags_cache_dir . '/*')]])
vim.g.gutentags_ctags_extra_args = {'--tag-relative=yes', '--fields=+ailmnS', }

-- nvim lint
local lint = require('lint')
lint.linters.eslint.cmd = './node_modules/.bin/eslint'
lint.linters_by_ft = {
	javascript = {'eslint'},
	typescript = {'eslint'}
}
vim.cmd([[au BufEnter,InsertLeave * lua require('lint').try_lint()]])
-- LSP saga
require 'lspsaga'.setup()
-- Which Key
local wk = require 'which-key'

wk.setup {
  window = {
    border = { '─', '─', '─', ' ', ' ', ' ', ' ', ' ' }, -- none, single, double, shadow
    position = 'bottom', -- bottom, top
    margin = { 0, 0, 0, 0 }, -- extra window margin [top, right, bottom, left]
    padding = { 0, 0, 1, 0 }, -- extra window padding [top, right, bottom, left]
  },
}

-- As an example, we will the create following mappings:
--  * <leader>ff find files
--  * <leader>fr show recent files
--  * <leader>fb Foobar
-- we'll document:
--  * <leader>fn new file
--  * <leader>fe edit file
-- and hide <leader>1

wk.register({
  f = {
    name = 'file', -- optional group name
  },
  b = {
    name = 'buffer', -- optional group name
  },
  n = {
    name = 'neovim', -- optional group name
  },
  s = {
    name = 'search', -- optional group name
  },
  w = {
    name = 'workspace', -- optional group name
  },
  q = {
    name = 'quickfix', -- optional group name
  },
  g = {
    name = 'git', -- optional group name
  },
  h = {
    name = 'help/hunks', -- optional group name
  },
  ['?'] = 'which_key_ignore',
  [';'] = 'which_key_ignore',
  [','] = 'which_key_ignore',
  ['<space>'] = 'which_key_ignore',
  ['.'] = 'which_key_ignore',
}, {
    prefix = '<leader>',
})
