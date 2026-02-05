-- Muestra en pantalla las combinaciones de teclas presionadas en tiempo real.
-- Ideal para practicar, grabar o depurar tus atajos de Neovim.
return {
	"nvzone/showkeys",
	lazy = false, -- cargar al inicio
	cmd = "ShowkeysToggle",
	keys = {
		{
			"<leader>ks",
			"<cmd>ShowkeysToggle<cr>",
			desc = "Mostrar teclas presionadas (Showkeys)",
		},
	},
	opts = {
		timeout = 100, -- tiempo de espera para mostrar la combinación
		maxkeys = 4,
		position = "bottom-center", -- posición del recuadro
		winopts = {
			height = 1, -- altura del recuadro flotante
		},
	},
	config = function()
		require("showkeys").setup({
			timeout = 100,
			maxkeys = 5,
			position = "bottom-center",
			winopts = {
				height = 1,
			},
		})
		vim.cmd("ShowkeysToggle") -- activarlo automáticamente
	end,
}
