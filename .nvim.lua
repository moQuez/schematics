local function find_files_hidden()
  if
    type(_G.Snacks) == "table"
    and type(_G.Snacks.picker) == "table"
    and type(_G.Snacks.picker.files) == "function"
  then
    _G.Snacks.picker.files({ hidden = true })
    return
  end

  local ok, builtin = pcall(require, "telescope.builtin")
  if ok then
    builtin.find_files({ hidden = true })
    return
  end

  if pcall(vim.cmd, "Telescope find_files hidden=true") then
    return
  end

  vim.notify("No picker found (Snacks or Telescope)", vim.log.levels.WARN)
end

local function set_keymaps()
  vim.keymap.set("n", "<leader>ff", find_files_hidden, { desc = "Find Files (including dotfiles)" })
  vim.keymap.set("n", "<leader><space>", find_files_hidden, { desc = "Find Files (including dotfiles)" })
end

set_keymaps()
vim.api.nvim_create_autocmd("User", { pattern = "VeryLazy", callback = set_keymaps })
