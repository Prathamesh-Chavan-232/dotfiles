-- git integration
vim.keymap.set("n", "<leader>gs", vim.cmd.Git)

return {
    "tpope/vim-fugitive",
    lazy = false,
}
