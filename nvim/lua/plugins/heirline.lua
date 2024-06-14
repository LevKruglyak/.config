return {
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

    opts.winbar = {
      init = function(self)
        self.bufnr = vim.api.nvim_get_current_buf()
      end,
      fallthrough = false,
      {
        status.component.breadcrumbs({
          hl = status.hl.get_attributes("winbar", true),
        }),
        status.component.fill({
          hl = { bg = "bg" }
        })
      },
    }
  end,
}
