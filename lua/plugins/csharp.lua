return {
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      opts.servers = opts.servers or {}

      opts.servers.csharp_ls = {
        cmd = { "csharp-ls", "--features", "metadata-uris" },
        handlers = {
          ["textDocument/definition"] = function(...)
            return require("csharpls_extended").handler(...)
          end,
          ["textDocument/typeDefinition"] = function(...)
            return require("csharpls_extended").handler(...)
          end,
        },
        -- In nvim 0.11+, vim.lsp.buf.definition() bypasses custom handlers,
        -- so we need explicit keybindings that call the extended plugin directly.
        keys = {
          {
            "gd",
            function()
              require("csharpls_extended").lsp_definitions()
            end,
            desc = "Goto Definition",
          },
          {
            "gy",
            function()
              local extended = require("csharpls_extended")
              local client = extended.get_csharpls_client()
              if client then
                local params = vim.lsp.util.make_position_params(0, client.offset_encoding)
                client:request("textDocument/typeDefinition", params, function(err, result, ctx)
                  ctx.params = params
                  extended.handler(err, result, ctx)
                end)
              end
            end,
            desc = "Goto Type Definition",
          },
        },
      }

      opts.servers.omnisharp = false
    end,
  },

  {
    "Decodetalkers/csharpls-extended-lsp.nvim",
    ft = "cs",
    config = function()
      local extended = require("csharpls_extended")
      extended.buf_read_cmd_bind()

      -- Patch handle_locations: upstream bug uses locations[0] (nil in Lua)
      -- instead of locations[1] on the nvim 0.11+ code path.
      extended.handle_locations = function(locations, offset_encoding)
        local fetched = extended.get_metadata(locations, offset_encoding)
        if not vim.tbl_isempty(fetched) then
          if #locations > 1 then
            require("csharpls_extended.utils").set_qflist_locations(fetched)
            vim.api.nvim_command("copen")
          else
            vim.lsp.util.show_document(locations[1], offset_encoding, { focus = true })
          end
          return true
        end
        return false
      end
    end,
  },
}
