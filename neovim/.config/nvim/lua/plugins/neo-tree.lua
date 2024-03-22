return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    -- opts will be merged with the parent spec
    opts = {
      filesystem = {
        bind_to_cwd = true, -- true creates a 2-way binding between vim's cwd and neo-tree's root
        cwd_target = {
          sidebar = "tab", -- sidebar is when position = left or right
          current = "window", -- current is when position = current
        },
      },
      window = {
        width = 50,
        mappings = {
          ["<space>"] = false, -- disable space until we figure out which-key disabling
          ["l"] = "open",
          ["o"] = "open",
          ["h"] = "close_node",
        },
        fuzzy_finder_mappings = { -- define keymaps for filter popup window in fuzzy_finder_mode
          ["<C-j>"] = "move_cursor_down",
          ["<C-k>"] = "move_cursor_up",
        },
      },
    },
  },
}
