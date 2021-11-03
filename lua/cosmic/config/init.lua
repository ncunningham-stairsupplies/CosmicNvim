-- DO NOT TOUCH :)
local ok, user_config = pcall(require, 'cosmic.config.config')

if not ok then
  error(('Error loading user config...\n\n%s'):format(user_config))
  error('No user config, using default instead...')
end

if user_config == true then
  user_config = {}
end

-- these settings will be merged with any settings definined in config.lua
local default_config = {
  statusline = {
    main_icon = require('cosmic.core.theme.icons').ghost,
  },
  treesitter = {
    ensure_installed = {
      'typescript',
      'javascript',
      'tsx',
      'html',
      'css',
      'lua',
      'json',
      'scss',
    },
  },
  lsp = {
    format_on_save = true, -- true/false or table of filetypes {'.ts', '.js',}
    rename_notification = true,
    -- vim.diagnostic.config settiings
    diagnostic = {
      underline = true,
      signs = true,
      update_in_insert = false,
      severity_sort = true,
      float = {
        show_header = false,
        source = 'always',
        border = 'single',
      },
      virtual_text = {
        spacing = 4,
        source = 'always',
        severity = {
          min = vim.diagnostic.severity.HINT,
        },
        -- todo: icons for diagnostics?
        --[[ format = function(diagnostic)
          if diagnostic.severity == vim.diagnostic.severity.ERROR then
            return ('E: %s'):format(diagnostic.message)
          end
          return diagnostic.message
        end, ]]
      },
    },
    servers = {
      -- enable/disable server + formatting
      -- rust_analyzer = true, -- enable non-default servers

      -- or override lsp server options
      --[[
      rust_analyzer = {
        opts = {}
      },
      ]]

      -- enable, but disable formatting
      eslint = {
        format = false,
      },
      efm = {
        format = true,
        disable_formatters = { 'eslint' }, -- e.g. 'eslint', 'prettier', 'stylua'
      },
      sumneko_lua = {
        opts = {
          settings = {
            Lua = {
              diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { 'vim' },
              },
              workspace = {
                -- Make the server aware of Neovim runtime files
                library = {
                  [vim.fn.expand('$VIMRUNTIME/lua')] = true,
                  [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
                },
                maxPreload = 10000,
              },
            },
          },
        },
      },
      tsserver = {
        format = false, -- disable formatting all together
      },
    },
  },
}

local config = vim.tbl_deep_extend('force', default_config, user_config)
local user_servers = vim.tbl_keys(config.lsp.servers)
function config.lsp.can_client_format(client_name)
  if config.lsp.servers[client_name] == true then
    return true
  end

  if vim.tbl_contains(user_servers, client_name) and config.lsp.servers[client_name] then
    return (config.lsp.servers[client_name].format == true)
  end

  return false
end

return config
