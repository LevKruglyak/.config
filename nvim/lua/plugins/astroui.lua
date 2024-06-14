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
        CursorLine = { bg = "#3c3836" },
        CursorLineSign = { bg = "bg" },
        CursorLineNR = { bg = "bg" },
        CursorLineFold = { bg = "bg" },
        StatusLine = { bg = "bg" },
        WinSeparator = { bg = "#504945", fg = "#504945" },
        FloatBorder = { bg = "#504945", fg = "#504945" },
        TabLineFill = { bg = "#504945" },
        TabLineSel = { bg = "#504945" },
        TelescopeBorder = { bg = "#504945" },
        TelescopeResultsBorder = { bg = "#504945" },
        TelescopePromptBorder = { bg = "#504945" },
        TelescopePreviewBorder = { bg = "#504945" },
      }
    },
  },
}
