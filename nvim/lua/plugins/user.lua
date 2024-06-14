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
    "rebelot/heirline.nvim",
    opts = function(_, opts)
      local status = require("astroui.status")
-- local component = {
--   provider = status.provider.mode_text({ padding = { left = 1, right = 1 } }),
-- }

      opts.statusline = { -- statusline
        hl = { fg = "fg", bg = "bg" },
        {
          provider = function()
            return vim.fn.getcwd()
          end,
          hl = { fg = "fg", bg = "bg" },
          padding = { left = 1, right = 1 },
        },
        status.component.git_branch({
            hl = { fg = "#8dc07c" },
            padding = { left = 1 },
        }),
        status.component.git_diff(),
        status.component.fill(),
        status.component.cmd_info(),
        status.component.fill(),
        status.component.diagnostics(),
        status.component.lsp(),
        status.component.virtual_env(),
        status.component.file_info(),
      }

      opts.winbar = { -- winbar
        init = function(self)
          self.bufnr = vim.api.nvim_get_current_buf()
        end,
        fallthrough = false,
        { -- inactive winbar
          condition = function()
            return not status.condition.is_active()
          end,
          status.component.separated_path(),
          status.component.file_info({
            file_icon = {
              hl = status.hl.file_icon("winbar"),
              padding = { left = 0 },
            },
            filename = {},
            filetype = false,
            file_read_only = false,
            hl = status.hl.get_attributes("winbarnc", true),
            surround = false,
            update = "BufEnter",
          }),
        },
        { -- active winbar
          status.component.breadcrumbs({
            hl = status.hl.get_attributes("winbar", true),
          }),
        },
      }

      opts.tabline = { -- tabline
        { -- file tree padding
          condition = function(self)
            self.winid = vim.api.nvim_tabpage_list_wins(0)[1]
            self.winwidth = vim.api.nvim_win_get_width(self.winid)
            return self.winwidth ~= vim.o.columns -- only apply to sidebars
              and not require("astrocore.buffer").is_valid(
                vim.api.nvim_win_get_buf(self.winid)
              ) -- if buffer is not in tabline
          end,
          provider = function(self)
            return (" "):rep(self.winwidth + 1)
          end,
          hl = { bg = "tabline_bg" },
        },
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

      opts.statuscolumn = { -- statuscolumn
        init = function(self)
          self.bufnr = vim.api.nvim_get_current_buf()
        end,
        status.component.foldcolumn(),
        status.component.numbercolumn(),
        status.component.signcolumn(),
      }
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
    "lervag/vimtex",
    lazy = false,
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
