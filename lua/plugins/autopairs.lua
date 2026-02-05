-- Plugin: nvim-autopairs
-- Funcionalidad: Cierra automáticamente pares de (), {}, [], "", '', etc., cuando escribes en modo insert.
-- También se integra con nvim-cmp para añadir el par cuando se autocompleta algo (por ejemplo: función()).

return {
  "windwp/nvim-autopairs",
  event = "InsertEnter", -- Se carga cuando entras en modo Insert
  config = function()
    -- Cargar el módulo del plugin
    local autopairs = require("nvim-autopairs")

    -- Configuración básica del plugin
    autopairs.setup({
      check_ts = true, -- Usa Tree-sitter para no insertar pares en lugares inválidos según el lenguaje
      fast_wrap = {},  -- Habilita el uso de una combinación de teclas para envolver texto rápidamente (ver abajo)
      disable_filetype = { "TelescopePrompt", "vim" }, -- Desactiva autopairs en estos tipos de archivos
    })

    ------------------------------------------------------------------------
    -- 🔄 Integración con nvim-cmp (autocompletado)
    -- Permite insertar automáticamente () cuando aceptas una función, por ejemplo:
    -- Al completar `print`, se insertará `print()` automáticamente.
    ------------------------------------------------------------------------
    local cmp_status, cmp = pcall(require, "cmp")
    if cmp_status then
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end
  end,
}
