# Load lazy
vim.g.sonokai_style='shusia'
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
-- lazy.nvim installieren (falls nicht vorhanden)
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

require("options")
require("lazy").setup("plugins")

require("plugin_data")
require("keymaps")
-- Datei-Typen und Plugin-Unterstützung
vim.cmd("filetype plugin on")
--
-- Funktion zum Laden von Konfigurationsdateien
local function source_config_file(name)
	local path = vim.fn.expand("~/.vim/plugin.config/" .. name)
	if vim.fn.filereadable(path) == 1 then
		vim.cmd("source " .. vim.fn.fnameescape(path))
	else
		vim.api.nvim_echo({ { "config file " .. name .. " is not readable.", "ErrorMsg" } }, true, {})
	end
end

-- Lade spezifische Config-Dateien bei bestimmten Dateitypen
vim.api.nvim_create_autocmd("FileType", {
	pattern = "python",
	callback = function()
		source_config_file("python.vim")
	end,
})
--vim.api.nvim_create_autocmd("BufNewFile", {
--  pattern = "*",
--  callback = function()
--  end
--})

-- Keymappings für Zwischenablage
-- vim.api.nvim_set_keymap("n", "<leader>y", '"*y', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("n", "<leader>p", '"*p', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("n", "<leader>Y", '"+y', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("n", "<leader>P", '"+p', { noremap = true, silent = true })

-- Airline Tabline deaktivieren
-- vim.g["airline#extensions#tabline#enabled"] = 0

---- Jedi Einstellungen
--vim.g["jedi#completions_enabled"] = 0
--
--
---- Ruff Formatter
--vim.g.formatdef_ruff = "'ruff format - --range '.a:firstline.' '.a:lastline"
--vim.g.formatters_python = { "ruff" }

function file_exists(name)
   local f=io.open(name,"r")
   if f~=nil then io.close(f) return true else return false end
end

local PIKEOS_DIR="/opt/pikeos-init/eb65d5c87cb9d99a33fe151d439d861e2495008b/sources/"
local p4_header=PIKEOS_DIR .. "ukernel-arm_v8r/lib/p4.h"
local include=PIKEOS_DIR .. "ukernel-arm_v8r/include"
local kernel=PIKEOS_DIR .. "ukernel-arm_v8r/include/kernel"
local kdev=PIKEOS_DIR .. "ukernel-arm_v8r/include/kdev"
local ssw_header=PIKEOS_DIR .. "ssw/include/vm.h"


vim.cmd("let g:jiraVimDomainName = \"https://jiratest.sysgo.com\"")
--vim.cmd("let g:jiraVimEmail = \"rto\"")
vim.cmd("let g:jiraVimToken =\"Mzg4MTI5MjMyMDY4OiiuU3wlfSYbGTT/nICU86LTzobI\"")
vim.g.netrw_winsize=30
-- vim.g.csv_nl = 1
--
--vim.g.xml_syntax_folding=1
--vim.opt.foldmethod = "expr"
--vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
--vim.cmd("au FileType xml setlocal foldmethod=syntax")
