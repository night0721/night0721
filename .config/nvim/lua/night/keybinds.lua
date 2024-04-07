-- exit to file tree
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("v", "<A-Down>", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "<A-Up>", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("x", "<leader>p", [["_dP]])

-- tabs
vim.keymap.set("n", "<leader>t1", "1gt<CR>")
vim.keymap.set("n", "<leader>t2", "2gt<CR>")
vim.keymap.set("n", "<leader>t3", "3gt<CR>")
vim.keymap.set("n", "<leader>t4", "4gt<CR>")
vim.keymap.set("n", "<leader>t5", "5gt<CR>")
vim.keymap.set("n", "<leader>tt", ":tabnew<CR>")
vim.keymap.set("n", "<leader>tc", ":tabclose<CR>")

-- yank to system clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set("x", "<leader>p", "\"_dP")

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>cf", "gg=G<CR>")
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>f", [[:%s/<C-r><C-w>/<C-r><C-w>/g<Left><Left><Left>]])
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

vim.keymap.set("n", "<Left>", "<nop>")
vim.keymap.set("n", "<Right>", "<nop>")
vim.keymap.set("n", "<Up>", "<nop>")
vim.keymap.set("n", "<Down>", "<nop>")

vim.keymap.set("n", "F", ":Ccc .<CR>")
vim.cmd([[
" Toggle Vexplore with Ctrl-O
function! ToggleVExplorer()
    if exists("t:expl_buf_num")
        let expl_win_num = bufwinnr(t:expl_buf_num)
        let cur_win_num = winnr()

        if expl_win_num != -1
            while expl_win_num != cur_win_num
                exec "wincmd w"
                let cur_win_num = winnr()
            endwhile

            close
        endif

        unlet t:expl_buf_num
    else
         Vexplore
         let t:expl_buf_num = bufnr("%")
    endif
endfunction

map <silent> <C-O> :call ToggleVExplorer()<CR>
]])
