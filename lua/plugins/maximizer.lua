-- Plugin: vim-maximizer
-- Funcionalidad: Permite maximizar una ventana dividida (split) de Neovim y luego restaurarla.
-- Muy útil para trabajar en un archivo a pantalla completa sin cerrar otras ventanas.

return {
	"szw/vim-maximizer",

	-- Atajos personalizados para usar el plugin
	keys = {
		{
			"<leader>wm", -- Al presionar <leader>sm...
			"<cmd>MaximizerToggle<CR>", -- ...se activa o desactiva la maximización de la ventana actual
			desc = "Maximizar/restaurar división",
		},
	},
}
