local lazy = {}

function lazy.install(path)
  if not vim.loop.fs_stat(path) then
    print('Installing lazy.nvim....')
    vim.fn.system({
      'git',
      'clone',
      '--filter=blob:none',
      'https://github.com/folke/lazy.nvim.git',
      '--branch=stable', -- latest stable release
      path,
    })
  end
end

function lazy.setup(plugins)
  if vim.g.plugins_ready then
    return
  end

  -- You can "comment out" the line below after lazy.nvim is installed
  lazy.install(lazy.path)

  vim.opt.rtp:prepend(lazy.path)

  require('lazy').setup(plugins, lazy.opts)
  vim.g.plugins_ready = true
end

lazy.path = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
lazy.opts = {}

lazy.setup({
  "catppuccin/nvim", 
  "junegunn/goyo.vim",
  "junegunn/limelight.vim"
})

vim.opt.termguicolors = true
vim.cmd.colorscheme('catppuccin-mocha')

local function goyo_enter()
  -- if vim.fn.executable('tmux') == 1 and vim.fn.strlen(vim.env.TMUX) ~= 0 then
  --   vim.fn.system('tmux set status off')
  --   if vim.fn.system('tmux list-panes -F \'#F\' | grep -q Z') ~= 0 then
  --     vim.fn.system('tmux resize-pane -Z')
  --   end
  -- end
  vim.cmd([[set noshowmode]])
  vim.cmd([[set noshowcmd]])
  vim.cmd([[set scrolloff=999]])
  vim.cmd([[Limelight]])
  -- ...
end

local function goyo_leave()
  -- if vim.fn.executable('tmux') == 1 and vim.fn.strlen(vim.env.TMUX) ~= 0 then
  --   vim.fn.system('tmux set status on')
  --   if vim.fn.system('tmux list-panes -F \'#F\' | grep -q Z') == 0 then
  --     vim.fn.system('tmux resize-pane -Z')
  --   end
  -- end
  vim.cmd([[set showmode]])
  vim.cmd([[set showcmd]])
  vim.cmd([[set scrolloff=5]])
  vim.cmd([[Limelight!]])
  vim.cmd('quit')
  -- ...
end

-- Autocommands
vim.api.nvim_create_autocmd("User", {
  pattern = "GoyoEnter",
  nested = true,
  callback = goyo_enter,
})

vim.api.nvim_create_autocmd("User", {
  pattern = "GoyoLeave",
  nested = true,
  callback = goyo_leave,
})

vim.api.nvim_create_autocmd("VimEnter", {
  pattern = "*",
  callback = function()
    vim.cmd("Goyo")
  end,
})

-- init.lua file for Neovim
local function format_and_keep_cursor()
    local save = vim.fn.winsaveview() -- Save cursor position and view state
    vim.cmd('normal gggqG') -- Format the document
    vim.fn.winrestview(save) -- Restore cursor position and view state
end

-- Set the autocmd for BufWritePre event
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    callback = format_and_keep_cursor,
})
vim.opt.textwidth = 75

-- Basic settings
vim.opt.number = true             -- Enable line numbers
vim.opt.relativenumber = true     -- Enable relative line numbers
vim.opt.mouse = 'a'               -- Enable mouse support
vim.opt.clipboard = 'unnamedplus' -- Use system clipboard
vim.opt.tabstop = 4               -- Number of spaces tabs count for
vim.opt.shiftwidth = 4            -- Size of an indent
vim.opt.expandtab = true          -- Use spaces instead of tabs
vim.opt.smartindent = true        -- Autoindent new lines
vim.opt.wrap = true -- Disable line wrap

-- Set highlight on search
vim.opt.hlsearch = true

-- Make line numbers default
vim.opt.number = true

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case insensitive searching UNLESS /C or capital in search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Decrease update time
vim.opt.updatetime = 250
vim.wo.signcolumn = 'yes'

-- Set completeopt to have a better completion experience
vim.opt.completeopt = 'menuone,noselect'

-- Set colorscheme (you can change this to whatever you prefer)
vim.cmd 'filetype plugin on'
vim.cmd 'syntax on'             -- Enable syntax highlighting
