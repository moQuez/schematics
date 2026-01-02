-- return {
--   "folke/tokyonight.nvim",
--   opts = {
--     transparent = true,
--     styles = {
--       sidebars = "transparent",
--       floats = "transparent",
--     },
--   },
-- }
return {
  -- install Dracula
  {
    "Mofiqul/dracula.nvim",
    opts = {
      transparent_bg = true, -- keep terminal background
      -- keep floats/sidebars transparent too
      overrides = function(_)
        return {
          NormalFloat = { bg = "NONE" },
          FloatBorder = { bg = "NONE" },
          FloatTitle = { bg = "NONE" },
        }
      end,
    },
  },

  -- tell LazyVim to use Dracula
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "dracula", -- or "dracula-soft" for lower contrast
    },
  },
}
