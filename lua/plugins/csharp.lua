return {
  -- Use csharp_ls instead of Roslyn for C#
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        omnisharp = false,
        csharp_ls = {},
      },
    },
  },

  -- Decompilation support for csharp_ls (go-to-definition into metadata/assemblies)
  {
    "Decodetalkers/csharpls-extended-lsp.nvim",
    ft = "cs",
    config = function()
      require("csharpls_extended").buf_read_cmd_bind()
    end,
  },
}
