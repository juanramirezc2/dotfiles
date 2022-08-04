-- Install packer
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
end

vim.cmd [[
  augroup Packer
    autocmd!
    autocmd BufWritePost init.lua PackerCompile
  augroup end
]]

require('packer').startup(function(use)
  use 'wbthomason/packer.nvim' -- Package manager
  use 'numToStr/Comment.nvim' -- "gc" to comment visual regions/lines
  use 'rhysd/git-messenger.vim' -- display messages of git commits
  use 'tpope/vim-unimpaired' -- Pairs of handy bracket mappings
  use { 'TimUntersberger/neogit', requires = 'nvim-lua/plenary.nvim' }
  use 'tpope/vim-fugitive' --Git wrapper so awesome, it should be illegal
  use { 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' }
  -- UI to select things (files, grep results, open buffers...)
  use { 'nvim-telescope/telescope.nvim', requires = { 'nvim-lua/plenary.nvim' } }
  use { 'nvim-telescope/telescope-node-modules.nvim' }
  -- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  -- Add indentation guides even on blank lines
  use 'lukas-reineke/indent-blankline.nvim'
  use { 'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' } }
  -- Highlight, edit, and navigate code using a fast incremental parsing library
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  -- Treesitter extra modules {{
  use 'nvim-treesitter/nvim-treesitter-textobjects'
  use 'windwp/nvim-ts-autotag' -- Use treesitter to autoclose and autorename html tag
  use 'andymass/vim-matchup'
  -- linter
  use 'mfussenegger/nvim-lint'
  --}}
  -- nvim surround
  use({
    "kylechui/nvim-surround",
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
      })
    end
  })
  use 'neovim/nvim-lspconfig' -- Collection of configurations for built-in LSP client
  use 'williamboman/nvim-lsp-installer' -- Automatically install language servers to stdpath
  use 'hrsh7th/nvim-cmp' -- Autocompletion plugin
  use 'onsails/lspkind.nvim' -- tiny plugin adds vscode-like pictograms to neovim built-in lsp
  use 'hrsh7th/cmp-nvim-lsp'
  use 'L3MON4D3/LuaSnip' -- For luasnip users.
  use 'saadparwaiz1/cmp_luasnip'
  use 'rcarriga/nvim-notify' -- notification
  use { 'sbdchd/neoformat' }
  use { "gbprod/yanky.nvim" } -- improve yank and put functionalities for Neovim.
  use 'tpope/vim-sleuth' -- Detect tabstop and shiftwidth automatically
  use {
    'kyazdani42/nvim-tree.lua',
    requires = {
      'kyazdani42/nvim-web-devicons', -- optional, for file icon
    }, tag = 'nightly' -- optional, updated every week. (see issue #1193)
  }
  -- use 'bkad/CamelCaseMotion' -- move cammel case words
  -- use 'f-person/git-blame.nvim'
  -- colorschemes
  use 'ellisonleao/gruvbox.nvim'
  use 'marko-cerovac/material.nvim'
  use "savq/melange"
  use "sainnhe/edge"
  use "sainnhe/gruvbox-material"
  use 'olimorris/onedarkpro.nvim'
  use 'Th3Whit3Wolf/onebuddy'
  use 'Th3Whit3Wolf/one-nvim'
  -- Debugger Adaptor Protocol
  use 'mfussenegger/nvim-dap'
  use "rcarriga/nvim-dap-ui"
  use "nvim-telescope/telescope-dap.nvim"
  use 'theHamsta/nvim-dap-virtual-text'
end)


-- setup must be called before loading the colorscheme
-- Default options:
vim.o.background = "light"
require("gruvbox").setup({
  undercurl = true,
  underline = true,
  bold = true,
  italic = true,
  strikethrough = true,
  invert_selection = false,
  invert_signs = false,
  invert_tabline = false,
  invert_intend_guides = false,
  inverse = true, -- invert background for search, diffs, statuslines and errors
  -- contrast = "soft", -- can be "hard", "soft" or empty string
  overrides = {},
})
vim.o.termguicolors = true
vim.cmd("colorscheme gruvbox")
-- colorscheme
vim.g.material_style = "lighter"
vim.o.background = "light"
-- vim.cmd 'colorscheme gruvbox'
-- vim.cmd 'colorscheme material'
-- vim.cmd 'colorscheme edge'
-- vim.o.background = "light"
-- vim.o.background = "light" -- to load onelight
-- require("onedarkpro").load()

--Enable Comment.nvim
require('Comment').setup({})

--Map blankline
vim.g.indent_blankline_char = '┊'
vim.g.indent_blankline_filetype_exclude = { 'help', 'packer' }
vim.g.indent_blankline_buftype_exclude = { 'terminal', 'nofile' }
vim.g.indent_blankline_show_trailing_blankline_indent = false

-- Gitsigns
require('gitsigns').setup {
  signs = {
    add = { text = '+' },
    change = { text = '~' },
    delete = { text = '_' },
    topdelete = { text = '‾' },
    changedelete = { text = '~' },
  },
}

-- Telescope
require('telescope').setup {
  defaults = {
    layout_strategy = 'vertical',
    dynamic_preview_title = true,
    mappings = {
      i = {
        ['<C-u>'] = false,
        ["<C-d>"] = false
      },
    },
  },
}
-- Enable telescope node modules
require('telescope').load_extension 'node_modules'
-- Enable telescope fzf native
require('telescope').load_extension 'fzf'
--Add leader shortcuts
vim.api.nvim_set_keymap('n', '<leader>?', [[<cmd>lua require('telescope.builtin').oldfiles()<CR>]],
  { desc = '[?] Find recently opened files' })
vim.api.nvim_set_keymap('n', '<leader><space>', [[<cmd>lua require('telescope.builtin').buffers()<CR>]],
  { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer]' })
vim.api.nvim_set_keymap('n', '<leader>sf', [[<cmd>lua require('telescope.builtin').find_files()<CR>]], {})
vim.api.nvim_set_keymap('n', '<leader>sh', [[<cmd>lua require('telescope.builtin').help_tags()<CR>]], {})
vim.api.nvim_set_keymap('n', '<leader>sc', [[<cmd>lua require('telescope.builtin').colorscheme()<CR>]], {})
vim.api.nvim_set_keymap('n', '<leader>sw', [[<cmd>lua require('telescope.builtin').grep_string()<CR>]], {})
vim.api.nvim_set_keymap('n', '<leader>sl', [[<cmd>lua require('telescope.builtin').resume()<CR>]], {})
vim.api.nvim_set_keymap('n', '<leader>sg', [[<cmd>lua require('telescope.builtin').live_grep()<CR>]], {})
vim.api.nvim_set_keymap('n', '<leader>nm', '<cmd>Telescope node_modules list<CR>', {})
vim.api.nvim_set_keymap('n', '<leader>sy', '<cmd>Telescope yank_history<CR>', {})
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.api.nvim_set_keymap('n', '<leader>sj', [[<cmd>lua require('telescope.builtin').jumplist()<CR>]], {})

-- Treesitter configuration
-- Parsers must be installed manually via :TSInstall
require('nvim-treesitter.configs').setup {
  ensure_installed = "all", -- if not tree sitter won't install any parser
  autotag = {
    enable = true,
  },
  matchup = {
    enable = true, -- mandatory, false will disable the whole extension
  },
  highlight = {
    enable = true, -- false will disable the whole extension
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<c-space>',
      node_incremental = '<c-space>',
      -- TODO: I'm not sure for this one.
      scope_incremental = '<c-s>',
      node_decremental = '<c-backspace>',
    },
  },
  indent = {
    enable = true,
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
        [']m'] = '@function.outer',
        [']]'] = '@class.outer',
      },
      goto_next_end = {
        [']M'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[['] = '@class.outer',
      },
      goto_previous_end = {
        ['[M'] = '@function.outer',
        ['[]'] = '@class.outer',
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ['<leader>a'] = '@parameter.inner',
      },
      swap_previous = {
        ['<leader>A'] = '@parameter.inner',
      },
    }
  },
}
-- Fold based on tree sitter
vim.o.foldmethod = 'expr'
vim.o.foldexpr = 'nvim_treesitter#foldexpr()'

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)
-- LSP settings
local lspconfig = require 'lspconfig'
local on_attach = function(_, bufnr)
  -- In this case, we create a function that lets us more easily define mappings specific
  -- for LSP related items. It sets the mode, buffer and description for us each time.
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end
  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]tion')

  nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
  nmap('gi', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
  nmap('gr', require('telescope.builtin').lsp_references)
  nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  -- See `:help K` for why this keymap
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')


  -- Lesser used LSP functionality
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('<leader>D', vim.lsp.buf.type_definition, 'Type Definition')
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist Folders')

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', vim.lsp.buf.format or vim.lsp.buf.formatting,
    { desc = 'Format current buffer with LSP' })
end

-- nvim-cmp supports additional completion capabilities
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

-- Enable the following language servers
local servers = { 'tsserver', 'sumneko_lua' }


-- Ensure the servers above are installed
require('nvim-lsp-installer').setup {
  ensure_installed = servers,
}

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

-- Lua custom server
local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

lspconfig.sumneko_lua.setup {
  on_attach = on_attach,
  capabilities = capabilities,
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
        globals = { 'vim' },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file('', true),
      },
    },
  },
}

-- nvim-cmp setup
local lspkind = require('lspkind')
local cmp = require 'cmp'
cmp.setup {
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
    end,
  },
  mapping = {
    ["<C-n>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
    ["<C-p>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete({}),
    ['<C-e>'] = cmp.mapping.abort(),
    ["<c-y>"] = cmp.mapping(
      cmp.mapping.confirm {
        behavior = cmp.ConfirmBehavior.Insert,
        select = true,
      },
      { "i", "c" }
    ),
    ["<tab>"] = cmp.config.disable,
    ["<c-space>"] = cmp.mapping {
      i = cmp.mapping.complete({}),
      c = function(
        _ --[[fallback]]
      )
        if cmp.visible() then
          if not cmp.confirm { select = true } then
            return
          end
        else
          cmp.complete()
        end
      end,
    },
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    -- { name = 'vsnip' }, -- For vsnip users.
    { name = 'luasnip' }, -- For luasnip users.
    -- { name = 'ultisnips' }, -- For ultisnips users.
    -- { name = 'snippy' }, -- For snippy users.
  }, {
    { name = 'buffer' },
  }),
  formatting = {
    -- Youtube: How to set up nice formatting for your sources.
    format = lspkind.cmp_format {
      with_text = true,
      menu = {
        buffer = "[buf]",
        nvim_lsp = "[LSP]",
        nvim_lua = "[api]",
        path = "[path]",
        luasnip = "[snip]",
        gh_issues = "[issues]",
        tn = "[TabNine]",
      },
    },
  },
}

local opts = { noremap = true, silent = true }
-- fugitive
vim.api.nvim_set_keymap('n', '<leader>gr', ':Gread<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>gs', ':Git<CR>', opts)
-- neogit
vim.api.nvim_set_keymap('n', '<leader>gd', ':DiffviewOpen<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>gD', ':DiffviewOpen main<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>gl', ':Neogit log<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>gp', '::Neogit push<CR>', opts)

local neogit = require('neogit')

neogit.setup {
  disable_commit_confirmation = true,
  disable_signs = false,
  disable_hint = false,
  disable_context_highlighting = false,
  -- Neogit refreshes its internal state after specific events, which can be expensive depending on the repository size.
  -- Disabling `auto_refresh` will make it so you have to manually refresh the status after you open it.
  auto_refresh = true,
  disable_builtin_notifications = false,
  use_magit_keybindings = false,
  commit_popup = {
    kind = "split",
  },
  -- Change the default way of opening neogit
  kind = "tab",
  -- customize displayed signs
  signs = {
    -- { CLOSED, OPENED }
    section = { ">", "v" },
    item = { ">", "v" },
    hunk = { "", "" },
  },
  integrations = {
    diffview = true
  },
  -- Setting any section to `false` will make the section not render at all
  sections = {
    untracked = {
      folded = false
    },
    unstaged = {
      folded = false
    },
    staged = {
      folded = false
    },
    stashes = {
      folded = true
    },
    unpulled = {
      folded = true
    },
    unmerged = {
      folded = false
    },
    recent = {
      folded = true
    },
  },
  -- override/add mappings
  mappings = {
    -- modify status buffer mappings
    status = {
      -- Adds a mapping with "B" as key that does the "BranchPopup" command
      ["w"] = "StashPopup",
      -- Removes the default mapping of "s"
      ["Z"] = "",
    }
  }
}

-- Neoformat
vim.g.neoformat_try_node_exe = 1
vim.api.nvim_set_keymap('n', '<leader>f', ':Neoformat <CR>', opts)
-- format on save
-- fix for undojoin issue https://github.com/sbdchd/neoformat/issues/134#issuecomment-347180213
vim.cmd([[
  augroup fmt
    autocmd!
    au BufWritePre * try | undojoin | Neoformat | catch /^Vim\%((\a\+)\)\=:E790/ | finally | silent Neoformat | endtry
  augroup END
]])
-- Nvim-tree
require 'nvim-tree'.setup({
  sort_by = "case_sensitive",
  view = {
    adaptive_size = true
  }
})
vim.api.nvim_set_keymap('n', '<C-n>', ':NvimTreeToggle<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>r', '<:NvimTreeRefresh<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>n', ':NvimTreeFindFileToggle<CR>', opts)

-- nvim lint -----------------------------
local lint = require('lint')
lint.linters_by_ft = {
  typescript = { 'eslint' },
  typescriptreact = { 'eslint' },
  javascript = { 'eslint' },
  javascriptreact = { 'eslint' },

}

-- vim.api.nvim_command([[au BufWritePost <buffer> lua require('lint').try_lint()]])
-- vim.api.nvim_exec([[au BufWritePost <buffer> lua require('lint').try_lint()]], false)
-- vim.api.nvim_set_keymap('n', '<leader>li', [[<buffer>lua require('lint').try_lint()<CR>]], { noremap = true, silent = false })
vim.cmd([[
  au BufWritePost <buffer> lua require('lint').try_lint()
]])
-- yanky nvim
local utils = require("yanky.utils")
local mapping = require("yanky.telescope.mapping")
require("yanky").setup({
  ring = {
    history_length = 40,
    storage = "shada",
    sync_with_numbered_registers = true,
  },
  picker = {
    telescope = {
      default = mapping.put("p"),
      i = {
        ["<c-p>"] = mapping.put("p"),
        ["<c-k>"] = mapping.put("P"),
        ["<c-x>"] = mapping.delete(),
        ["<c-r>"] = mapping.set_register(utils.get_default_register()),
      },
      n = {
        p = mapping.put("p"),
        P = mapping.put("P"),
        d = mapping.delete(),
        r = mapping.set_register(utils.get_default_register())
      },
    }
  },
  system_clipboard = {
    sync_with_ring = false,
  },
  highlight = {
    on_put = true,
    on_yank = true,
    timer = 500,
  },
})
vim.keymap.set("n", "p", "<Plug>(YankyPutAfter)", {})
vim.keymap.set("n", "P", "<Plug>(YankyPutBefore)", {})
vim.keymap.set("x", "p", "<Plug>(YankyPutAfter)", {})
vim.keymap.set("x", "P", "<Plug>(YankyPutBefore)", {})
vim.keymap.set("n", "gp", "<Plug>(YankyGPutAfter)", {})
vim.keymap.set("n", "gP", "<Plug>(YankyGPutBefore)", {})
vim.keymap.set("x", "gp", "<Plug>(YankyGPutAfter)", {})
vim.keymap.set("x", "gP", "<Plug>(YankyGPutBefore)", {})
-- Yank-ring
vim.api.nvim_set_keymap("n", "<c-n>", "<Plug>(YankyCycleForward)", {})
vim.api.nvim_set_keymap("n", "<c-p>", "<Plug>(YankyCycleBackward)", {})
require("telescope").load_extension("yank_history")
-- Yank Preserve cursor position
vim.keymap.set("n", "y", "<Plug>(YankyYank)", {})
vim.keymap.set("x", "y", "<Plug>(YankyYank)", {})
-- Camel case Motion
vim.g.camelcasemotion_key = '<leader>'
-- Git blame
-- vim.g.gitblame_enabled = 1
-- dap debugger
-- telescope-dap
local dap = require('dap')
dap.adapters.node2 = {
  type = 'executable',
  command = 'node',
  args = { os.getenv('HOME') .. '/.code/vscode-node-debug2/out/src/nodeDebug.js' },
}
dap.configurations.javascript = {
  {
    name = 'Debug Jest Tests',
    type = 'node2',
    request = 'launch',
    cwd = vim.fn.getcwd(),
    runtimeArgs = { '--inspect-brk', '${workspaceRoot}/apps/planner/node_modules/.bin/jest', '--runInBand' },
    args = { '--no-cache' },
    sourceMaps = 'inline',
    protocol = 'inspector',
    console = 'integratedTerminal',
    port = 9229,
    disableOptimisticBPs = true
  }
}
-- require('dap.ext.vscode').load_launchjs()
require("telescope").load_extension "dap"
require("nvim-dap-virtual-text").setup()
-- nvim-dap-ui
require("dapui").setup()
local mappingOpts = { noremap = true, silent = true }
vim.api.nvim_set_keymap('n', '<F5>', [[<cmd>lua require'dap'.continue()<CR>]], mappingOpts)
vim.api.nvim_set_keymap('n', '<F10>', [[<cmd>lua require'dap'.step_over()<CR>]], mappingOpts)
vim.api.nvim_set_keymap('n', '<F11>', [[<cmd>lua require'dap'.step_into()<CR>]], mappingOpts)
vim.api.nvim_set_keymap('n', '<F12>', [[<cmd>lua require'dap'.step_out()<CR>]], mappingOpts)
vim.api.nvim_set_keymap('n', '<leader>b', [[<cmd>lua require'dap'.toggle_breakpoint()<CR>]], mappingOpts)
vim.api.nvim_set_keymap('n', '<leader>B',
  [[<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>]], mappingOpts)
vim.api.nvim_set_keymap('n', '<leader>lp',
  [[<cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>]], mappingOpts)
vim.api.nvim_set_keymap('n', '<leader>dr', [[<cmd>lua require'dap'.repl.open()<CR>]], mappingOpts)
vim.api.nvim_set_keymap('n', '<leader>dl', [[<cmd>lua require'dap'.run_last()<CR>]], mappingOpts)
