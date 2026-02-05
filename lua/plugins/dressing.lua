
-- Plugin: dressing.nvim
-- Mejora las ventanas flotantes de Neovim para entradas de usuario (input/select),
-- haciéndolas más estéticas y funcionales. Se integra con otros plugins como Telescope.

return {
  "stevearc/dressing.nvim",
  event = "VeryLazy", -- Se carga solo cuando se necesita (input o select)
  config = function()
    require("dressing").setup({

      -- Configuración para vim.ui.input (cuadro de entrada de texto)
      input = {
        enabled = true,              -- Habilita el input mejorado
        default_prompt = "➤ ",       -- Símbolo que aparece antes del texto
        title_pos = "center",        -- Título centrado en la ventana flotante
        insert_only = true,          -- Solo permite escribir en modo insert
        win_options = {
          winblend = 0,              -- Nivel de transparencia (0 = opaco)
          winhighlight = "NormalFloat:Normal,FloatBorder:FloatBorder", -- Estilo de borde y fondo
        },
      },

      -- Configuración para vim.ui.select (cuadro para elegir opciones)
      select = {
        enabled = true,                    -- Habilita el selector mejorado
        backend = { "telescope", "builtin" }, -- Usa Telescope si está disponible, si no, usa el integrado
        builtin = {
          anchor = "NW",                   -- Posición de la ventana (Noroeste del cursor)
          relative = "cursor",            -- Se posiciona relativo al cursor
          win_options = {
            winblend = 0,
            winhighlight = "NormalFloat:Normal,FloatBorder:FloatBorder",
          },
        },
      },
    })
  end,
}
