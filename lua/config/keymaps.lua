-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set({ "i", "n" }, "<C-Down>", "<C-e>") -- Scroll down with Ctrl+down
vim.keymap.set({ "i", "n" }, "<C-Up>", "<C-y>") -- Scroll up with Ctrl+up
vim.keymap.set("n", "å", "{") -- Previous paragraph with å
vim.keymap.set("n", "ä", "}") -- Next paragraph with ä
vim.keymap.set("n", "<C-left>", "b") -- Previous word with Ctrl+left
vim.keymap.set("n", "<C-right>", "w") -- Next word with Ctrl+right
