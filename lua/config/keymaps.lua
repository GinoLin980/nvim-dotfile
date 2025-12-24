-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set({ "n", "v", "o" }, "<C-;>", function()
  vim.fn.search([[\v(<|_@<=\w|[A-Z])]], "W")
end, { noremap = true, silent = true, desc = "Next subword" })

vim.keymap.set({ "n", "v", "o" }, "<C-'>", function()
  vim.fn.search([[\v(<|_@<=\w|[A-Z])]], "bW")
end, { noremap = true, silent = true, desc = "Previous subword" })
