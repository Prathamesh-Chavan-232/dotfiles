-- git integration
vim.keymap.set("n", "<leader>fs", vim.cmd.Git)

return {
    "tpope/vim-fugitive",
    lazy = false,
}
