-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
--
vim.o.tabstop = 4 -- A TAB character looks like 4 spaces
vim.o.expandtab = true -- Pressing the TAB key will insert spaces instead of a TAB character
vim.o.softtabstop = 4 -- Number of spaces inserted instead of a TAB character
vim.o.shiftwidth = 4 -- Number of spaces inserted when indenting
vim.o.title = true
vim.o.titlestring = "%{hostname()}  %F  %{strftime('%Y-%m-%d %H:%M',getftime(expand('%')))}"
vim.o.fixeol = true
vim.keymap.set('n', '<D-.>', vim.lsp.buf.code_action, { desc = 'code action (vscode quick fix like)' })
vim.keymap.set('n', '<D-/>', ':normal gcc<CR><DOWN>', { desc = 'comment toggle (vscode comment like)' })
vim.keymap.set('v', '<D-/>', '<Esc>:normal gvgc<CR>', { desc = 'comment toggle (vscode comment like)' })

return {}
