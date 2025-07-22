return {
  "stevearc/oil.nvim",
  opts = {},
  -- Optional: use it instead of netrw
  init = function()
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1
  end,
};
