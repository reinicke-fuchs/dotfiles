vim.g.UltiSnipsSnippetDirectories={vim.fn.stdpath('config').. "/UltiSnips_work", vim.fn.stdpath('data').."/lazy/vim-snippets/UltiSnips"}
vim.g.UltiSnipsExpandTrigger="<tab>"
vim.g.UltiSnipsJumpForwardTrigger="<C-Y>"
vim.g.UltiSnipsJumpBackwardTrigger="<C-S-Y>"

vim.g.UltiSnipsEditSplit="vertical"

-- Split Einstellungen
vim.o.splitbelow = true
vim.o.splitright = true

-- Standard-Editor-Einstellungen
vim.o.tabstop = 4
vim.o.expandtab = true
vim.o.shiftwidth = 4

-- Systemweite Zwischenablage aktivieren
vim.o.clipboard = "unnamedplus"
--
-- Kompatibilitäts-Optionen
vim.o.cpoptions = vim.o.cpoptions:gsub("C", "") -- Entfernt 'C' aus cpoptions
vim.o.compatible = false -- Setzt nocompatible
--
-- Leader-Taste setzen
vim.g.mapleader = ","

vim.g.vimwiki_global_ext = 1
vim.g.vimwiki_key_mappings = { table_mappings = 0, }
vim.g.vimwiki_list={{ path = '~/doc/vimwiki', syntax = 'markdown', ext = 'md'}}
vim.g.UltiSnipsFiletypeOverride = { vimwiki = 'markdown' }

vim.opt.termguicolors = true
--
-- YouCompleteMe clangd Einstellungen
vim.g.ycm_clangd_args = { "--fallback-style=file" }
--
-- clang-format Optionen
vim.g["clang_format#style_options"] = {
	Language = "Cpp",
	BasedOnStyle = "Google",
	AlignConsecutiveAssignments = "None",
	AlignConsecutiveDeclarations = "None",
	AlignEscapedNewlines = "Right",
	AlignOperands = "Align",
	AlignTrailingComments = "true",
	AlignAfterOpenBracket = "DontAlign",
	AllowAllParametersOfDeclarationOnNextLine = "true",
	AllowShortBlocksOnASingleLine = "Never",
	AllowShortCaseLabelsOnASingleLine = "false",
	AllowShortFunctionsOnASingleLine = "Empty",
	AllowShortIfStatementsOnASingleLine = "false",
	AllowShortLoopsOnASingleLine = "false",
	AlwaysBreakAfterReturnType = "None",
	AlwaysBreakBeforeMultilineStrings = "false",
	AllowAllArgumentsOnNextLine = "false",
	BinPackArguments = "true",
	BinPackParameters = "false",
	BreakBeforeBinaryOperators = "All",
	BreakBeforeTernaryOperators = "true",
	BreakStringLiterals = "true",
	ForEachMacros = { "ADT_LIST_FOREACH", "ADT_LIST_FOREACH_FIRST", "ADT_LIST_FOREACH_SAFE" },
	SortIncludes = "Never",
	IndentCaseLabels = "false",
	IndentPPDirectives = "None",
	IndentWrappedFunctionNames = "false",
	KeepEmptyLinesAtTheStartOfBlocks = "false",
	PenaltyReturnTypeOnItsOwnLine = 60,
	PenaltyBreakBeforeFirstCallParameter = 200,
	PenaltyBreakAssignment = 300,
	PenaltyBreakString = 1000,
	PenaltyBreakComment = 2000,
	PenaltyExcessCharacter = 3000,
	PointerAlignment = "Right",
	DerivePointerAlignment = "false",
	ReflowComments = "false",
	SpaceBeforeAssignmentOperators = "true",
	SpaceInEmptyParentheses = "false",
	SpacesBeforeTrailingComments = 1,
	SpacesInContainerLiterals = "false",
	SpacesInParentheses = "false",
	SpacesInSquareBrackets = "false",
	IndentWidth = 4,
	TabWidth = 4,
	UseTab = "Never",
	ContinuationIndentWidth = 4,
	BreakBeforeBraces = "Custom",
	BraceWrapping = {
		AfterClass = "false",
		AfterCaseLabel = "true",
		AfterEnum = "false",
		AfterFunction = "true",
		AfterNamespace = "false",
		AfterStruct = "false",
		AfterUnion = "false",
		AfterExternBlock = "false",
		BeforeCatch = "false",
		BeforeElse = "false",
		IndentBraces = "false",
		SplitEmptyFunction = "false",
		SplitEmptyRecord = "false",
		SplitEmptyNamespace = "false",
	},
	MaxEmptyLinesToKeep = 1,
	ColumnLimit = 80,
	SpaceBeforeParens = "ControlStatements",
	SpaceAfterCStyleCast = "false",
	SpacesInCStyleCastParentheses = "false",
}

-- Editor-Einstellungen
vim.o.encoding = "utf-8"
vim.o.number = true
vim.o.relativenumber = true
vim.o.wildmode = "longest,list,full"

-- Farben
vim.g.gruvbox_contrast_dark = "hard"
vim.o.background = "dark"

-- Autocorrect Personal File
vim.g.AutocorrectPersonalFile = "~/.config/autocorrect.text"

-- Highlighting Einstellungen für Spellchecking
--vim.cmd([[
--    hi clear SpellBad
--    hi SpellBad cterm=underline
--    hi clear SpellRare
--    hi SpellRare cterm=underline
--    hi clear SpellCap
--    hi SpellCap cterm=underline
--    hi clear SpellLocal
--    hi SpellLocal cterm=underline
--]])
-- Clang Library Path
vim.g.clang_library_path = "/usr/lib/libclang.so"

-- Autocorrect Filetypes
vim.g.AutocorrectFiletypes = { "text", "markdown", "tex" }

-- Syntax aktivieren
vim.cmd("syntax enable")
--
-- clang-format Einstellungen
vim.g["clang_format#auto_format_on_insert_leave"] = 0
vim.g["clang_format#detect_style_file"] = 1
vim.g["clang_format#enable_fallback_style"] = 0
vim.g["clang_format#auto_filetypes"] = { "c", "cpp", "h", "hpp" }

-- NerdTree Konfiguration
vim.g.NERDTreeQuitOnOpen = 1
vim.api.nvim_set_keymap("n", "<F3>", ":NERDTreeToggle<CR>", { noremap = true, silent = true })

-- vim_tags Main File
vim.g.vim_tags_main_file = "~/tags"

-- Matchup Surround Plugin
vim.g.match_up_surround_enabled = 1
--
-- Session Autosave Deaktivieren
vim.g.session_autosave = "no"

-- NERDTree und Kommentar-Einstellungen
vim.g.NERDCreateDefaultMappings = 0
vim.g.NERDCommentEmptyLines = 1
vim.g.NERDSpaceDelims = 1
--
-- Vimwiki Einstellungen
vim.api.nvim_create_autocmd("FileType", {
	pattern = "wiki",
	callback = function()
		vim.opt_local.compatible = false
		vim.opt_local.filetype = "plugin"
		vim.opt_local.syntax = "on"
	end,
})
-- Filetype-spezifische Einstellungen
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "c", "h", "hh", "hpp", "cc", "cpp" },
	callback = function()
		vim.opt_local.autoindent = false
		vim.opt_local.shiftwidth = 4
		vim.opt_local.expandtab = true
		vim.opt_local.tabstop = 4
	end,
})

-- Filetype-spezifische Einstellungen
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "xml" },
	callback = function()
		vim.opt_local.autoindent = false
		vim.opt_local.shiftwidth = 4
		vim.opt_local.expandtab = true
		vim.opt_local.tabstop = 4
	end,
})

-- vim.api.nvim_create_autocmd("FileType", {
	-- pattern = { "c", "cc", "cpp", "h", "hpp", "hh" },
	-- callback = function()
		-- source_config_file("c-config.vim")
	-- end,
-- })

vim.api.nvim_create_autocmd({"BufNewFile", "BufRead", "BufWritePost"}, {
  pattern = {"*.c", "*.h", "*.cpp", "*.hpp", "*.py", "*.js", "*.ts", "*.go", "*.rs", "*.java", "*.php"},
  callback = function(opts)
    vim.fn.jobstart("ctags -R --tag-relative=never --fields=+n --sort=yes --append=yes -o ~/.cache/nvim/tags ".. opts.file, { detach = true })
  end,
})
-- vim.api.nvim_create_autocmd({"BufNewFile", "BufRead", "BufWritePost", "BufEnter"}, {
  -- pattern = {"*.c", "*.h", "*.cpp", "*.hpp", "*.py", "*.js", "*.ts", "*.go", "*.rs", "*.java", "*.php"},
  -- callback = function()
    -- vim.fn.jobstart("ctags --sort=yes ~/tags", { detach = true })
  -- end,
-- })
-- Query with the command
-- :set tags?
--
vim.api.nvim_create_autocmd({"ColorScheme", "BufNewFile", "BufRead", "BufWritePost"}, {
  pattern = {"*.c", "*.h", "*.cpp", "*.hpp", "*.py", "*.js", "*.ts", "*.go", "*.rs", "*.java", "*.php"},
  callback = function(opts)
      vim.cmd("set colorcolumn=81")
      --vim.cmd("highlight ColorColumn ctermfg=red ctermbg=red")
  end,
})
require("options.python")
require("options.shell")

vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  update_in_insert = false,
  underline = true,
  severity_sort = false,
  float = true,
})
--vim.cmd("autocmd BufEnter * if winnr() == winnr('h') && bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 | let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif")

--vim.cmd("autocmd VimEnter * if argc() == 0 && !exists('s:std_in') && v:this_session == '' | Vexplore | endif")
--vim.cmd("autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in') | execute 'Vexplore' argv()[0] | execute 'cd '.argv()[0] | endif")

-- CtrlP spezifische Mappings
vim.g.ctrlp_map = "<leader>."
vim.g.ctrlp_cmd = "CtrlPMRU"


