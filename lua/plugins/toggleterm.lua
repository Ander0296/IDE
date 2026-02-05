-- Plugin: toggleterm.nvim
-- Funcionalidad: Abre terminales integradas dentro de Neovim con estilos flotantes, divididos o en pestañas.
-- Ideal para ejecutar comandos, servidores, Git, compilaciones, etc., sin salir del editor.

return {
	"akinsho/toggleterm.nvim",
	version = "*", -- Usa la última versión disponible del plugin

	config = function()
		require("toggleterm").setup({
			-- Mapeo para abrir/cerrar la terminal (Ctrl + \)
			open_mapping = [[<C-\>]],

			-- Dirección de la terminal (float, horizontal, vertical, tab)
			direction = "float", -- Muestra la terminal como ventana flotante

			-- Opciones de estilo para terminal flotante
			float_opts = {
				border = "rounded", -- Borde redondeado para estética moderna
			},

			-- Sombrea la ventana de fondo mientras la terminal está activa
			shade_terminals = true,

			-- Inicia la terminal directamente en modo insert
			start_in_insert = true,

			-- Permite usar los mismos mapeos en modo insert
			insert_mappings = true,

			-- Mantiene el tamaño de la terminal entre aperturas
			persist_size = true,
		})
	end,
}
