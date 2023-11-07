-- keymap
vim.api.nvim_set_keymap("n", "<C-_>", "gcc", { noremap = false })
vim.api.nvim_set_keymap("v", "<C-_>", "gcc", { noremap = false })

-- plugin
return {
    'numToStr/Comment.nvim',
    opts = {
    } ,
    lazy = false
}
