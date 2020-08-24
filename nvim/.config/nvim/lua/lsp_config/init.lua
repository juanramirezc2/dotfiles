local vim = vim
local lsp_status = require "lsp-status"
local nvim_lsp = require "nvim_lsp"
local completion = require "completion"
local diagnostic = require'diagnostic'
-- Register the progress callback
lsp_status.register_progress()

lsp_status.config {
  status_symbol = ''
}

local on_attach = function(_, bufnr)

  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  lsp_status.on_attach(_, bufnr)
  diagnostic.on_attach(_, bufnr)
  completion.on_attach(_, bufnr)

end

local servers = {'cssls', 'html', 'tsserver','diagnosticls','jsonls'}

for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    capabilities = lsp_status.capabilities
  }
end
