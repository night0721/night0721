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

vim.cmd.colorscheme("catppuccin")
vim.api.nvim_set_hl(0, "ColorColumn", { bg = "none" })
