return {
  "https://gitlab.com/schrieveslaach/sonarlint.nvim",
  dependencies = {
    "neovim/nvim-lspconfig",
  },
  opts = {
    server = {
      cmd = {
        "sonarlint-language-server",
        "-stdio",
        "-analyzers",
        vim.fn.expand("~/.local/share/nvim/mason/share/sonarlint-analyzers/sonarhtml.jar"),
        vim.fn.expand("~/.local/share/nvim/mason/share/sonarlint-analyzers/sonariac.jar"),
        vim.fn.expand("~/.local/share/nvim/mason/share/sonarlint-analyzers/sonarjs.jar"),
        vim.fn.expand("~/.local/share/nvim/mason/share/sonarlint-analyzers/sonartext.jar"),
      },
    },
    filetypes = {
      "python",
      "java",
      "javascript",
      "typescript",
      "typescriptreact",
      "javascriptreact",
      "html",
      "css",
      "go",
      "dockerfile",
      "terraform",
      "cpp",
      "c",
      "cs",
      "php",
      "xml",
      "yaml",
    },
  },
}
