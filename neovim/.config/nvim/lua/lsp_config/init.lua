local fn = vim.fn
-- local opt = vim.opt
-- local cmd = vim.cmd
-- local g = vim.g
-- local o = vim.o
-- local env = vim.env
local utils = require("utils")
local nmap = utils.nmap
local vmap = utils.vmap
local imap = utils.imap
local xmap = utils.xmap
local omap = utils.omap
local inoremap = utils.inoremap
local nnoremap = utils.nnoremap
local vnoremap = utils.vnoremap

-- Core mappings changed
inoremap("jk","<Esc>")
nnoremap("<C-h>", "^")
vnoremap("<C-h>", "^")
nnoremap("<C-l>", "g")
vnoremap("<C-l>", "g")
nnoremap("<C-j>", "<c-d>")
vnoremap("<C-j>", "<c-d>")
nnoremap("<C-k>", "<c-u>")
vnoremap("<C-k>", "<c-u>")

-- Packer Config
local packer_bootstrap
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

vim.cmd([[
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
	use 'itchyny/lightline.vim' -- Fancier statusline
	use 'ludovicchabant/vim-gutentags' -- Automatic tags management
	-- Add indentation guides even on blank lines
	use 'lukas-reineke/indent-blankline.nvim'
	-- Add git related info in the signs columns and popups
	use { 'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' } }
	-- Highlight, edit, and navigate code using a fast incremental parsing library
	use {
		'nvim-treesitter/nvim-treesitter',
		run = ':TSUpdate'
	}
	-- Additional textobjects for treesitter
	use 'nvim-treesitter/nvim-treesitter-textobjects'
	use 'neovim/nvim-lspconfig' -- Collection of configurations for built-in LSP client
	use 'hrsh7th/nvim-cmp' -- Autocompletion plugin
	use 'hrsh7th/cmp-nvim-lsp'
  use {
    "folke/which-key.nvim",
    config = function()
      require("which-key").setup (
        {
          -- your configuration comes here
          -- or leave it empty to use the default settings
          -- refer to the configuration section below
        }

      )    end
  }
	use 'andymass/vim-matchup'
	use 'vim-test/vim-test'
	use 'jiangmiao/auto-pairs'
	use 'tpope/vim-projectionist'
	use 'rhysd/git-messenger.vim'
	use 'maxbrunsfeld/vim-yankstack'
	use 'tpope/vim-unimpaired'
	use 'chaoren/vim-wordmotion'
	use 'hrsh7th/cmp-vsnip'
	use 'hrsh7th/vim-vsnip'
	use 'SirVer/ultisnips'
	use 'honza/vim-snippets'
	use 'quangnguyen30192/cmp-nvim-ultisnips'
	use 'wellle/targets.vim'
	use 'kyazdani42/nvim-web-devicons'
	use 'kyazdani42/nvim-tree.lua'
	use 'nvim-lua/lsp-status.nvim'
	use 'glepnir/lspsaga.nvim'
	-- use 'sunjon/shade.nvim'
	use 'folke/twilight.nvim'
	use 'morhetz/gruvbox'
	use {'prettier/vim-prettier', run = 'yarn install' }
	use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  if packer_bootstrap then
    require('packer').sync()
  end
end)

-- General
vim.o.foldlevelstart = 6
vim.o.autoindent = true
vim.o.smartindent = true
-- Set highlight on search
--vim.o.hlsearch = false

--Make line numbers default
vim.wo.number = true
--Enable mouse mode
vim.o.mouse = 'a'

--Enable break indent
vim.o.breakindent = true

--Save undo history
vim.opt.undofile = true

--Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

--Decrease update time
vim.o.updatetime = 250
vim.wo.signcolumn = 'yes'

--Remap space as leader key
vim.api.nvim_set_keymap('', '<Space>', '<Nop>', { noremap = true, silent = true })
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
--Remap for dealing with word wrap
vim.api.nvim_set_keymap('n', 'k', "v:count == 0 ? 'gk' : 'k'", { noremap = true, expr = true, silent = true })
vim.api.nvim_set_keymap('n', 'j', "v:count == 0 ? 'gj' : 'j'", { noremap = true, expr = true, silent = true })
--Set colorscheme (order is important here)
vim.o.termguicolors = true
vim.g.onedark_terminal_italics = 2
 vim.g.onedark_transparent_background = true
vim.g.background = 'light'
vim.cmd [[colorscheme onedark]]

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
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  --buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('v', '<leader>ca', '<cmd>lua vim.lsp.buf.range_code_action()<CR>', opts)
  buf_set_keymap('n', '<leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '<leader>so', [[<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]], opts)
  vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]
end
-- nvim-cmp supports additional completion capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
-- Use a loop to conveniently call 'setup' on multiple servers and
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
        }
      },
      layout_strategy = 'vertical'
    },
    pickers = {
    },
    extensions = {
    }
  }
)
-- To get fzf loaded and working with telescope, you need to call
require('telescope').load_extension('fzf')
--Add leader shortcuts
vim.api.nvim_set_keymap('n', '<leader><space>', [[<cmd>lua require('telescope.builtin').buffers()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>sf', [[<cmd>lua require('telescope.builtin').find_files({previewer = false})<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>sb', [[<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>sh', [[<cmd>lua require('telescope.builtin').help_tags()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>st', [[<cmd>lua require('telescope.builtin').tags()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>sd', [[<cmd>lua require('telescope.builtin').grep_string()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>sp', [[<cmd>lua require('telescope.builtin').live_grep()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>so', [[<cmd>lua require('telescope.builtin').tags{ only_current_buffer = true }<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>?', [[<cmd>lua require('telescope.builtin').oldfiles()<CR>]], { noremap = true, silent = true })
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
					{ key = {"<C-]>"},    cb = tree_cb("cd") },
					{ key = "p",                        cb = tree_cb("preview") },
					{ key = "g?",                           cb = tree_cb("toggle_help") },
					{ key = "<C-x>",                        cb = tree_cb("split") },
					{ key = "<C-t>",                        cb = tree_cb("tabnew") },
					{ key = "<",                            cb = tree_cb("prev_sibling") },
					{ key = ">",                            cb = tree_cb("next_sibling") },
					{ key = "P",                            cb = tree_cb("parent_node") },
					{ key = "H",                            cb = tree_cb("toggle_dotfiles") }, { key = "R",                            cb = tree_cb("refresh") },
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
--Set statusbar
vim.g.lightline = {
  colorscheme = 'onedark',
  active = { left = { { 'mode', 'paste' }, { 'gitbranch', 'readonly', 'filename', 'modified' } } },
  component_function = { gitbranch = 'fugitive#head' },
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
-- vim.g.indent_blankline_char = '┊'
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
-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'
local cmp = require'cmp'
cmp.setup({
  snippet = {
    expand = function(args)
      -- For `vsnip` user.
      vim.fn["vsnip#anonymous"](args.body)

      -- For `luasnip` user.
      -- require('luasnip').lsp_expand(args.body)

      -- For `ultisnips` user.
       vim.fn["UltiSnips#Anon"](args.body)
    end,
  },
  mapping = {
    ['<C-k>'] = cmp.mapping.select_prev_item(),
    ['<C-j>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    }),
    ['<Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end,
    ['<S-Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end,
  },
  sources = {
    { name = 'nvim_lsp' },
    -- For vsnip user.
    { name = 'vsnip' },
    -- For ultisnips user.
    { name = 'ultisnips' },
    { name = 'buffer' },
  }
})
-- vim fugitive

vim.g.fugitive_pty = 0
vim.api.nvim_set_keymap('n', '<leader>gg', ':Git<SPACE>',      {noremap = true})
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
vim.g.gutentags_generate_on_empty_buffer = true
vim.cmd([[command! -nargs=0 GutentagsClearCache call system('rm ' . g:gutentags_cache_dir . '/*')]])
vim.g.gutentags_ctags_extra_args = {'--tag-relative=yes', '--fields=+ailmnS', }
