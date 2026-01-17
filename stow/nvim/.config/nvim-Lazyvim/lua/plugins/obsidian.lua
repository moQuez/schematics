return {
  "obsidian-nvim/obsidian.nvim",
  version = "*",
  ft = "markdown",
  opts = {
    dir = "~/Development/TestVault",
    daily_notes = {
      folder = "Journal",
      date_format = "%Y-%m-%d",
    },
    completion = {
      nvim_cmp = true, -- if using nvim-cmp, otherwise set to false
    },
  },
}
