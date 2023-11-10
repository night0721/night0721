require("zen-mode").setup({
    window = {
        width = 1,
        height = 1,
        options = {
            number = false, -- disable number column
            relativenumber = false, -- disable number column
        }
    },

    -- actions to execute when the Zen window opens
    on_open = function()
        vim.opt.linebreak = true
        vim.cmd([[
        set spell
        ]])
    end,
    -- actions to execute when the Zen window closes
    on_close = function()
        vim.opt.linebreak = false
        vim.cmd([[
        set nospell
        ]])
    end,
})
