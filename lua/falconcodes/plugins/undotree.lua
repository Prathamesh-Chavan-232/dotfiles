-- undotree
vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle)

return {
    'mbbill/undotree',
    lazy = false,
    config = {}
}
