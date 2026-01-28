local servers = {
	clangd = {},
	gopls = {},
}

local lsp_capabilities = require('blink.cmp').get_lsp_capabilities()

local default_setup = function(server)
	vim.lsp.config(server, {
			capabilities = lsp_capabilities,
	})
end

require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = {"clangd", "gopls"},
  handlers = {
    default_setup,
  },
})

vim.lsp.enable(require('mason-lspconfig').get_installed_servers())

-- note: diagnostics are not exclusive to lsp servers
-- so these can be global keybindings
vim.keymap.set('n', 'gl', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next) 

local diagnostics = {
    signs = false,
    underline = true,
    update_in_insert = true,
}

local function virtual_line_enable(visible)
    if visible then
        diagnostics.virtual_lines = { current_line = true }
    else
        diagnostics.virtual_lines = false
    end
	vim.diagnostic.config(diagnostics)
end

virtual_line_enable(true)

local visible = true
vim.api.nvim_create_user_command('LspVirtualLineToggle', function()
visible = not visible
virtual_line_enable(visible)
end, {})

vim.api.nvim_create_autocmd("InsertEnter", {
pattern = "*",
callback = function()
  virtual_line_enable(false)
end
})

vim.api.nvim_create_autocmd("InsertLeave", {
pattern = "*",
callback = function()
  virtual_line_enable(visible)
end
})

vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions',
  callback = function(event)
    local opts = {buffer = event.buf}

    -- these will be buffer-local keybindings
    -- because they only work if you have an active language server

    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'gw', vim.lsp.buf.workspace_symbol, opts)
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', 'go', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', 'gs', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', 'ge', vim.lsp.buf.rename, opts)
    vim.keymap.set({'n', 'x'}, 'cf', function ()
		vim.lsp.buf.format({async = true})
		print("Formatted")
	end, opts)
    vim.keymap.set('n', 'gca', vim.lsp.buf.code_action, opts)
  end
})

vim.api.nvim_set_keymap('i', '<C-CR>', 'copilot#Accept("<CR>")', {expr=true, silent=true})


--[[
local cmp = require('cmp')

cmp.setup({
  sources = {
    {name = 'nvim_lsp'},
  },
  mapping = cmp.mapping.preset.insert({
    -- Enter key confirms completion item
    ['<CR>'] = cmp.mapping.confirm({select = false}),

    -- Ctrl + space triggers completion menu
    ['<C-Space>'] = cmp.mapping.complete(),
  }),
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
})



local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = vim.lsp.defaults.cmp_mappings({
    ['<A-w>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<A-s>'] = cmp.mapping.select_next_item(cmp_select),
    ['<A-f>'] = cmp.mapping.confirm({ select = true }),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<A-x>"] = cmp.mapping.close()
})

cmp.setup({
    mapping = cmp_mappings
})


vim.lsp.set_preferences({
    suggest_lsp_servers = true,
    sign_icons = {
        error = 'E',
        warn = 'W',
        hint = 'H',
        info = 'I'
    }
})

-- lsp.setup()

--]]
