-- Python spezifische Einstellungen
vim.api.nvim_create_autocmd("FileType", {
	pattern = "sh",
	callback = function()
		-- Führe das aktuelle Python-Skript aus
		vim.api.nvim_buf_set_keymap(0, "n", "<leader>o", ":! clear; bash %<CR>", { noremap = true, silent = true })

        vim.g.is_bash=1
		-- Entferne überflüssige Leerzeichen vor dem Speichern
		-- vim.api.nvim_create_autocmd("BufWritePre", {
			-- pattern = "*.py",
			-- command = [[:%s/\s\+$//e]],
		-- })
	end,
})
