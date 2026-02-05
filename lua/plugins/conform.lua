-- Plugin: conform.nvim
-- Funcionalidad: Plugin para formateo automático de archivos.
-- Se encarga de ejecutar herramientas externas como black, prettier, stylua, etc., para dar formato a tu código.
-- También puede usarse como reemplazo o complemento al formateo de LSP.

-- Evita cargar el plugin si estás dentro de VSCode
return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" }, -- Se carga al abrir o crear un archivo

	opts = {
		-- Asociar herramientas de formateo por tipo de archivo
		formatters_by_ft = {
			lua = { "stylua" }, -- Formateador para código Lua
			python = { "isort", "black" }, -- isort para ordenar imports, black para formato general
			bash = { "shfmt" }, -- Bash/sh script
			sh = { "shfmt" },
			sql = { "sql-formatter" }, -- Formato para consultas SQL
			json = { "prettier" },
			yaml = { "prettier" },
			markdown = { "prettier" },
			java = { "google-java-format" },
			-- Puedes añadir más: java, html, javascript, etc.
		},

		-- Configuración para autoformato al guardar
		format_on_save = {
			lsp_fallback = true, -- Usa el LSP si no se encuentra formateador externo
			async = false, -- Formateo sincrónico (espera a que termine antes de guardar)
			timeout_ms = 1000, -- Tiempo máximo de espera para el formateo
		},
	},

	init = function()
		-- Establece conform como función de formateo para comandos como `gq`
		vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
	end,

	-- Atajos personalizados
	keys = {
		{
			"<leader>cf", -- Al presionar <leader>f se ejecuta el formateo del archivo actual
			function()
				require("conform").format({ lsp_fallback = true })
			end,
			desc = "Formatear archivo con Conform",
		},
	},
}
