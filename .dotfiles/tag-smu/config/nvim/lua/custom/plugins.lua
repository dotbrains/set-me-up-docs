local plugins = {
    { -- Nord theme
        -- see: https://github.com/shaunsingh/nord.nvim
        "shaunsingh/nord.nvim"
    }, { -- A small (Neo)Vim wrapper for zoxide.
        -- see: https://github.com/nanotee/zoxide.vim
        "nanotee/zoxide.vim"
    },
    { -- An extension for telescope.nvim that allows you operate zoxide within Neovim.
        -- see: https://github.com/jvgrootveld/telescope-zoxide
        "jvgrootveld/telescope-zoxide"
    }, {
        -- Fully featured & enhanced replacement for copilot.vim complete with API for interacting with Github Copilot
        -- see: https://github.com/zbirenbaum/copilot.lua
        "zbirenbaum/copilot.lua",
        event = "InsertEnter",
        opts = require("custom.configs.overrides").copilot
    }, {
        -- copilot.lua + copilot-cmp in NvChad
        -- see: https://gist.github.com/ianchesal/93ba7897f81618ca79af01bc413d0713
        "hrsh7th/nvim-cmp",
        dependencies = {
            {
                "zbirenbaum/copilot-cmp",
                config = function()
                    require("copilot_cmp").setup()
                end
            }
        },
        opts = {
            sources = {
                {name = "nvim_lsp", group_index = 2},
                {name = "copilot", group_index = 2},
                {name = "luasnip", group_index = 2},
                {name = "buffer", group_index = 2},
                {name = "nvim_lua", group_index = 2},
                {name = "path", group_index = 2}
            }
        }
    }, -- {
    --     "dreamsofcode-io/ChatGPT.nvim",
    --     event = "VeryLazy",
    --     dependencies = {"MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim"},
    --     config = function()
    --         require("chatgpt").setup({
    --             async_api_key_cmd = "pass show api/openai"
    --         })
    --     end
    -- }, -- Plugins for Node.js development
    {
        "rcarriga/nvim-dap-ui",
        event = "VeryLazy",
        dependencies = "mfussenegger/nvim-dap",
        config = function()
            local dap = require("dap")
            local dapui = require("dapui")
            require("dapui").setup()
            dap.listeners.after.event_initialized["dapui_config"] = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated["dapui_config"] = function()
                dapui.close()
            end
            dap.listeners.before.event_exited["dapui_config"] = function()
                dapui.close()
            end
        end
    }, {
        "mfussenegger/nvim-dap",
        config = function()
            require "custom.configs.dap"
            require("core.utils").load_mappings("dap")
        end
    }, -- null-ls is deprecated
    -- see: https://github.com/jose-elias-alvarez/null-ls.nvim/issues/1621
    -- {
    --   "jose-elias-alvarez/null-ls.nvim",
    --   event = "VeryLazy",
    --   opts = function()
    --     return require "custom.configs.null-ls"
    --   end,
    -- },
    {
        "mhartington/formatter.nvim",
        event = "VeryLazy",
        opts = function() return require "custom.configs.formatter" end
    }, {
        "mfussenegger/nvim-lint",
        event = "VeryLazy",
        config = function() require "custom.configs.lint" end
    }, {
        "williamboman/mason.nvim",
        opts = {
            ensure_installed = {
                "eslint-lsp", "js-debug-adapter", "prettier",
                "typescript-language-server"
            }
        }
    }, {
        "neovim/nvim-lspconfig",
        config = function()
            require "plugins.configs.lspconfig"
            require "custom.configs.lspconfig"
        end
    }
}

return plugins
