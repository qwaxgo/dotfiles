{pkgs, ...}: {
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    plugins = with pkgs.vimPlugins; [
      # Treesitter
      (nvim-treesitter.withPlugins (plugins:
        with plugins; [
          tree-sitter-markdown
          tree-sitter-nix
          # ...
        ]))
      telescope-nvim
      # ...
    ];

    # Neovim内部でのみPATHが通されるパッケージ
    # LSPやフォーマッタ、その他Neovimから呼び出すツールを指定しよう
    extraPackages = with pkgs; [
      ripgrep
      biome
      nodePackages.eslint
      nodePackages.prettier
      nodePackages.typescript-language-server
      # ...
    ];

    # ~/.config/nvim/init.luaに文字列が展開される
    extraLuaConfig = builtins.readFile ./init.lua;
  };
}
