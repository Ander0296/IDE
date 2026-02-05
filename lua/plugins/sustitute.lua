return {
	"gbprod/substitute.nvim", -- Plugin para sustituir (reemplazar) texto de manera cómoda
	event = { "BufReadPre", "BufNewFile" }, -- Se carga al abrir o crear archivos
	config = function()
		local substitute = require("substitute") -- Importa el plugin

		substitute.setup() -- Usa la configuración por defecto

		-- Definir keymaps para diferentes modos y acciones
		local keymap = vim.keymap

		-- Sustituye con un movimiento (por ejemplo, "siw" para sustituir una palabra)
		keymap.set("n", "s", substitute.operator, { desc = "Sustituir con movimiento" })

		-- Sustituye toda la línea actual
		keymap.set("n", "ss", substitute.line, { desc = "Sustituir línea completa" })

		-- Sustituye desde el cursor hasta el final de la línea
		keymap.set("n", "S", substitute.eol, { desc = "Sustituir hasta el final de la línea" })

		-- Sustituye el texto seleccionado en modo visual
		keymap.set("x", "s", substitute.visual, { desc = "Sustituir en modo visual" })
	end,
}
