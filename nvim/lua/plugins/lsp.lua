return {
    'neovim/nvim-lspconfig',
    dependencies = {'saghen/blink.cmp'},

    -- example using opts for defining servers
    opts = {inlay_hints = {enabled = true}, servers = {lua_ls = {}}},
    config = function(_, opts)
        for server, config in pairs(opts.servers) do
            -- passing config.capabilities to blink.cmp merges with the capabilities in your
            -- `opts[server].capabilities, if you've defined it
            config.capabilities = require('blink.cmp').get_lsp_capabilities(
                                      config.capabilities)
            vim.lsp.config(server, config)
        end

        -- LSPs
        local capabilities = vim.lsp.protocol.make_client_capabilities()

        -- vim.lsp.enable("ts_ls")
        vim.lsp.config("ts_ls", {
            workspace_required = true,
            root_markers = {"package.json"}
        })
        vim.lsp.enable("rust_analyzer")

        -- Python

        vim.lsp.enable("basedpyright")
        vim.lsp.config('basedpyright', {
            root_markers = {
                "pyproject.toml", "setup.py", "setup.cfg", ".git", ".venv",
                "venv"
            },
            settings = {
                basedpyright = {
                    analysis = {
                        -- Forces background indexing across the workspace
                        diagnosticMode = "workspace",
                        -- Helps index symbols inside external libraries/dependencies
                        useLibraryCodeForTypes = true
                    }
                }
            }
        })

        -- vim.lsp.enable("ty")
        -- vim.lsp.config('ty', {
        --     root_markers = {
        --         "pyproject.toml", "setup.py", "setup.cfg", ".git", ".venv", "venv"
        --     },
        --     settings = {
        --         ty = {
        --             inlayHints = {
        --                 variableTypes = true,
        --                 callArgumentNames = true,
        --             },
        --             completions = {
        --                 autoImport = true,
        --                 completeFunctionParentheses = false,
        --             },
        --             diagnosticMode = "openFilesOnly",
        --             showSyntaxErrors = true,
        --         },
        --     },
        -- })

        -- vim.lsp.enable("ruff")
        -- vim.lsp.config('ruff', {
        --   init_options = {
        --     settings = {
        --       configuration = vim.fn.expand('~/.ruff_config'),
        --       configurationPreference = "filesystemFirst",
        --     }
        --   }
        -- })

        -- vim.lsp.inlay_hint.enable()
        capabilities.textDocument.completion.completionItem.snippetSupport =
            true
    end

    -- example calling setup directly for each LSP
}
