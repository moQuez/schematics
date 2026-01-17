return {
  {
    "mfussenegger/nvim-lint",
    opts = function(_, opts)
      local config = vim.fn.stdpath("config") .. "/.markdownlint-cli2.yaml"

      opts.linters = opts.linters or {}
      local linter = opts.linters["markdownlint-cli2"] or {}
      linter.prepend_args = linter.prepend_args or {}

      if not vim.tbl_contains(linter.prepend_args, "--config") then
        vim.list_extend(linter.prepend_args, { "--config", config })
      end

      opts.linters["markdownlint-cli2"] = linter
    end,
  },
}
