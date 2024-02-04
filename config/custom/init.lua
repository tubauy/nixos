-- local autocmd = vim.api.nvim_create_autocmd

-- Auto resize panes when resizing nvim window
-- autocmd("VimResized", {
--   pattern = "*",
--   command = "tabdo wincmd =",
-- })
vim.g.neovide_transparency = 0.85
vim.api.nvim_set_keymap("n", "<leader>p", ":ProjectMgr<CR>", {})
