-- Auto-install packer.nvim if not exists
local fn = vim.fn
local install_path = fn.stdpath("data").."/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({"git", "clone", "https://github.com/wbthomason/packer.nvim", install_path})
end

-- Initialize Packer and add your plugins
require("packer").startup({
  function(use)
    use "neovim/nvim-lspconfig"
    use "jose-elias-alvarez/null-ls.nvim"
  end,
  config = {
    display = {
      open_fn = function()
        return require("packer.util").float({ border = "single" })
      end,
    },
  },
})

-- Initialize null-ls
local null_ls = require("null-ls")

null_ls.setup({
  sources = {
    null_ls.builtins.diagnostics.shellcheck,
  },
})

-- Initialize lspconfig
local lspconfig = require("lspconfig")

-- Attach null-ls as a child client to bashls
lspconfig.bashls.setup({
  on_attach = function(client)
    local null_ls_instance = null_ls.get_or_create()
    null_ls_instance:attach(client._client)
  end,
})

