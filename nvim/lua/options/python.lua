-- Python spezifische Einstellungen
vim.api.nvim_create_autocmd("FileType", {
	pattern = "python",
	callback = function()
		-- Führe das aktuelle Python-Skript aus
		vim.api.nvim_buf_set_keymap(0, "n", "<C-o>", ":! clear; python3 %<CR>", { noremap = true, silent = true })

		-- Entferne überflüssige Leerzeichen vor dem Speichern
		vim.api.nvim_create_autocmd("BufWritePre", {
			pattern = "*.py",
			command = [[:%s/\s\+$//e]],
		})
	end,
})
-- Autokommandos für Python-Dateien
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
	pattern = "*.py",
	callback = function()
		vim.bo.tabstop = 4
		vim.bo.softtabstop = 4
		vim.bo.shiftwidth = 4
		vim.bo.textwidth = 79
		vim.bo.expandtab = true
		vim.bo.autoindent = true
		vim.bo.fileformat = "unix"
	end,
})


vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  update_in_insert = false,
  underline = true,
  severity_sort = false,
  float = true,
})
