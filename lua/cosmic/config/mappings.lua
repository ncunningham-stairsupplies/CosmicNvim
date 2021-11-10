-- Add additional keymaps or disable existing ones
-- To view maps set, use `:Telescope keymaps`
-- or `:map`, `:map <leader>`

--[[

local cmd = vim.cmd
local map = require('cosmic.utils').map

-- Example: Additional insert mapping:
map('i', 'jj', '<esc>', { noremap = true, silent = true })

-- Mapping options:
-- map('n', ...)
-- map('v', ...)
-- map('i', ...)
-- map('t', ...)
--
-- Example: Disable find files keymap
cmd('unmap <leader>f')
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
        D = {"Telescope Document Diagnostics"},
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

-- setup lsp mappings
map('n', '<leader>la', '<cmd>lua require("telescope.builtin").lsp_code_actions()<cr>', opts)
map('n', '<leader>lD', '<cmd>lua require("telescope.builtin").lsp_document_diagnostics()<cr>', opts)
map('n', '<leader>lf', '<cmd>lua vim.lsp.buf.formatting()<cr>', opts)
map('n', '<leader>lr', '<cmd>lua require("cosmic.core.theme.ui").rename()<cr>', opts)
map('n', '<leader>lti', ':TSLspImportAll<CR>', opts)
map('n', '<leader>lto', ':TSLspOrganize<CR>', opts)
map('n', '<leader>ltr', ':TSLspRenameFile<CR>', opts)
map('n', '<leader>ld', '<cmd>lua vim.diagnostic.open_float(0, { scope = "buffer", })<cr>')

map('i', '<C-a>', ':copilot#Accept()<cr>', opts)

-- setup finds
map('n', '<leader>ff', ':Telescope find_files<CR>', opts)
map('n', '<leader>fg', ':Telescope live_grep<CR>', opts)
map('n', '<leader>fb', ':Telescope buffers<CR>', opts)

vim.api.nvim_exec(
    [[
        imap <silent><script><expr> <C-a> copilot#Accept("\<CR>")
        let g:copilot_no_tab_map = v:true
    ]],
        true
)
