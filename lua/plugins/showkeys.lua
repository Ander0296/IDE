return {
	"nvzone/showkeys",
	lazy = false, -- lo cargamos al inicio para poder auto-activarlo
	cmd = "ShowkeysToggle",

	keys = {
		{ "<leader>ks", "<cmd>ShowkeysToggle<cr>", desc = "Mostrar teclas (Showkeys)" },
	},

	opts = {
		timeout = 100,
		maxkeys = 5,
		position = "bottom-center",
		winopts = { height = 1 },
	},

	config = function(_, opts)
		local showkeys = require("showkeys")
		showkeys.setup(opts)

		-- -----------------------------
		-- Auto ON al entrar a Neovim
		-- -----------------------------
		vim.api.nvim_create_autocmd("VimEnter", {
			callback = function()
				pcall(vim.cmd, "ShowkeysToggle") -- lo enciende al inicio
			end,
		})

		-- -----------------------------
		-- Auto OFF tras 5s sin actividad
		-- -----------------------------
		local timer = vim.loop.new_timer()
		local HIDE_AFTER = 5000 -- ms
		local enabled = true -- asumimos que al iniciar lo encendemos

		local function stop_timer()
			if timer and not timer:is_closing() then
				timer:stop()
			end
		end

		local function schedule_hide()
			stop_timer()
			timer:start(
				HIDE_AFTER,
				0,
				vim.schedule_wrap(function()
					if enabled then
						enabled = false
						pcall(vim.cmd, "ShowkeysToggle") -- apaga
					end
				end)
			)
		end

		-- Cada “actividad” reinicia el timer y (si estaba apagado) lo vuelve a encender
		local function on_activity()
			if not enabled then
				enabled = true
				pcall(vim.cmd, "ShowkeysToggle") -- enciende cuando vuelves a teclear
			end
			schedule_hide()
		end

		vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI", "InsertCharPre", "CmdlineChanged" }, {
			callback = on_activity,
		})

		-- Si tú lo toggleaseas manualmente con <leader>sk, mantenemos el estado coherente
		vim.keymap.set("n", "<leader>sk", function()
			enabled = not enabled
			pcall(vim.cmd, "ShowkeysToggle")
			if enabled then
				schedule_hide()
			else
				stop_timer()
			end
		end, { desc = "Mostrar teclas (Showkeys)" })
	end,
}
