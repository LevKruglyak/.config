-- AstroUI provides the basis for configuring the AstroNvim User Interface
-- Configuration documentation can be found with `:h astroui`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

---@type LazySpec
return {
  "AstroNvim/astroui",
  ---@type AstroUIOpts
  opts = {
    -- change colorscheme
    colorscheme = "gruvbox",

    highlights = {
      init = {
        SignColumn = { bg = "background" },
        FoldColumn = { bg = "background" },
        NormalFloat = { bg = "background" },
      },
      gruvbox = {
        CursorLineSign = { bg = "#3c3836" },
        CursorLineFold = { bg = "#3c3836" },
        StatusLine = { bg = "#3c3836" },
        WinSeparator = { bg = "#3c3836", fg = "#3c3836" },
        FloatBorder = { bg = "NONE", fg = "#ebdbb2" }
      }
    },
  },
}
