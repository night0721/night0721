vim.cmd("set runtimepath+=~/.local/share/nvim/site/pack/packer/start/catppuccin")
vim.cmd("set runtimepath+=~/.local/share/nvim/site/pack/packer/start/nvim-treesitter")

require("catppuccin").setup({
  style = "night",
  transparent = true,
  styles = {
    floats = "transparent", -- style for floating windows
  },
  color_overrides = {
      mocha = {
          base = "#000000",
          mantle = "#000000",
          crust = "#000000",
      },
  },
})
require('nvim-treesitter.configs').setup({
    -- A list of parser names, or "all"
    ensure_installed = { "javascript", "typescript", "bash", "c", "lua", "html", "json", "python" },

    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false,

    -- Automatically install missing parsers when entering buffer
    auto_install = false,

    highlight = {
        enable = true,
    },
    rainbow = {
        enable = true,
    },
})

vim.cmd.syntax("on")
vim.cmd [[colorscheme catppuccin-mocha]]
