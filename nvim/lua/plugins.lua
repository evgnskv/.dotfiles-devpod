local github = function(repo)
  return "https://github.com/" .. repo
end

vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(args)
    local data = args.data
    if data.spec.name ~= "nvim-treesitter" then
      return
    end
    if data.kind ~= "install" and data.kind ~= "update" then
      return
    end
    if not data.active then
      vim.cmd.packadd("nvim-treesitter")
    end
    vim.cmd("TSUpdate")
  end,
})

vim.pack.add({
  github("nvim-lua/plenary.nvim"),
  github("nvim-tree/nvim-web-devicons"),
  github("MunifTanjim/nui.nvim"),
  { src = github("nvim-treesitter/nvim-treesitter"), version = "main" },
  github("hrsh7th/cmp-nvim-lsp"),
  github("hrsh7th/nvim-cmp"),
  github("mason-org/mason.nvim"),
  github("neovim/nvim-lspconfig"),
  github("mason-org/mason-lspconfig.nvim"),
  github("nvim-lualine/lualine.nvim"),
  github("nvim-neo-tree/neo-tree.nvim"),
  github("MeanderingProgrammer/render-markdown.nvim"),
  github("craftzdog/solarized-osaka.nvim"),
  { src = github("nvim-telescope/telescope.nvim"), version = "0.1.8" },
}, { confirm = false, load = true })

vim.o.termguicolors = true
require("solarized-osaka").setup({})
vim.cmd.colorscheme("solarized-osaka")

local cmp = require("cmp")
cmp.setup({
  snippet = {
    expand = function(args)
      vim.snippet.expand(args.body)
    end,
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.abort(),
    ["<CR>"] = cmp.mapping.confirm({ select = false }),
  }),
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
  }),
})

require("mason").setup({})
vim.lsp.config("*", {
  capabilities = require("cmp_nvim_lsp").default_capabilities(),
})
require("mason-lspconfig").setup({
  automatic_enable = true,
})

require("lualine").setup({})

require("neo-tree").setup({
  filesystem = {
    filtered_items = {
      visible = false,
      show_hidden_count = true,
      hide_dotfiles = false,
      hide_gitignored = false,
    },
  },
})

local function find_buffer_by_filetype(filetype)
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.bo[buf].filetype == filetype then
      return buf
    end
  end
end

vim.keymap.set("n", "<leader>e", function()
  if find_buffer_by_filetype("neo-tree") then
    require("neo-tree.command").execute({ action = "close" })
  else
    require("neo-tree.command").execute({
      action = "focus",
      reveal = true,
      dir = vim.uv.cwd(),
    })
  end
end, { desc = "Toggle Explorer (cwd)" })

require("render-markdown").setup({})

require("telescope").setup({})
local telescope = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", telescope.find_files, { desc = "Telescope find files" })
vim.keymap.set("n", "<leader>fg", telescope.live_grep, { desc = "Telescope live grep" })
vim.keymap.set("n", "<leader>fb", telescope.buffers, { desc = "Telescope buffers" })
vim.keymap.set("n", "<leader>fh", telescope.help_tags, { desc = "Telescope help tags" })

vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, { desc = "Format buffer" })

local treesitter = require("nvim-treesitter")
local available_parsers = {}
for _, language in ipairs(treesitter.get_available()) do
  available_parsers[language] = true
end

local function activate_treesitter(buf, language)
  local ok, err = pcall(vim.treesitter.start, buf, language)
  if not ok then
    vim.notify("Failed to start Treesitter for " .. language .. ": " .. tostring(err), vim.log.levels.ERROR)
    return
  end
  vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
end

local function start_treesitter(args)
  local filetype = vim.bo[args.buf].filetype
  local language = vim.treesitter.language.get_lang(filetype) or filetype
  local ok, parser = pcall(vim.treesitter.get_parser, args.buf, language)
  if ok and parser then
    activate_treesitter(args.buf, language)
    return
  end
  if not available_parsers[language] then
    return
  end

  treesitter.install({ language }):await(function(err, installed)
    if err or not installed then
      vim.schedule(function()
        vim.notify(
          "Failed to install Treesitter parser for " .. language .. ": " .. tostring(err or "unknown error"),
          vim.log.levels.ERROR
        )
      end)
      return
    end
    vim.schedule(function()
      if vim.api.nvim_buf_is_valid(args.buf) then
        activate_treesitter(args.buf, language)
      end
    end)
  end)
end

vim.api.nvim_create_autocmd("FileType", {
  callback = start_treesitter,
})
