local function my_on_attach(bufnr)
  local api = require("nvim-tree.api")

  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end
  -- default mappings
  api.config.mappings.default_on_attach(bufnr)


  vim.keymap.set('n', 'L', "gt", opts('Goto next tab'))
  vim.keymap.set('n', 'H', "gT", opts('Goto prev tab'))
end



return {
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      view = {
        adaptive_size = true,
        preserve_window_proportions = true,
      },
      on_attach = my_on_attach,
    },
  }
}

