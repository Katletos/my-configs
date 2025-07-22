require("config.lazy")

vim.keymap.set("n", "<leader>q", vim.lsp.buf.code_action, opts)

vim.diagnostic.config({
  virtual_text = true
})

vim.g.mapleader = " "
vim.cmd("set number")

function map(mode, lhs, rhs, opts)
  local options = { noremap = true }
  if opts then options = vim.tbl_extend("force", options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end
-- Multi mode navigation
map('n', '<C-h>', '<C-w>h')
map('n', '<C-j>', '<C-w>j')
map('n', '<C-k>', '<C-w>k')
map('n', '<C-l>', '<C-w>l')

-- NvimTree
map('n', '<Leader>t', ':NvimTreeToggle<Return>', { silent = true })
map('n', '<Leader>cf', ':NvimTreeFindFile<Return>', { silent = true })

vim.keymap.set("n", "<F2>", function() vim.lsp.buf.rename() end, opts)
vim.keymap.set("n", "=", function() vim.lsp.buf.format() end, { desc = "Format buffer", })

vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
