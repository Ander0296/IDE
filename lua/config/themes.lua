local M = {}

-- Tu lista de esquemas disponibles
M.colorschemes = {
	kanagawa = "kanagawa",
	everforest = "everforest",
	gruvbox = "gruvbox",
	nord = "nord",
	catppuccin = "catppuccin",
	rosepine = "rose-pine",
	githubtheme = "github-theme",
}

-- Ruta donde se guarda el esquema elegido
local scheme_path = vim.fn.stdpath("config") .. "/colorscheme.txt"

-- Función para aplicar y guardar el colorscheme
function M.set(name)
	local ok = pcall(vim.cmd.colorscheme, name)
	if ok then
		vim.g.colors_name = name
		vim.notify("🎨 Colorescheme activo: " .. name)

		-- Guardar en archivo
		local f = io.open(scheme_path, "w")
		if f then
			f:write(name)
			f:close()
		end
	else
		vim.notify("❌ No se pudo aplicar: " .. name, vim.log.levels.ERROR)
	end
end

-- Función para elegir desde el UI
function M.pick()
	local keys = vim.tbl_keys(M.colorschemes)
	vim.ui.select(keys, { prompt = "Selecciona un esquema:" }, function(choice)
		if choice then
			M.set(M.colorschemes[choice])
		end
	end)
end

-- Comando para llamar con :Colores
vim.api.nvim_create_user_command("Colores", function()
	M.pick()
end, {})

-- Leer el archivo al iniciar y aplicar el scheme
function M.load_saved()
	local f = io.open(scheme_path, "r")
	if f then
		local name = f:read("*l")
		f:close()
		if name then
			M.set(name)
		end
	end
end

-- Cargar automáticamente el guardado al iniciar
vim.defer_fn(function()
	M.load_saved()
end, 20)

return M
