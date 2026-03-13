if os.getenv("MODEL") then
    OLLAMA_MODEL = os.getenv("MODEL")
else
    OLLAMA_MODEL = 'llama3.2:3b'
end

if os.getenv("OLLAMA_HOST") then
    OLLAMA_HOST = os.getenv("OLLAMA_HOST")
else
    OLLAMA_HOST = "0.0.0.0"
end

local explain_code = {
    interaction = "chat",
    description = "Explain how code works",
    prompts = {
        {
            role = "system",
            content = "You are an expert programmer who excels at explaining code clearly and concisely."
        }, {
            role = "user",
            content = function(context)
                local text = require("codecompanion.helpers.actions").get_code(
                                 context.start_line, context.end_line)
                return "Please explain the following code:\n\n"
            end
        }
    }
}

local bash_command = {
    interaction = "chat",
    description = "Get bash command",
    prompts = {
        {
            role = "system",
            content = "Fot the following task generate a bash command. Output only the command, do not explain it."
        }, {
            role = "user",
            content = function(context)
                return "Please generate command for the following task:\n\n"
            end
        }
    }
}

local write_docstring = {
    interaction = "inline",
    description = "Write docstring",
    prompts = {
        {
            role = "system",
            content = "You are an expert programmer who excels at explaining code clearly and concisely."
        }, {
            role = "user",
            content = function(context)
                local text = require("codecompanion.helpers.actions").get_code(
                                 context.start_line, context.end_line)
                return "Please generate docstring for following code:\n\n```" ..
                           context.filetype .. "\n" .. text .. "\n```"

            end
        }
    }
}

require("codecompanion").setup({
    prompt_library = {
        markdown = {
            dirs = {vim.fn.getcwd() .. "/.prompts", "~/.config/prompts"}
        },
        ["Explain Code"] = explain_code,
        ["Bash command"] = bash_command,
        ["Write docstring"] = write_docstring
    },
    adapters = {
        http = {
            ollama = function()
                return require("codecompanion.adapters").extend("ollama", {
                    env = {url = "http://" .. OLLAMA_HOST .. ":11434"},
                    parameters = {sync = true}
                })
            end
        }
    },
    interactions = {
        chat = {
            -- You can specify an adapter by name and model (both ACP and HTTP)
            adapter = {name = "ollama", model = OLLAMA_MODEL}
        },
        -- Or, just specify the adapter by name
        inline = {
            -- You can specify an adapter by name and model (both ACP and HTTP)
            adapter = {name = "ollama", model = OLLAMA_MODEL}
        },
        cmd = {
            -- You can specify an adapter by name and model (both ACP and HTTP)
            adapter = {name = "ollama", model = OLLAMA_MODEL}
        }
    },
    display = {
        diff = {
            enabled = true,
            close_chat_at = 240, -- Close an open chat buffer if the total columns of your display are less than...
            layout = 'vertical', -- vertical|horizontal split for default provider
            opts = {
                'internal', 'filler', 'closeoff', 'algorithm:patience',
                'followwrap', 'linematch:120'
            },
            provider = 'default' -- default|mini_diff
        }
    }
})

-- require("codecompanion").setup({
--     -- adapters = {chat = ollama, inline = ollama, actions = ollama},
--     -- interaction = {chat = ollama, inline = ollama, actions = ollama}
--     strategies = {inline = ollama, chat = ollama, cmd = ollama},
--     adapters = {
--         ollama_llama = function()
--             return require('codecompanion.adapters').extend('ollama', {
--                 name = 'ollama_llama', -- Give this adapter a different name to differentiate it from the default ollama adapter
--                 schema = {model = {default = default_ollama_model}}
--             })
--         end
--     },
--     interactions = {
--         inline = ollama_interactions,
--         chat = ollama_interactions,
--         cmd = ollama_interactions
--     },
-- })

-- Example keymaps
vim.keymap.set('n', '<leader>ah', '<cmd>CodeCompanionChat Toggle<cr>',
               {desc = 'Toggle CodeCompanion chat'})
-- This keymap works on the current line in normal mode, or the visual selection in visual mode
vim.keymap.set({'n', 'v'}, '<leader>ai', '<cmd>CodeCompanion<cr>',
               {desc = 'CodeCompanion Inline action'})

vim.keymap.set({'n', 'v'}, '<leader>ac', '<cmd>CodeCompanionActions<cr>',
               {desc = 'CodeCompanion Actions'})
