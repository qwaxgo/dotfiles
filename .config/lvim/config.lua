-- optionとか

-- keymap
lvim.leader = "\\"

lvim.keys.normal_mode["<C-n>"] = ":NvimTreeToggle<CR>"
-- Tips: lunarvimのデフォルトは<gvらしい
lvim.keys.visual_mode["<"] = false
-- >も同様に
lvim.keys.visual_mode[">"] = false

-- telescopeの場合少し特殊で、telescole.builtinをrequireして使う
local builtin = require("telescope.builtin")
lvim.keys.normal_mode["<leader>ff"] = builtin.find_files
lvim.keys.normal_mode["<leader>fg"] = builtin.live_grep
lvim.keys.normal_mode["<leader>fb"] = builtin.buffers
lvim.keys.normal_mode["<leader>fh"] = builtin.help_tags

-- override
-- builtinで既存のプラグインの有効/無効、及びconfig内の調整ができる
-- activeで有効/向こうの切り替え、on_config_doneで追加の設定もしくは変更
lvim.builtin.bufferline.active = false
lvim.builtin.which_key.active = false
-- 実はLunarvimのデフォルトのテーマと全く同じなんだけど、設定例として記載しておく。
lvim.colorscheme = "lunar"

-- フォーマット時自動でセーブするか
lvim.format_on_save.enabled = true

-- lsp
-- mason-lspconfigに登録されているもののみ選択可能
lvim.lsp.installer.setup.ensure_installed = {
  "marksman"
}

-- plugins
-- 導入方法はlazy.nvimの標準的な方法と全く同じ
lvim.plugins = {
  {
    -- linterやformatterだけインストール自動化したい場合はこれがないと自動化するのが難しい
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      require("mason-tool-installer").setup({
        ensure_installed = {
          "stylua",
        },
      })
    end,
  },
}
