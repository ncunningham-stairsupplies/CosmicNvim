local default_on_attach = require('cosmic.lsp.providers.defaults').on_attach
local config = require('cosmic.config')
local M = {}

function M.on_attach(client, bufnr)
  default_on_attach(client, bufnr)

  local ts_utils = require('nvim-lsp-ts-utils')

  -- defaults
  ts_utils.setup(vim.tbl_deep_extend('force', {
    debug = false,
    disable_commands = false,
    enable_import_on_completion = true,

    -- import all
    import_all_timeout = 5000, -- ms
    import_all_priorities = {
      buffers = 4, -- loaded buffer names
      buffer_content = 3, -- loaded buffer content
      local_files = 2, -- git files or files with relative path markers
      same_file = 1, -- add to existing import statement
    },
    import_all_scan_buffers = 100,
    import_all_select_source = false,

    -- eslint
    eslint_enable_code_actions = true,
    eslint_enable_disable_comments = true,
    eslint_bin = 'eslint_d',
    eslint_enable_diagnostics = true,
    -- eslint_opts = {},

    -- formatting
    enable_formatting = true,
    formatter = 'prettierd',
    -- formatter_opts = {},

    -- update imports on file move
    update_imports_on_move = true,
    require_confirmation_on_move = false,
    watch_dir = nil,

    -- filter diagnostics
    filter_out_diagnostics_by_severity = {},
    filter_out_diagnostics_by_code = {},
  }, config.lsp.ts_utils or {}))

  -- required to fix code action ranges and filter diagnostics
  ts_utils.setup_client(client)
end

return M
