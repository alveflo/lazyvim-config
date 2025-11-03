return {
  "folke/snacks.nvim",
  keys = {
    -- Normal mode toggle
    {
      "<M-i>",
      function()
        require("snacks").terminal(nil, {
          enter = true,
          float = {
            border = "rounded",
            width = 0.9,
            height = 0.8,
          },
        })
      end,
      desc = "Toggle Terminal",
    },
    -- Terminal mode toggle
    {
      "<M-i>",
      function()
        -- exit terminal mode and toggle
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-\\><C-N>", true, false, true), "n", false)
        require("snacks").terminal()
      end,
      mode = "t",
      desc = "Toggle Terminal",
    },
  },
  opts = {
    picker = {
      sources = {
        files = {
          hidden = true,
          follow = true,
          exclude = { ".git" }, -- keep ignoring git dir, optional
        },
      },
    },
    terminal = {
      win = {
        position = "float",
      },
    },
  },
}
