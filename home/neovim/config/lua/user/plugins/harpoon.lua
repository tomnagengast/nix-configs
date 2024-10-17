return {
	"ThePrimeagen/harpoon",
	lazy = false,
	branch = "harpoon2",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	config = function()
		local harpoon = require("harpoon")
		---@diagnostic disable-next-line: missing-parameter
		harpoon:setup()
		local function map(lhs, rhs, opts)
			vim.keymap.set("n", lhs, rhs, opts or {})
		end
		map("<leader>a", function() harpoon:list():append() end)
		map("<c-p>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
		map("<c-h>", function() harpoon:list():select(1) end)
		map("<c-j>", function() harpoon:list():select(2) end)
		map("<c-k>", function() harpoon:list():select(3) end)
		map("<c-l>", function() harpoon:list():select(4) end)
	end,
	-- keys = {
	-- 	{ "<leader>a", "<cmd>lua require('harpoon.mark').add_file()<cr>", desc = "Mark file with harpoon" },
	-- },
}

