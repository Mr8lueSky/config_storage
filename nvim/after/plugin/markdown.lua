-- Disable automatic previews.
require("markview").setup({
    preview = { enable = false }
});

vim.api.nvim_set_keymap("n", "<leader>m", "<CMD>Markview attach<CR><CMD>Markview<CR>", { desc = "Toggles `markview` previews globally." });
