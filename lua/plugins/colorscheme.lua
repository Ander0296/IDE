-- Este archivo configura el esquema de colores de Neovim

return {

	--1 Kanagawa
	{
		"rebelot/kanagawa.nvim",
		-- Configuración del plugin
		priority = 1000,
		config = function()
			-- Configura Kanagawa con las siguientes opciones:
			require("kanagawa").setup({
				compile = true, -- Compila los colores para mejorar el rendimiento
				transparent = false, -- Fondo transparente (útil si usas una terminal con fondo personalizado)
				overrides = function(colores)
					return {
						["@markup.link.url.markdown_inline"] = { link = "Special" }, -- (url)
						["@markup.link.label.markdown_inline"] = { link = "WarningMsg" }, -- [label]
						["@markup.italic.markdown_inline"] = { link = "Exception" }, -- *italic*
						["@markup.raw.markdown_inline"] = { link = "String" }, -- `code`
						["@markup.list.markdown"] = { link = "Function" }, -- + list
						["@markup.quote.markdown"] = { link = "Error" }, -- > blockcode
						["@markup.list.checked.markdown"] = { link = "WarningMsg" }, -- - [X] checked list item
					}
				end,
			})
			-- Aplica el esquema de colores "kanagawa-dragon"
			vim.cmd("colorscheme kanagawa-dragon")
		end,
		-- Al construir (instalar/actualizar) el plugin, se compilan los colores
		build = function()
			vim.cmd("KanagawaCompile")
		end,
	},

	--2 Everforest
	{
		"sainnhe/everforest",
		priority = 999,
		config = function()
			vim.g.everforest_background = "soft"
			vim.g.everforest_transparent_background = 1
		end,
	},

	--3 Gruvbox
	{
		"ellisonleao/gruvbox.nvim",
		priority = 998,
		opts = {
			terminal_colors = true,
			transparent_mode = false,
		},
	},
	--4 Nord
	{
		"shaunsingh/nord.nvim",
		priority = 997,
	},

	--5 Catppuccin (recomendado)
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 996,
		config = function()
			require("catppuccin").setup({
				flavour = "mocha",
				transparent_background = false,
			})
		end,
	},

	-- Rose Pine
	{
		"rose-pine/neovim",
		priority = 995,
		name = "rose-pine",
		config = function()
			require("rose-pine").setup({
				variant = "auto", -- main, moon, dawn
				enable = {
					terminal = true,
					legacy_highlights = true,
				},
				styles = {
					transparency = false,
				},
			})
		end,
	},
	{
		"projekt0n/github-nvim-theme",
		name = "github-theme",
		priority = 994,
		config = function()
			require("github-theme").setup({
				options = {
					transparent = false,
					terminal_colors = true,
				},
			})
		end,
	},
}
