{
  home = rec {
    username = "qwaxgo";
    homeDirectory = "/home/${username}";
    stateVersion = "24.11";
  };
  programs.home-manager.enable = true;

  home.file = {
    "wallpaper.png" = {
      target = "Wallpaper/wallpaper.png";
      source = ./wallpaper.png;
    };
  };

  home.packages = with pkgs; [
    bat
    bottom
    eza
    httpie
    ripgrep
  ];
}
