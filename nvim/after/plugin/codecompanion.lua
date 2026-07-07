if os.getenv("MODEL") then
    OLLAMA_MODEL = os.getenv("MODEL")
else
    OLLAMA_MODEL = "glm-5.2:cloud"
end

if os.getenv("OLLAMA_HOST") then
    OLLAMA_HOST = os.getenv("OLLAMA_HOST")
else
    OLLAMA_HOST = "0.0.0.0"
end

O3_LLM_MODEL = "MiniMax-Coder"

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

-- local default_model = {adapter = {name = "o3_llm", model = O3_LLM_MODEL}}
local default_model = {adapter = {name = "ollama", model = OLLAMA_MODEL}}

require("codecompanion").setup({
    prompt_library = {
        markdown = {
            dirs = {vim.fn.getcwd() .. "/.prompts", "~/.config/prompts"}
        },
        ["Explain Code"] = explain_code,
        ["Bash command"] = bash_command,
        ["Write docstring"] = write_docstring
    },
    interactions = {
        chat = default_model,
        inline = default_model,
        cmd = default_model
    },

    chat = {
        show_settings = true -- Shows the model and adapter in the chat buffer
    },
    adapters = {
        http = {
            ollama = function()
                return require("codecompanion.adapters").extend("ollama", {
                    env = {url = "http://" .. OLLAMA_HOST .. ":11434"},
                    parameters = {sync = true}
                })
            end,
            o3_llm = function()
                -- Read API key from file
                local token_file = io.open("/Users/skhulup/.o3_llm_token", "r")
                local api_key = nil
                if token_file then
                    api_key = token_file:read("*a")
                    token_file:close()
                end
                return require("codecompanion.adapters").extend(
                           "openai_compatible", {
                        env = {
                            url = "https://llm-gateway-proton.t.o3.ru/api",
                            api_key = api_key,
                            chat_url = "/chat/completions",
                            models_endpoint = "/models"
                        },
                        schema = {model = {default = O3_LLM_MODEL}}
                    })
            end
        }
    },
    opts = {log_level = 'DEBUG'},
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

-- Example keymaps
vim.keymap.set('n', '<leader>ah', '<cmd>CodeCompanionChat Toggle<cr>',
               {desc = 'Toggle CodeCompanion chat'})
-- This keymap works on the current line in normal mode, or the visual selection in visual mode
vim.keymap.set({'n', 'v'}, '<leader>ai', '<cmd>CodeCompanion<cr>',
               {desc = 'CodeCompanion Inline action'})

vim.keymap.set({'n', 'v'}, '<leader>ac', '<cmd>CodeCompanionActions<cr>',
               {desc = 'CodeCompanion Actions'})
vim.keymap.set({'n', 'v'}, '<leader>aa', require('codecompanion').add,
               {desc = 'CodeCompanion add selected text to chat'})
