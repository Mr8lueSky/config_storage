local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>pf', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<C-p>', builtin.git_files, { desc = 'Telescope find git files' })
vim.keymap.set('n', '<leader>ps', builtin.live_grep);
require('telescope').setup({
     find_command = {
          'rg',
          '-l',
          '.*',
          '--follow',
          '--hidden',
          '--no-ignore-vcs',
          '--glob',
          '!node_modules/*',
          '--glob',
          '!target/*',
          '--glob',
          '!dist/*',
          '--glob',
          '!.*/',
        }
})
