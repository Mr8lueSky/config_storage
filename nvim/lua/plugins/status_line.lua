return {
    'nvim-lualine/lualine.nvim',
    dependencies = {'nvim-tree/nvim-web-devicons'},
    config = function()
        -- spinning line
        local spining_line_items = {"-", "\\", "|", "/"}

        -- snake
        local snake_items = {
            "⠋", "⠙", "⠸", "⠴", "⠦", "⠧", "⠇", "⠏"
        }

        -- falling sand
        local falling_sand_items = {
            "⠁", "⠂", "⠄", "⠌", "⠔", "⠤", "⠥", "⠦", "⠮",
            "⠶", "⠷", "⠿"
        }

        local make_animation = function(items)
            local index = 0
            local inner = function()
                index = index + 1
                if index > #items then index = 1 end
                return items[index]
            end
            return inner
        end

        local falling_sand_animation = make_animation(falling_sand_items)

        require('lualine').setup {
            options = {
                icons_enabled = true,
                theme = 'gruvbox_dark',
                component_separators = {left = '', right = ''},
                section_separators = {left = '', right = ''},
                disabled_filetypes = {statusline = {}, winbar = {}},
                ignore_focus = {},
                always_divide_middle = true,
                always_show_tabline = true,
                globalstatus = false,
                refresh = {
                    statusline = 1000,
                    tabline = 1000,
                    winbar = 1000,
                    refresh_time = 16, -- ~60fps
                    events = {
                        'WinEnter', 'BufEnter', 'BufWritePost',
                        'SessionLoadPost', 'FileChangedShellPost', 'VimResized',
                        'Filetype', 'CursorMoved', 'CursorMovedI', 'ModeChanged'
                    }
                }
            },
            sections = {
                lualine_a = {'mode'},
                lualine_b = {'branch', 'diff', 'diagnostics'},
                lualine_c = {{'filename', path = 1}},
                lualine_x = {
                    function()
                        return vim.fn.fnamemodify(vim.fn.getcwd(), ':t')
                    end, 'encoding', 'fileformat'
                },
                lualine_y = {falling_sand_animation},
                lualine_z = {'location'}
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = {'filename'},
                lualine_x = {'location'},
                lualine_y = {},
                lualine_z = {}
            },
            tabline = {},
            winbar = {},
            inactive_winbar = {},
            extensions = {}
        }

    end
}
