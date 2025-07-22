return {
  'nvim-telescope/telescope.nvim',
  dependencies = { 'nvim-lua/plenary.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release' }
  },
  config = function()
    require("telescope").load_extension("fzf")
    local builtin = require('telescope.builtin')
    vim.keymap.set('n', '<leader>f', builtin.find_files, {})
    vim.keymap.set('n', '<leader>g', builtin.live_grep, {})
    vim.keymap.set('n', '<leader>ds', builtin.lsp_document_symbols, {})
    vim.keymap.set('n', '<leader>dd', builtin.diagnostics, {})
    vim.keymap.set('n', '<leader>r', builtin.lsp_references, {})
    vim.keymap.set('n', '<leader>w', builtin.lsp_dynamic_workspace_symbols, {})
    vim.keymap.set('n', '<leader>ci', builtin.lsp_incoming_calls, {})
    vim.keymap.set('n', '<leader>co', builtin.lsp_outgoing_calls, {})
    vim.keymap.set('n', '<leader>m', builtin.marks, {})
    vim.keymap.set('n', '<leader>q', builtin.quickfix, {})
    vim.keymap.set('n', '<Leader>j', builtin.lsp_implementations, {})
    vim.keymap.set('n', '<leader>de', function()
      require('telescope.builtin').diagnostics {
        severity = vim.diagnostic.severity.ERROR
      }
    end, { noremap = true, silent = true, desc = 'Telescope diagnostics (errors only)' })
  end
}

