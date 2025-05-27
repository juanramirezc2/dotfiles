return {
  "ravitemer/mcphub.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  build = "npm install -g mcp-hub@latest", -- Installs `mcp-hub` node binary globally
  config = function()
    require("mcphub").setup({
      -- This sets vim.g.mcphub_auto_approve to true by default (can also be toggled from the HUB UI with `ga`)
      auto_approve = true,
    })
  end,
}
