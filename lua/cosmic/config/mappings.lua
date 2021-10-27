-- Additional remaps

--[[
local map = require('cosmic.utils').map

map('i', 'jj', '<esc>', { noremap = true, silent = true })
]]

require('which-key').setup{}
local wk = require("which-key")
wk.register({
    f = {
        name = "Finders",
        f = {"Find files"},
        g = {"Find text in files"},
        b = {"Find buffers"}
    },
    l = {
        name = "LSP",
        a = {"Code Action"},
        d = {"Document Diagnostics"},
        f = {"Format File"},
        r = {"Rename Mark"},
        t = {
            name = "Typescript",
            i = {"Import All"},
            o ={"Organize Imports"},
            r ={"Rename File"}
        }

    },
    ['k'] = "which_key_ignore",
    ['p'] = "which_key_ignore",
    ['r'] = "which_key_ignore",
    ['s'] = "which_key_ignore",
    ['g'] = "which_key_ignore",
    ['c'] = "which_key_ignore",
    ['h'] = "which_key_ignore",
    ['w'] = "which_key_ignore",
}, { prefix = "<leader>"})

local opts = { noremap = true, silent = true}
local map = require('cosmic.utils').map

vim.api.nvim_del_keymap('n', '<leader>f')
vim.api.nvim_del_keymap('n', '<leader>k')
vim.api.nvim_del_keymap('n', '<leader>p')
vim.api.nvim_del_keymap('n', '<leader>r')
vim.api.nvim_del_keymap('n', '<leader>s')
vim.api.nvim_del_keymap('n', '<leader>ga')
vim.api.nvim_del_keymap('n', '<leader>gc')
vim.api.nvim_del_keymap('n', '<leader>ge')
vim.api.nvim_del_keymap('n', '<leader>gf')
vim.api.nvim_del_keymap('n', '<leader>gi')
vim.api.nvim_del_keymap('n', '<leader>go')
vim.api.nvim_del_keymap('n', '<leader>gr')
vim.api.nvim_del_keymap('n', '<leader>gs')
vim.api.nvim_del_keymap('n', '<leader>cf')
vim.api.nvim_del_keymap('n', '<leader>ck')
vim.api.nvim_del_keymap('n', '<leader>co')
vim.api.nvim_del_keymap('n', '<leader>cc')

-- setup lsp mappings
map('n', '<leader>la', '<cmd>lua require("telescope.builtin").lsp_code_actions()<cr>', opts)
map('n', '<leader>ld', '<cmd>lua require("telescope.builtin").lsp_document_diagnostics()<cr>', opts)
map('n', '<leader>lf', '<cmd>lua vim.lsp.buf.formatting()<cr>', opts)
map('n', '<leader>lr', '<cmd>lua require("cosmic.core.theme.ui").rename()<cr>', opts)
map('n', '<leader>lti', ':TSLspImportAll<CR>', opts)
map('n', '<leader>lto', ':TSLspOrganize<CR>', opts)
map('n', '<leader>ltr', ':TSLspRenameFile<CR>', opts)


-- setup finds
map('n', '<leader>ff', ':Telescope find_files<CR>', opts)
map('n', '<leader>fg', ':Telescope live_grep<CR>', opts)
map('n', '<leader>fb', ':Telescope buffers<CR>', opts)

