return {
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		cmd = { "Noice" },
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},

		keys = {
			{ "<leader>sn", "", desc = "+noice" },

			{
				"<S-Enter>",
				function()
					require("noice").redirect(vim.fn.getcmdline())
				end,
				mode = "c",
				desc = "Redirigir cmdline",
			},

			{
				"<leader>snl",
				function()
					require("noice").cmd("last")
				end,
				desc = "Último mensaje (Noice)",
			},
			{
				"<leader>snh",
				function()
					require("noice").cmd("history")
				end,
				desc = "Historial (Noice)",
			},
			{
				"<leader>sna",
				function()
					require("noice").cmd("all")
				end,
				desc = "Todos los mensajes (Noice)",
			},
			{
				"<leader>snd",
				function()
					require("noice").cmd("dismiss")
				end,
				desc = "Descartar todo (Noice)",
			},
			{
				"<leader>snt",
				function()
					require("noice").cmd("pick")
				end,
				desc = "Selector (Telescope/FzfLua)",
			},

			{
				"<C-f>",
				function()
					if not require("noice.lsp").scroll(4) then
						return "<C-f>"
					end
				end,
				silent = true,
				expr = true,
				mode = { "i", "n", "s" },
				desc = "Scroll adelante (Noice)",
			},
			{
				"<C-b>",
				function()
					if not require("noice.lsp").scroll(-4) then
						return "<C-b>"
					end
				end,
				silent = true,
				expr = true,
				mode = { "i", "n", "s" },
				desc = "Scroll atrás (Noice)",
			},
		},

		opts = {
			-- cmdline bonito
			cmdline = {
				view = "cmdline_popup",
				format = {
					cmdline = { icon = "", title = " Comando " },
					search_down = { icon = "🔍 ", title = " Buscar ↓" },
					search_up = { icon = "🔍 ", title = " Buscar ↑" },
				},
			},

			-- búsquedas / mensajes
			messages = {
				view_search = "virtualtext",
			},

			-- popupmenu (esto NO es nvim-cmp, es el menu de cmdline/noice)
			popupmenu = {
				enabled = true,
				backend = "nui",
			},

			-- LSP
			lsp = {
				progress = { enabled = true },
				signature = { enabled = true },
				hover = { enabled = true },
				message = { enabled = true },

				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true,
				},

				documentation = {
					border = { style = "rounded" },
				},
			},

			-- filtros útiles para bajar spam
			routes = {
				{
					filter = {
						event = "msg_show",
						any = {
							{ find = "%d+L, %d+B" },
							{ find = "; after #%d+" },
							{ find = "; before #%d+" },
						},
					},
					view = "mini",
				},
			},

			-- vistas
			views = {
				cmdline_popup = {
					position = { row = 20, col = "50%" },
					size = { width = 60, height = "auto" },
					border = { style = "rounded", padding = { 0, 1 } },
					win_options = { winblend = 0 }, -- sin transparencia
				},
				popupmenu = {
					relative = "editor",
					position = { row = 8, col = "50%" },
					size = { width = 60, height = 10 },
					border = { style = "rounded", padding = { 0, 1 } },
					win_options = {
						winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
						winblend = 0,
					},
				},
			},

			presets = {
				bottom_search = true,
				command_palette = true,
				long_message_to_split = true,
				inc_rename = false,
				lsp_doc_border = true,
			},
		},

		config = function(_, opts)
			-- opcional: limpia mensajes cuando abres Lazy
			if vim.o.filetype == "lazy" then
				vim.cmd([[messages clear]])
			end
			require("noice").setup(opts)

			-- highlights (sin forzar bg NONE)
			vim.api.nvim_set_hl(0, "NoiceCmdlinePopup", { link = "NormalFloat" })
			vim.api.nvim_set_hl(0, "NoiceCmdlinePopupBorder", { link = "FloatBorder" })
		end,
	},

	-- notify separado (mejor práctica)
	{
		"rcarriga/nvim-notify",
		lazy = true,
		opts = { timeout = 3000, stages = "fade" },
		config = function(_, opts)
			local ok, notify = pcall(require, "notify")
			if ok then
				notify.setup(opts)
				vim.notify = notify
			end
		end,
	},
}
