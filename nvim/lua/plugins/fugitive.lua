return {
    "tpope/vim-fugitive",
    config = function()
        local fugitive = require('vim.lsp._snippet_grammar')
        vim.keymap.set("n", "<leader>gs", vim.cmd.Git);

        local REF = 'master';

        vim.keymap.set("n", "<leader>gv",
                       function() vim.cmd.Gvdiffsplit(REF) end);
        vim.keymap.set("n", "<leader>gt",
                       function() vim.cmd.Git('difftool ' .. REF) end);

        vim.keymap.set("n", "<leader>gi",
                       function() REF = vim.fn.input("difftool ref: ") end);

        vim.keymap.set("n", "<leader>gc", function()
            local ok, out = pcall(vim.fn.systemlist, {
                "git", "branch", "--format=%(refname:short)"
            })
            _G.git_branch_completion = function(arg_lead)
                if not ok then
                    return {}
                end
                return vim.tbl_filter(function(branch)
                    return vim.startswith(branch, arg_lead)
                end, out)
            end

            local branch = vim.fn.input({
                prompt = "Git branch: ",
                completion = "customlist,v:lua.git_branch_completion"
            })

            if branch ~= "" then vim.cmd.Git('checkout ' .. branch) end

        end);

        vim.keymap.set("n", "<leader>gp", function() vim.cmd.Git('pull') end)
    end
}
