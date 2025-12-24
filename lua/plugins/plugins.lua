return {
  {
    "folke/snacks.nvim",
    opts = {
      image = {
        enabled = true,
        -- optional tweaks:
        -- doc = { inline = true, float = true },
      },
    },
  },
  { "ThePrimeagen/vim-be-good" },
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    config = function()
      require("persistence").setup({
        dir = vim.fn.stdpath("data") .. "/sessions/",
        options = { "buffers", "curdir", "tabpages", "winsize" },
      })
    end,
  },
  {
    "nvim-tree/nvim-tree.lua", -- Add this to ensure nvim-tree is loaded
    opts = {
      filters = {
        dotfiles = false, -- Show dotfiles like .gitignore
        git_ignored = false, -- Show git-ignored files like .env
      },
    },
    config = function()
      require("nvim-tree").setup()
    end,
  },
  {
    "akinsho/toggleterm.nvim",
    config = function()
      require("toggleterm").setup({
        size = 20,
        shading_factor = 2, -- Ensure this is a valid number
        open_mapping = [[<c-t>]],
        hide_numbers = true,
        shade_filetypes = {},
        shade_terminals = true,
        start_in_insert = true,
        insert_mappings = true,
        persist_size = true,
        direction = "horizontal",
        close_on_exit = true,
        shell = vim.o.shell,
      })
    end,
  },
  {
    "akinsho/flutter-tools.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "stevearc/dressing.nvim",
      "neovim/nvim-lspconfig",
    },
    config = function()
      require("flutter-tools").setup({
        debugger = {
          enabled = false,
          run_via_dap = false,
        },
        lsp = {
          on_attach = function(client, bufnr)
            -- Keymaps, e.g.:
            -- vim.keymap.set("n", "gd", vim.lsp.buf.definition, {noremap=true, silent=true, buffer=bufnr})
          end,
        },
      })
    end,
  },

  -- Optionally add any other LSP-related plugin or config
  {
    "mason-org/mason.nvim",
    build = ":MasonUpdate",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "mason-org/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup()
    end,
  },

  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("telescope").setup({})
    end,
  },
  {
    "chipsenkbeil/distant.nvim",
    branch = "v0.3",
    config = function()
      require("distant"):setup()
    end,
  },
  {
    "fatih/vim-go",
    ft = "go",
    build = ":GoUpdateBinaries",
    config = function()
      -- vim-go configuration
      vim.g.go_def_mode = "gopls"
      vim.g.go_info_mode = "gopls"
      vim.g.go_fmt_command = "goimports"
      vim.g.go_auto_type_info = 1
    end,
  },
  {
    "ray-x/go.nvim",
    dependencies = { -- optional packages
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      -- lsp_keymaps = false,
      -- other options
    },
    config = function(lp, opts)
      require("go").setup(opts)
      local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*.go",
        callback = function()
          require("go.format").goimports()
        end,
        group = format_sync_grp,
      })
    end,
    event = { "CmdlineEnter" },
    ft = { "go", "gomod" },
    build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
  },
}
