return {
  "obsidian-nvim/obsidian.nvim",
  version = "*",
  ft = "markdown",
  keys = {
    {
      "<C-l>",
      function()
        return require("obsidian").util.toggle_checkbox()
      end,
      mode = "i",
      desc = "Toggle checkbox (insert)",
      buffer = true,
    },
  },
  opts = {
    dir = "~/Documents/Memoria/",
    daily_notes = {
      folder = "Journal",
      date_format = "%Y-%m-%d",
    },
    completion = {
      nvim_cmp = true, -- if using nvim-cmp, otherwise set to false
    },
  },
}
