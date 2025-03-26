---@type LazySpec
return {
  "AstroNvim/astroui",
  ---@type AstroUIOpts
  opts = {
    colorscheme = "catppuccin-frappe",

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

        TabLineFill = { bg = "#3c3836" },
        TabLineSel = { bg = "#3c3836" },

        TelescopeBorder = { bg = "#504945" },
        TelescopeResultsBorder = { bg = "#504945" },
        TelescopePromptBorder = { bg = "#504945" },
        TelescopePreviewBorder = { bg = "#504945" },

        WinBar = { bg = "#3c3836" },
        WinBarNC = { bg = "#3c3836", fg = "#3c3836" },

        NeoTreeTabInactive = { bg = "#3c3836", fg = "#938374" },
        NeoTreeTabActive = {},
        NeoTreeTabSeparatorInactive = { bg = "#3c3836", fg = "#3c3836" },
        NeoTreeTabSeparatorActive = { bg = "bg", fg = "bg" },
      }
    },
  },
}
