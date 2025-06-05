return {
	'nvim-treesitter/nvim-treesitter',
	build = ':TSUpdate',
	lazy=false,
	opts = {
		ensure_installed = { 'bash', 'python', 'c', 'html', 'lua', 'markdown', 'vim', 'vimdoc' },
		auto_install = true,
		highlight = {
			enable = true,
			-- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
			--  If you are experiencing weird indenting issues, add the language to
			--  the list of additional_vim_regex_highlighting and disabled languages for indent.
			additional_vim_regex_highlighting = { 'ruby', 'markdown' },
		},
		indent = { enable = true, disable = { 'ruby' } },
	},
	branch="master"
	--[[config = function(_, opts)
		require('nvim-treesitter.configs').setup(opts)
	end, ]]--
}
