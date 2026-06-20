return {
    "rmagatti/auto-session",
    lazy = false,

    ---enables autocomplete for opts
    ---@module "auto-session"
    ---@type AutoSession.Config
    opts = {
        suppressed_dirs = {"~/", "~/Projects", "~/Downloads", "/"},
	close_filetypes_on_save = {"terminal"},

        -- log_level = 'debug',
     --    preserve_buffer_on_restor = function(bufnr)
     --        local buffer_name = vim.api.nvim_buf_get_name(bufnr)
	    -- print("I'm working!")
     --        return buffer_name ~= nil
     --    end
    }
}
