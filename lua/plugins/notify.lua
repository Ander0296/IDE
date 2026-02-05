return {
	"rcarriga/nvim-notify",
	lazy = false, -- Se carga de inmediato para reemplazar vim.notify desde el inicio
	priority = 1000, -- Alta prioridad para integrarse con Snacks, LSP, Lazy, etc.
	config = function()
		-- Establece nvim-notify como la función predeterminada para notificaciones
		vim.notify = require("notify")

		require("notify").setup({
			stages = "fade_in_slide_out", -- Animación suave
			timeout = 5000, -- Tiempo visible de la notificación (ms)
			fps = 60, -- Fotogramas por segundo (fluidez)
			background_colour = "#000000", -- Fondo (ajústalo a tu colorscheme actual)
		})
	end,
	desc = "Notificaciones flotantes estéticas para reemplazar vim.notify",
}
