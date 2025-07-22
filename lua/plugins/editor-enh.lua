return {
  -- Add second pair of braces when single opening brace is inserted
  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    config = true,
    opts = {
      enable_check_bracket_line = false
    },
  },

  -- Tree sitter. AST based syntax highlighting
  -- https://tree-sitter.github.io/tree-sitter/
  {
    "nvim-treesitter/nvim-treesitter",
    build = function()
      require("nvim-treesitter.install").update({ with_sync = true })()
    end,
    config = function()
      local configs = require("nvim-treesitter.configs")

      configs.setup({
        ensure_installed = { "c",
          "lua",
          "vim",
          "vimdoc",
          "query",
          "markdown",
          "markdown_inline",
          "dart",
          "rust",
        },

        sync_install = false,
        highlight = { enable = true },
        indent = { enable = false },
      })
    end,
  },

  -- S for surrounding text with different "([{}])"
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    lazy = false,
    opts = {
      indent_lines = false,
    },
  },
  {
    'stevearc/aerial.nvim',
    opts = {},
    -- Optional dependencies
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons"
    },
  }
}

