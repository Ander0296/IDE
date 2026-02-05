-- Plugin: lualine.nvim
-- Funcionalidad: Barra de estado moderna y personalizable para Neovim.
-- Muestra información útil como nombre del archivo, modo de edición, rama de Git, errores del LSP, etc.

-- Función que muestra "REC @x" si estás grabando una macro
local function recording_status()
	local reg = vim.fn.reg_recording()
	if reg == "" then
		return ""
	else
		return "REC @" .. reg
	end
end

return {
	"nvim-lualine/lualine.nvim",

	-- Dependencias requeridas para iconos en la barra
	dependencies = { "nvim-tree/nvim-web-devicons" },

	-- Configuración del plugin
	opts = {
		options = {
			globalstatus = true, -- Usa una única barra de estado para toda la ventana (recomendado en Neovim 0.7+)
		},

		sections = {
			-- Sección central (C) de la barra activa
			lualine_c = {
				{
					"filename", -- Muestra el nombre del archivo actual
					file_status = true, -- Muestra indicador [+] si fue modificado
					path = 1, -- Muestra la ruta relativa del archivo
				},
				recording_status, -- Muestra si estás grabando una macro
			},
		},

		-- Configuración para ventanas inactivas (opcional pero útil)
		inactive_winbar = {
			lualine_c = { "filename" }, -- Muestra solo el nombre del archivo en ventanas inactivas
		},
	},
}
