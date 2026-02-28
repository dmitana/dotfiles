return {
  -- nvim-lspconfig
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- Python
        pyright = {
          settings = {
            python = {
              analysis = {
                typeCheckingMode = "strict",
              }
            },
          }
        },
        pylsp = {
          settings = {
            pylsp = {
              plugins = {
                pydocstyle = { enabled = false },
                jedi_completion = { enabled = false },
                jedi_definition = { enabled = false },
                yapf = { enabled = false },
                rope_completion = { enabled = false },
                pylint = { enabled = false },
                pyflakes = { enabled = false },
                preload = { enabled = false },
                mccabe = { enabled = false },
                jedi_symbols = { enabled = false },
                jedi_references = { enabled = false },
              },
              -- Use flake8 instead of pycodestyle
              configurationSources = "flake8"
            },
          },
        },
        -- Lua (config is from lazydev)
        lua_ls = {
          settings = {
            Lua = {
              diagnostics = {
                enable = true,
                neededFileStatus = {
                  codestyle_check = "Any",
                },
              },
              format = {
                enable = true,
                -- https://github.com/CppCXY/EmmyLuaCodeStyle/blob/master/docs/format_config_EN.md
                defaultConfig = {
                  indent_style = "space",
                  indent_size = "2",
                  quote_style = "double",
                }
              },
              hint = {
                enable = false,
              },
              workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
              },
            }
          }
        },
        -- Webdev: HTML, CSS, TS, JS
        html = {},
        cssls = {},
        ts_ls = {},
        eslint = {},
        -- JSON
        jsonls = {},
      },
    },
    config = function(_, opts)
      for server, config in pairs(opts.servers) do
        vim.lsp.config(server, config)
        vim.lsp.enable(server)
      end
    end,
  },
  -- Faster LuaLS setup for Neovim
  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
}
