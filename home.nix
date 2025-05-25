{
  pkgs,
  ...
}:
{
  imports = [
    ./zsh.nix
    ./starship.nix
    ./neovim.nix
    ./direnv.nix
    ./development.nix
    ./wezterm.nix
    ./browser.nix
    ./apps.nix
    ./plasma.nix
  ];
  home = rec {
    username = "qwaxgo";
    homeDirectory = "/home/${username}";
    stateVersion = "25.05";
    sessionVariables.QT_QPA_PLATFORM = "wayland";
    file = {
      "wallpaper.png" = {
        target = "Wallpaper/wallpaper.png"; # ~/Wallpaper/wallpaper.pngに配置
        source = ./wallpaper.png; # 配置するファイル
      };
    };
    packages = with pkgs; [
      bat
      bottom
      eza
      httpie
      ripgrep
      bluez-tools
      qt6ct
      wl-clipboard-rs
      virt-manager
      virt-viewer
      quickemu
      quickgui
      gnome-boxes
      trayscale
      onedrive
      onedrivegui
    ];
  };
  programs.home-manager.enable = true;
}
