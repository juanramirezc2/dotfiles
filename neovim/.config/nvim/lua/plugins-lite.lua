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
  -- UI to select things (files, grep results, open buffers...)
  use { 'nvim-telescope/telescope.nvim', requires = { 'nvim-lua/plenary.nvim' } }
  use { 'nvim-telescope/telescope-node-modules.nvim' }
  -- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  -- Add indentation guides even on blank lines
  use 'lukas-reineke/indent-blankline.nvim'
  -- Highlight, edit, and navigate code using a fast incremental parsing library
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  -- Treesitter extra modules {{
  use 'nvim-treesitter/nvim-treesitter-context'
  use "windwp/nvim-autopairs"
  use 'nvim-treesitter/nvim-treesitter-textobjects'
  use 'windwp/nvim-ts-autotag' -- Use treesitter to autoclose and autorename html tag
  use 'andymass/vim-matchup'
  -- Coc nvim
  use {'neoclide/coc.nvim', branch = 'release'}
  -- status line 
  use {
  'nvim-lualine/lualine.nvim',
  requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }
  -- nvim surround
  use({
    "kylechui/nvim-surround",
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
      })
    end
  })

  use 'rcarriga/nvim-notify' -- notification
  use { "gbprod/yanky.nvim" } -- improve yank and put functionalities for Neovim.
  use 'tpope/vim-sleuth' -- Detect tabstop and shiftwidth automatically

  use 'NvChad/nvim-colorizer.lua' -- A high-performance color highlighter for Neovim which has no external dependencies! 
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
  use 'Shatur/neovim-ayu'
  -- Git helpers
  use { 'TimUntersberger/neogit', requires = 'nvim-lua/plenary.nvim' }
  use { 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' }
  -- Debugger Adaptor Protocol
  use 'mfussenegger/nvim-dap'
  use "rcarriga/nvim-dap-ui"
  use "nvim-telescope/telescope-dap.nvim"
  use 'theHamsta/nvim-dap-virtual-text'
end)
-- Lua line
require('lualine').setup{
  options = {
    sections = {
    lualine_a = {'mode', icons_enabled = true},
    lualine_b = false,
    lualine_c = {'filename', path = 1},
    lualine_x = {'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  }
}
------------------------- COC NVIM {{{{{{{{{{{
vim.g.coc_global_extensions = {
    "coc-explorer",
    "coc-tsserver",
    "coc-json",
    "coc-eslint",
    "coc-snippets",
    "coc-prettier",
    "coc-lua",
    "coc-react-refactor",
    "coc-git"
}

-- Some servers have issues with backup files, see #649.
vim.opt.backup = false
vim.opt.writebackup = false

-- Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
-- delays and poor user experience.
vim.opt.updatetime = 300

-- Always show the signcolumn, otherwise it would shift the text each time
-- diagnostics appear/become resolved.
vim.opt.signcolumn = "yes"

local keyset = vim.keymap.set
-- Auto complete
function _G.check_back_space()
    local col = vim.fn.col('.') - 1
    return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
end

-- Use tab for trigger completion with characters ahead and navigate.
-- NOTE: There's always complete item selected by default, you may want to enable
-- no select by `"suggest.noselect": true` in your configuration file.
-- NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
-- other plugin before putting this into your config.
local opts = {silent = true, noremap = true, expr = true, replace_keycodes = false}
keyset("i", "<TAB>", 'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()', opts)
keyset("i", "<S-TAB>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], opts)

-- Make <CR> to accept selected completion item or notify coc.nvim to format
-- <C-g>u breaks current undo, please make your own choice.
keyset("i", "<cr>", [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], opts)

-- Use <c-j> to trigger snippets
keyset("i", "<c-j>", "<Plug>(coc-snippets-expand-jump)")
-- Use <c-space> to trigger completion.
keyset("i", "<c-space>", "coc#refresh()", {silent = true, expr = true})

-- Use `[g` and `]g` to navigate diagnostics
-- Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
keyset("n", "[g", "<Plug>(coc-diagnostic-prev)", {silent = true})
keyset("n", "]g", "<Plug>(coc-diagnostic-next)", {silent = true})

-- GoTo code navigation.
keyset("n", "gd", "<Plug>(coc-definition)", {silent = true})
keyset("n", "gy", "<Plug>(coc-type-definition)", {silent = true})
keyset("n", "gi", "<Plug>(coc-implementation)", {silent = true})
keyset("n", "gr", "<Plug>(coc-references)", {silent = true})


-- Use K to show documentation in preview window.
function _G.show_docs()
    local cw = vim.fn.expand('<cword>')
    if vim.fn.index({'vim', 'help'}, vim.bo.filetype) >= 0 then
        vim.api.nvim_command('h ' .. cw)
    elseif vim.api.nvim_eval('coc#rpc#ready()') then
        vim.fn.CocActionAsync('doHover')
    else
        vim.api.nvim_command('!' .. vim.o.keywordprg .. ' ' .. cw)
    end
end
keyset("n", "K", '<CMD>lua _G.show_docs()<CR>', {silent = true})


-- Highlight the symbol and its references when holding the cursor.
vim.api.nvim_create_augroup("CocGroup", {})
vim.api.nvim_create_autocmd("CursorHold", {
    group = "CocGroup",
    command = "silent call CocActionAsync('highlight')",
    desc = "Highlight symbol under cursor on CursorHold"
})


-- Symbol renaming.
keyset("n", "<leader>rn", "<Plug>(coc-rename)", {silent = true})


-- Formatting selected code.
keyset("x", "<leader>f", "<Plug>(coc-format-selected)", {silent = true})
keyset("n", "<leader>f", "<Plug>(coc-format-selected)", {silent = true})


-- Setup formatexpr specified filetype(s).
vim.api.nvim_create_autocmd("FileType", {
    group = "CocGroup",
    pattern = "typescript,json",
    command = "setl formatexpr=CocAction('formatSelected')",
    desc = "Setup formatexpr specified filetype(s)."
})

-- Update signature help on jump placeholder.
vim.api.nvim_create_autocmd("User", {
    group = "CocGroup",
    pattern = "CocJumpPlaceholder",
    command = "call CocActionAsync('showSignatureHelp')",
    desc = "Update signature help on jump placeholder"
})


-- Applying codeAction to the selected region.
-- Example: `<leader>aap` for current paragraph
local opts = {silent = true, nowait = true}
keyset("x", "<leader>a", "<Plug>(coc-codeaction-selected)", opts)
keyset("n", "<leader>a", "<Plug>(coc-codeaction-selected)", opts)

-- Remap keys for applying codeAction to the current buffer.
keyset("n", "<leader>ac", "<Plug>(coc-codeaction)", opts)


-- Apply AutoFix to problem on the current line.
keyset("n", "<leader>qf", "<Plug>(coc-fix-current)", opts)


-- Run the Code Lens action on the current line.
keyset("n", "<leader>cl", "<Plug>(coc-codelens-action)", opts)


-- Map function and class text objects
-- NOTE: Requires 'textDocument.documentSymbol' support from the language server.
keyset("x", "if", "<Plug>(coc-funcobj-i)", opts)
keyset("o", "if", "<Plug>(coc-funcobj-i)", opts)
keyset("x", "af", "<Plug>(coc-funcobj-a)", opts)
keyset("o", "af", "<Plug>(coc-funcobj-a)", opts)
keyset("x", "ic", "<Plug>(coc-classobj-i)", opts)
keyset("o", "ic", "<Plug>(coc-classobj-i)", opts)
keyset("x", "ac", "<Plug>(coc-classobj-a)", opts)
keyset("o", "ac", "<Plug>(coc-classobj-a)", opts)


-- Remap <C-f> and <C-b> for scroll float windows/popups.
---@diagnostic disable-next-line: redefined-local
local opts = {silent = true, nowait = true, expr = true}
keyset("n", "<C-f>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"', opts)
keyset("n", "<C-b>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"', opts)
keyset("i", "<C-f>",
       'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(1)<cr>" : "<Right>"', opts)
keyset("i", "<C-b>",
       'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(0)<cr>" : "<Left>"', opts)
keyset("v", "<C-f>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"', opts)
keyset("v", "<C-b>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"', opts)


-- Use CTRL-S for selections ranges.
-- Requires 'textDocument/selectionRange' support of language server.
keyset("n", "<C-s>", "<Plug>(coc-range-select)", {silent = true})
keyset("x", "<C-s>", "<Plug>(coc-range-select)", {silent = true})


-- Add `:Format` command to format current buffer.
vim.api.nvim_create_user_command("Format", "call CocAction('format')", {})

-- " Add `:Fold` command to fold current buffer.
vim.api.nvim_create_user_command("Fold", "call CocAction('fold', <f-args>)", {nargs = '?'})

-- Add `:OR` command for organize imports of the current buffer.
vim.api.nvim_create_user_command("OR", "call CocActionAsync('runCommand', 'editor.action.organizeImport')", {})

-- Add (Neo)Vim's native statusline support.
-- NOTE: Please see `:h coc-status` for integrations with external plugins that
-- provide custom statusline: lightline.vim, vim-airline.
vim.opt.statusline:prepend("%{coc#status()}%{get(b:,'coc_current_function','')}")

-- Mappings for CoCList
-- code actions and coc stuff
---@diagnostic disable-next-line: redefined-local
local opts = {silent = true, nowait = true}
-- Show all diagnostics.
keyset("n", "<space>a", ":<C-u>CocList diagnostics<cr>", opts)
-- Manage extensions.
keyset("n", "<space>e", ":<C-u>CocList extensions<cr>", opts)
-- Show commands.
keyset("n", "<space>c", ":<C-u>CocList commands<cr>", opts)
-- Find symbol of current document.
keyset("n", "<space>o", ":<C-u>CocList outline<cr>", opts)
-- Search workspace symbols.
keyset("n", "<space>s", ":<C-u>CocList -I symbols<cr>", opts)
-- Do default action for next item.
keyset("n", "<space>j", ":<C-u>CocNext<cr>", opts)
-- Do default action for previous item.
keyset("n", "<space>k", ":<C-u>CocPrev<cr>", opts)
-- Resume latest coc list.
keyset("n", "<space>p", ":<C-u>CocListResume<cr>", opts)
------------------------------ }}}}}}}}}}}

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
  contrast = "soft", -- can be "hard", "soft" or empty string
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

-- Telescope
require('telescope').setup {
  defaults = {
    path_display = { "smart"},
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
-- tresitter context
require 'treesitter-context'.setup()
-- Fold based on tree sitter
vim.o.foldmethod = 'expr'
vim.o.foldexpr = 'nvim_treesitter#foldexpr()'

--nvim autopairs
require("nvim-autopairs").setup()

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

-- nvim-colorizer.lua
require'colorizer'.setup({
  user_default_options = {
    RGB = true, -- #RGB hex codes
    RRGGBB = true, -- #RRGGBB hex codes
    names = false, -- "Name" codes like Blue or blue
    RRGGBBAA = false, -- #RRGGBBAA hex codes
    AARRGGBB = false, -- 0xAARRGGBB hex codes
    rgb_fn = false, -- CSS rgb() and rgba() functions
    hsl_fn = false, -- CSS hsl() and hsla() functions
    css = false, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
    css_fn = false, -- Enable all CSS *functions*: rgb_fn, hsl_fn
    -- Available modes for `mode`: foreground, background,  virtualtext
    mode = "background", -- Set the display mode.
    -- Available methods are false / true / "normal" / "lsp" / "both"
    -- True is same as normal
    tailwind = false, -- Enable tailwind colors
    -- parsers can contain values used in |user_default_options|
    sass = { enable = false, parsers = { css }, }, -- Enable sass colors
    virtualtext = "■",
  }
})
-- Coc Explorer
vim.api.nvim_set_keymap('n','<leader>e', '<CMD>CocCommand explorer  --preset floating --sources file+<CR>', { silent = true, noremap = false })

-- neogit
vim.api.nvim_set_keymap('n', '<leader>gs', ':Neogit<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>gd', ':DiffviewOpen<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>gD', ':DiffviewOpen main<CR>', opts)

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
