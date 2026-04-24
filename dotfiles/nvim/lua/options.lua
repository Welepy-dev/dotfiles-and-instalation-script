require "nvchad.options"

-- add yours here!

-- local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!

vim.opt.expandtab = false       -- usa tabs, não espaços
vim.opt.tabstop = 4             -- número de espaços por tab
vim.opt.shiftwidth = 4          -- espaços por indentação automática
vim.opt.number = true           -- mostra número de linhas
vim.opt.relativenumber = true   -- número relativo
vim.opt.mouse = "a"             -- ativa o rato
vim.opt.encoding = "utf-8"      -- codificação
vim.opt.hlsearch = true         -- realça resultados da pesquisa
vim.opt.incsearch = true        -- pesquisa incremental
vim.opt.scrolloff = 6           -- contexto acima/abaixo do cursor
vim.opt.softtabstop = 0
vim.opt.wrap = false

-- Cursor shape and blinking behavior
vim.opt.guicursor = {
  "n-v-c:block",          -- Normal, Visual, Command: block cursor
  "i-ci-ve:ver25",        -- Insert, Command-line insert, Visual-exclude: vertical bar cursor (25% width)
  "r-cr:hor20",           -- Replace modes: horizontal bar cursor (20% height)
  "o:hor50",              -- Operator-pending: thicker horizontal bar
  "a:blinkwait700-blinkon400-blinkoff250", -- global blinking settings
}
