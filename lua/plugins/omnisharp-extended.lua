return {
  -- Load the extension on C# files (or force load with lazy=false)
  { "Hoffs/omnisharp-extended-lsp.nvim", ft = { "cs", "vb" } },

  -- Patch Omnisharp handlers to use the extended plugin
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        omnisharp = {
          handlers = {
            ["textDocument/definition"] = function(...)
              return require("omnisharp_extended").handler(...)
            end,
            ["textDocument/typeDefinition"] = function(...)
              return require("omnisharp_extended").type_definition_handler(...)
            end,
            ["textDocument/implementation"] = function(...)
              return require("omnisharp_extended").implementation_handler(...)
            end,
          },
        },
      },
    },
  },
}
