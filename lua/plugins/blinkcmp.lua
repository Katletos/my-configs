return {
  {
    'saghen/blink.cmp',
    dependencies = {
      'rafamadriz/friendly-snippets',
      dependencies = {
        'L3MON4D3/LuaSnip',
        version = 'v2.3',
      },
    },
    version = '*',

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      keymap = { preset = 'enter' },
      appearance = {
        -- Sets the fallback highlight groups to nvim-cmp's highlight groups
        -- Useful for when your theme doesn't support blink.cmp
        -- Will be removed in a future release
        use_nvim_cmp_as_default = true,
        -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = 'mono'
      },

      -- Default list of enabled providers defined so that you can extend it
      -- elsewhere in your config, without redefining it, due to `opts_extend`
      sources = {
        default = { 'snippets', 'lsp', 'path', 'buffer' },
        providers = {
          snippets = {
            -- module = 'blink.cmp.sources.snippets',
            score_offset = 1,
          }
        },
      },
      cmdline = {
        sources = {},
      },
      completion = {
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 200,
          window = {
            -- border = "none"
            -- scrollbar = false
          }
        },
      },
      signature = { enabled = true },
      snippets = {
        preset = 'luasnip',
        expand = function(snippet) require("luasnip").lsp_expand(snippet) end,
        active = function(filter)
          if filter and filter.direction then
            return require("luasnip").jumpable(filter.direction)
          end
          return require("luasnip").in_snippet()
        end,
        jump = function(direction) require("luasnip").jump(direction) end
      },
    },
    opts_extend = { "sources.default" },
  },
  {
    "neovim/nvim-lspconfig",
    version = "v1.3.0",
    dependencies = { "saghen/blink.cmp" },
    opts = {
      inlay_hints = { enabled = false }
    },
    config = function()
      require("config.lspconfig")
    end
  },
  {
    'nvim-flutter/flutter-tools.nvim',
    lazy = false,
    dependencies = {
      'nvim-lua/plenary.nvim',
      'stevearc/dressing.nvim',
    },
    opts = {
      widget_guides = {
        enabled = true,
      },
      closing_tags = {
        prefix = "💠",
      },
      dev_log = {
        enabled = true,
        notify_errors = false, -- if there is an error whilst running then notify the user
        open_cmd = "tabedit", -- command to use to open the log buffer
      },
      lsp = {
        color = { -- show the derived colours for dart variables
          enabled = true, -- whether or not to highlight color variables at all, only supported on flutter >= 2.10
          background = true, -- highlight the background
          -- background_color = nil, -- required, when background is transparent (i.e. background_color = { r = 19, g = 17, b = 24},)
          -- foreground = false, -- highlight the foreground
        },
      },
      settings = {
        showTodos = false,
      },
      debugger = { -- integrate with nvim dap + install dart code debugger
        enabled = true,
        run_via_dap = true, -- use dap instead of a plenary job to run flutter apps
        exception_breakpoints = "uncaught",
        register_configurations = function(paths)
          require("dap").configurations.dart = { {
            type = "dart",
            request = "launch",
            name = "Launch Flutter Program",
            -- The nvim-dap plugin populates this variable with the filename of the current buffer
            -- program = "${file}",
            -- The nvim-dap plugin populates this variable with the editor's current working directory
            -- cwd = "${workspaceFolder}",
            -- This gets forwarded to the Flutter CLI tool, substitute `linux` for whatever device you wish to launch
            -- toolArgs = {"-d", "chrome", "--web-browser-flag=--disable-web-security"},
            toolArgs = { "--flavor", "dev" },
          } }
        end,
      },
    },
  },
  {
    'dart-lang/dart-vim-plugin',
    ft = { "dart" },
  },
  {
    "antosha417/nvim-lsp-file-operations",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    opts = {
      -- used to see debug logs in file `vim.fn.stdpath("cache") .. lsp-file-operations.log`
      debug = false,
      -- select which file operations to enable
      operations = {
        willRenameFiles = true,
        didRenameFiles = true,
        willCreateFiles = true,
        didCreateFiles = true,
        willDeleteFiles = true,
        didDeleteFiles = true,
      },
      -- how long to wait (in milliseconds) for file rename information before cancelling
      timeout_ms = 10000,
    }
  }
}

