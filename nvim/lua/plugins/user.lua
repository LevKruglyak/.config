---@type LazySpec
return {

  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000
  },

  {
    "ellisonleao/gruvbox.nvim",
    name = "gruvbox",
    priority = 1000,
    opts = {
      terminal_colors = true,
      undercurl = true,
      underline = true,
      bold = true,
      italic = {
        strings = true,
        emphasis = true,
        comments = true,
        operators = false,
        folds = true,
      },
      strikethrough = true,
      invert_selection = true,
      invert_signs = false,
      invert_tabline = false,
      invert_intend_guides = false,
      inverse = true,
      contrast = "",
      palette_overrides = {},
      dim_inactive = false,
      transparent_mode = false,
    }
  },

  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      opts.ui = opts.ui or {}
      opts.ui.border = "rounded"
      opts.ui.width = 0.8
      opts.ui.height = 0.8
    end,
  },

  -- {
  --   "ewis6991/gitsigns.nvim",
  --   opts = {
  --     signs = {
  --       add          = { text = '+' },
  --       change       = { text = '*' },
  --       delete       = { text = 'x' },
  --       topdelete    = { text = 'x' },
  --       changedelete = { text = 'x' },
  --       untracked    = { text = 'u' },
  --     },
  --   }
  -- },

  {
      "nvim-telescope/telescope.nvim",
      opts = function(_, opts)
        opts.defaults = opts.defaults or {}

        -- Set the border with no characters and highlight the background
        opts.defaults.borderchars = { ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ' }  -- No characters for the border
        opts.defaults.winblend = 0  -- Ensure the background is not transparent
        opts.defaults.layout_strategy = 'horizontal'
      end,
    },

  {
    "L3MON4D3/LuaSnip",
    config = function(plugin, opts)
      require "astronvim.plugins.configs.luasnip"(plugin, opts) -- include the default astronvim config that calls the setup call
      -- add more custom luasnip configuration such as filetype extend or custom snippets
      local luasnip = require "luasnip"
      -- luasnip.filetype_extend("javascript", { "javascriptreact" })
    end,
  },

  { "rcarriga/nvim-notify", enabled = false },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "lua",
        "vim",
        "rust",
        "c",
        "cpp",
        "toml",
        "python",
      },
    },
  },

  {
    "rebelot/heirline.nvim",
    opts = function(_, opts)
      local status = require("astroui.status")

      opts.statusline = {
        hl = { fg = "fg", bg = "bg" },
        status.component.mode(),
        status.component.git_branch({
            hl = { fg = "#8dc07c" },
        }),
        status.component.file_info(),
        status.component.git_diff(),
        status.component.diagnostics(),
        status.component.fill(),
        status.component.cmd_info(),
        status.component.fill(),
        status.component.lsp({
            padding = { right = 1 },
        }),
      }

      opts.tabline = nil

      opts.winbar = {
        status.heirline.make_buflist(status.component.tabline_file_info()), -- component for each buffer tab
        status.component.fill({ hl = { bg = "tabline_bg" } }), -- fill the rest of the tabline with background color
        { -- tab list
          condition = function()
            return #vim.api.nvim_list_tabpages() >= 2
          end, -- only show tabs if there are more than one
          status.heirline.make_tablist({ -- component for each tab
            provider = status.provider.tabnr(),
            hl = function(self)
              return status.hl.get_attributes(
                status.heirline.tab_type(self, "tab"),
                true
              )
            end,
          }),
          { -- close button for current tab
            provider = status.provider.close_button({
              kind = "TabClose",
              padding = { left = 1, right = 1 },
            }),
            hl = status.hl.get_attributes("tab_close", true),
            on_click = {
              callback = function()
                require("astrocore.buffer").close_tab()
              end,
              name = "heirline_tabline_close_tab_callback",
            },
          },
        },
      }
    end,
  },

  {
    "lervag/vimtex",
    lazy = true,
    dependencies = {
      "AstroNvim/astrocore",
      opts = {
        autocmds = {
          vimtex_mapping_descriptions = {
            {
              event = "FileType",
              desc = "Set up VimTex Which-Key descriptions",
              pattern = "tex",
              callback = function(event)
                local wk_avail, wk = pcall(require, "which-key")
                if not wk_avail then return end
                local opts = {
                  mode = "n", -- NORMAL mode
                  buffer = event.buf, -- Specify a buffer number for buffer local mappings to show only in tex buffers
                }
                local mappings = {
                  ["<localleader>l"] = {
                    name = "+VimTeX",
                    a = "Show Context Menu",
                    C = "Full Clean",
                    c = "Clean",
                    e = "Show Errors",
                    G = "Show Status for All",
                    g = "Show Status",
                    i = "Show Info",
                    I = "Show Full Info",
                    k = "Stop VimTeX",
                    K = "Stop All VimTeX",
                    L = "Compile Selection",
                    l = "Compile",
                    m = "Show Imaps",
                    o = "Show Compiler Output",
                    q = "Show VimTeX Log",
                    s = "Toggle Main",
                    t = "Open Table of Contents",
                    T = "Toggle Table of Contents",
                    v = "View Compiled Document",
                    X = "Reload VimTeX State",
                    x = "Reload VimTeX",
                  },
                  ["ts"] = {
                    name = "VimTeX Toggles & Cycles", -- optional group name
                    ["$"] = "Cycle inline, display & numbered equation",
                    c = "Toggle star of command",
                    d = "Cycle (), \\left(\\right) [,...]",
                    D = "Reverse Cycle (), \\left(\\right) [, ...]",
                    e = "Toggle star of environment",
                    f = "Toggle a/b vs \\frac{a}{b}",
                  },
                  ["[/"] = "Previous start of a LaTeX comment",
                  ["[*"] = "Previous end of a LaTeX comment",
                  ["[["] = "Previous beginning of a section",
                  ["[]"] = "Previous end of a section",
                  ["[m"] = "Previous \\begin",
                  ["[M"] = "Previous \\end",
                  ["[n"] = "Previous start of a math zone",
                  ["[N"] = "Previous end of a math zone",
                  ["[r"] = "Previous \\begin{frame}",
                  ["[R"] = "Previous \\end{frame}",
                  ["]/"] = "Next start of a LaTeX comment %",
                  ["]*"] = "Next end of a LaTeX comment %",
                  ["]["] = "Next beginning of a section",
                  ["]]"] = "Next end of a section",
                  ["]m"] = "Next \\begin",
                  ["]M"] = "Next \\end",
                  ["]n"] = "Next start of a math zone",
                  ["]N"] = "Next end of a math zone",
                  ["]r"] = "Next \\begin{frame}",
                  ["]R"] = "Next \\end{frame}",
                  ["cs"] = {
                    c = "Change surrounding command",
                    e = "Change surrounding environment",
                    ["$"] = "Change surrounding math zone",
                    d = "Change surrounding delimiter",
                  },
                  ["ds"] = {
                    c = "Delete surrounding command",
                    e = "Delete surrounding environment",
                    ["$"] = "Delete surrounding math zone",
                    d = "Delete surrounding delimiter",
                  },
                }
                wk.register(mappings, opts)
                -- VimTeX Text Objects without variants with targets.vim
                opts = {
                  mode = "o", -- Operator pending mode
                  buffer = event.buf,
                }
                local objects = {
                  ["ic"] = [[LaTeX Command]],
                  ["ac"] = [[LaTeX Command]],
                  ["id"] = [[LaTeX Math Delimiter]],
                  ["ad"] = [[LaTeX Math Delimiter]],
                  ["ie"] = [[LaTeX Environment]],
                  ["ae"] = [[LaTeX Environment]],
                  ["i$"] = [[LaTeX Math Zone]],
                  ["a$"] = [[LaTeX Math Zone]],
                  ["iP"] = [[LaTeX Section, Paragraph, ...]],
                  ["aP"] = [[LaTeX Section, Paragraph, ...]],
                  ["im"] = [[LaTeX Item]],
                  ["am"] = [[LaTeX Item]],
                }
                wk.register(objects, opts)
              end,
            },
          },
        },
      },
    },
  }
}
