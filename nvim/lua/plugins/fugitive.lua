return {
    "tpope/vim-fugitive",
    config = function()
        vim.keymap.set("n", "<leader>gs", vim.cmd.Git);

        local REF = 'master';

        vim.keymap.set("n", "<leader>gv",
                       function() vim.cmd.Gvdiffsplit(REF) end);
        vim.keymap.set("n", "<leader>gt",
                       function() vim.cmd.Git('difftool ' .. REF) end);

        vim.keymap.set("n", "<leader>gi",
                       function() REF = vim.fn.input("difftool ref: ") end);

    end
}
