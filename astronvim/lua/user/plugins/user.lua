return {
  -- You can also add new plugins here as well:
  -- Add plugins, the lazy syntax
  -- "andweeb/presence.nvim",
  -- {
  --   "ray-x/lsp_signature.nvim",
  --   event = "BufRead",
  --   config = function()
  --     require("lsp_signature").setup()
  --   end,
  -- },
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
  {
    "lervag/vimtex",
    lazy = false,
    init = function()
      vim.g.tex_flavor = 'latex'
      vim.g.vimtex_view_method = 'skim'
      vim.g.vimtex_view_skim_sync = 1
      vim.g.vimtex_view_skim_activate = 1
      vim.g.vimtex_compiler_latexmk = {
          options = {
              '-file-line-error',
              '-synctex=1',
              '-interaction=nonstopmode',
              '-pdf',
              '-shell-escape',
          },
      }
    end,
  }
}
