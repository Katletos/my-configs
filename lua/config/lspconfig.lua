local lspconfig = require("lspconfig")
local servers = lspconfig.util.available_servers()

local on_init = function(client, _)
  if client.supports_method "textDocument/semanticTokens" then
    client.server_capabilities.semanticTokensProvider = nil
  end
end

local capabilities = vim.tbl_deep_extend("force", {},
  vim.lsp.protocol.make_client_capabilities(),
  require('blink.cmp').get_lsp_capabilities() or {}
-- require("cmp_nvim_lsp").default_capabilities() or {}
)

-- lspconfig.util.default_config = vim.tbl_extend(
--   'force',
--   lspconfig.util.default_config,
--   {
--     capabilities = vim.tbl_deep_extend(
--       "force",
--       vim.lsp.protocol.make_client_capabilities(),
--       -- returns configured operations if setup() was already called
--       -- or default operations if not
--       require 'lsp-file-operations'.default_capabilities(),
--     )
--   }
-- )

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_init = on_init,
    capabilities = capabilities
  }
end

lspconfig.lua_ls.setup {
  on_init = on_init,
  capabilities = capabilities,
  Lua = {
    runtime = {
      -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
      version = "LuaJIT",
      path = vim.split(package.path, ";"),
    },
    diagnostics = {
      -- Get the language server to recognize the `vim` global
      globals = { "vim" },
    },
    workspace = {
      -- Make the server aware of Neovim runtime files and plugins
      library = { vim.env.VIMRUNTIME },
      checkThirdParty = false,
    },
    telemetry = {
      enable = false,
    },
  },
}

lspconfig.basedpyright.setup {
  on_init = on_init,
  capabilities = capabilities,
  settings = {
    basedpyright = {
      analysis = {
        typeCheckingMode = "off",
        autoSearchPaths = true,
        diagnosticMode = "openFilesOnly",
        useLibraryCodeForTypes = true
      }
    }
  }
}

lspconfig.html.setup {
  on_init = on_init,
  capabilities = capabilities
}


lspconfig.rust_analyzer.setup {
  on_init = on_init,
  capabilities = capabilities,
  settings = {
    ['rust-analyzer'] = {
      checkOnSave = {
        command = "clippy",
      },
      diagnostics = {
        refreshSupport = false,
        enable = true,
        -- enalbeExperimental = true,
      },
    }
  }
}

