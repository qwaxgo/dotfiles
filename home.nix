{ config, pkgs, ... }:
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
    ./onedrive.nix
  ];
  home = rec {
    username = "qwaxgo";
    homeDirectory = "/home/${username}";
    stateVersion = "24.11";
  };
  programs.home-manager.enable = true;

  home.file = {
    "wallpaper.png" = {
      target = "Wallpaper/wallpaper.png"; # ~/Wallpaper/wallpaper.pngに配置
      source = ./wallpaper.png; # 配置するファイル
    };
  };

  home.packages = with pkgs; [
    bat
    bottom
    eza
    httpie
    pingu
    ripgrep
    bluez-tools
    qt6ct
    wl-clipboard-rs
    virt-manager
    virt-viewer
    quickemu
    quickgui
    gnome.gnome-boxes
    trayscale
    onedrive
  ];

  home.sessionVariables.QT_QPA_PLATFORM = "wayland";
}
