local vim = vim
local nvim_lsp = require "nvim_lsp"

local on_attach = function(_, bufnr)

  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  require'completion'.on_attach()
  require'diagnostic'.on_attach()

  local opts = { noremap=true, silent=true }
end

local servers = {'cssls', 'html', 'tsserver', 'vimls','jsonls'}

for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
  }
end
