-- lua/plugins/noice-progress-off.lua
return {
  {
    "folke/noice.nvim",
    opts = {
      lsp = {
        progress = { enabled = false },
      },
    },
  },
}
