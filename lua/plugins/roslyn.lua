return {
  -- Disable other C# servers so Roslyn is the only one attaching
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      opts = opts or {}
      opts.servers = opts.servers or {}
      opts.servers.omnisharp = false
      opts.servers.csharp_ls = false
      return opts
    end,
  },

  -- Mason: add custom registry that provides "roslyn" and "rzls"
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      opts = opts or {}
      opts.registries = {
        "github:mason-org/mason-registry",
        "github:Crashdummyy/mason-registry",
      }
      return opts
    end,
  },

  -- The Roslyn LSP plugin
  {
    "seblyng/roslyn.nvim",
    -- :help roslyn.nvim for full options
    opts = {
      filewatching = "roslyn",
      broad_search = true,
      debug = true, -- Enable debug logging to ~/.local/state/nvim/roslyn.log
    },
    config = function(_, opts)
      require("roslyn").setup(opts)

      -- Place LS-specific settings here if you want:
      -- (inlay hints, code lens, formatting, etc.)
      vim.lsp.config("roslyn", {
        on_attach = function(client, bufnr)
          -- Debug: print solution info
          vim.notify(
            string.format("Roslyn attached. Solution: %s", vim.g.roslyn_nvim_selected_solution or "none"),
            vim.log.levels.INFO
          )
        end,
        settings = {
          ["csharp|inlay_hints"] = {
            csharp_enable_inlay_hints_for_implicit_variable_types = true,
            csharp_enable_inlay_hints_for_implicit_object_creation = true,
          },
          ["csharp|code_lens"] = {
            dotnet_enable_references_code_lens = true,
          },
          ["csharp|formatting"] = {
            dotnet_organize_imports_on_format = true,
          },
        },
      })
    end,
  },
}
