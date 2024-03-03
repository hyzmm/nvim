require("mason").setup()
require("mason-lspconfig").setup()

require("mason-null-ls").setup({
  ensure_installed = {
    'fixjson'
  },
  automatic_installation = false,
  handlers = {},
})

local null_ls = require("null-ls")
local b = null_ls.builtins
null_ls.setup({
  sources = {
    -- formatting
    b.formatting.prettierd,
    b.formatting.shfmt,
    b.formatting.black.with { extra_args = { "--fast" } },
    b.formatting.isort,
    b.formatting.stylua,

    -- diagnostics
    b.diagnostics.write_good,
    -- b.diagnostics.markdownlint,
    -- b.diagnostics.eslint_d,
    b.diagnostics.selene,

    -- code actions
    b.code_actions.gitsigns,
    b.code_actions.gitrebase,

    -- hover
    b.hover.dictionary,
  },
})

-- After setting up mason-lspconfig you may set up servers via lspconfig
-- require("lspconfig").lua_ls.setup {}
-- require("lspconfig").rust_analyzer.setup {}

-- IMPORTANT: make sure to setup neodev BEFORE lspconfig
require("neodev").setup({
  -- add any options here, or leave empty to use the default settings
})

local lsp = require("lspconfig")

require("mason-lspconfig").setup_handlers {
  -- The first entry (without a key) will be the default handler
  -- and will be called for each installed server that doesn't have
  -- a dedicated handler.
  function(server_name) -- default handler (optional)
    lsp[server_name].setup {
      on_attach = function(client)
        require 'config.lsp.null_ls.formatters'.setup(client)
      end
    }
  end,
  -- Next, you can provide a dedicated handler for specific servers.
  ["jsonls"] = function()
    require('lspconfig').jsonls.setup {
      settings = {
        json = {
          schemas = require('schemastore').json.schemas {
            select = {
              '.eslintrc',
              'package.json',
            },
          },
          validate = { enable = true },
        },
        commands = {
          Format = {
            function()
              vim.lsp.buf.range_formatting({}, { 0, 0 }, { vim.fn.line "$", 0 })
            end
          }
        }
      },
    }
  end,
  ["lua_ls"] = function()
    lsp["lua_ls"].setup {
      cmd = { "lua-language-server" },
      settings = {
        Lua = {
          completion = {
            callSnippet = "Replace"
          },
          runtime = {
            -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
            version = "LuaJIT",
            -- Setup your lua path
            path = vim.split(package.path, ";"),
          },
          diagnostics = {
            -- Get the language server to recognize the `vim` global
            globals = { "vim" },
          },
          workspace = {
            -- Make the server aware of Neovim runtime files
            library = {
              [vim.fn.expand "$VIMRUNTIME/lua"] = true,
              [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
            },
          },
        },
      }
    }
  end
}
 require 'config.lsp.keymaps'
 require 'config.lsp.handlers'.setup()
 require 'config.lsp.null_ls'
