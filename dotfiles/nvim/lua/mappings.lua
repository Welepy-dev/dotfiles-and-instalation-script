require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- keymap("n", "<C-Left>", "<cmd>TmuxNavigateLeft<CR>", opts)
-- keymap("i", "<C-Left>", "<Esc><cmd>TmuxNavigateLeft<CR>", opts)
--
-- keymap("n", "<C-Right>", "<cmd>TmuxNavigateRight<CR>", opts)
-- keymap("i", "<C-Right>", "<Esc><cmd>TmuxNavigateRight<CR>", opts)
--
-- keymap("n", "<C-Up>", "<cmd>TmuxNavigateUp<CR>", opts)
-- keymap("i", "<C-Up>", "<Esc><cmd>TmuxNavigateUp<CR>", opts)
--
-- keymap("n", "<C-Down>", "<cmd>TmuxNavigateDown<CR>", opts)
-- keymap("i", "<C-Down>", "<Esc><cmd>TmuxNavigateDown<CR>", opts)

-- Salvar, sair
keymap("n", "<leader>w", ":w<CR>", opts)
keymap("n", "<leader>q", ":q<CR>", opts)
keymap("n", "<leader>Q", ":wq<CR>", opts)

-- Alternar número de linhas com F3
keymap("n", "<F3>", ":set nu!<CR>", opts)

-- Pesquisa
keymap("n", "<space>", "/", opts)
keymap("n", "<C-space>", "?", opts)
keymap("n", "<leader><CR>", ":noh<CR>", { silent = true })

-- Navegação entre janelas
keymap("n", "<C-j>", "<C-W>j", opts)
keymap("n", "<C-k>", "<C-W>k", opts)
keymap("n", "<C-h>", "<C-W>h", opts)
keymap("n", "<C-l>", "<C-W>l", opts)

-- Copilot (F5 para desativar)
keymap("n", "<F5>", ":Copilot disable<CR>", opts)

-- Redo
keymap("n", "<C-R>", ":redo<CR>", opts)

-- Mover blocos visualmente com Alt+Up/Down
keymap("v", "<A-Up>", ":m '<-2<CR>gv=gv", opts)
keymap("v", "<A-Down>", ":m '>+1<CR>gv=gv", opts)

-- Clipboard yank
keymap("n", "<leader>y", '"+y', opts)
keymap("n", "<leader>Y", '"+Y', opts)
keymap("v", "<leader>Y", '"+Y', opts)

keymap("n", "<leader>ff", "<cmd>Telescope find_files<cr>", opts)
keymap("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", opts)
keymap("n", "<leader>fb", "<cmd>Telescope buffers<cr>", opts)
keymap("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", opts)
keymap("n", "<leader>fo", "<cmd>Telescope oldfiles<cr>", opts)
keymap("n", "<leader>fc", "<cmd>Telescope commands<cr>", opts)


-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
