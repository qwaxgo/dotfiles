{pkgs, ...}: {
  # Spotify TUI
  programs.ncspot.enable = true;

  home.packages = with pkgs; [
    discord
    discord-ptb
    vlc
    parsec-bin # 超速いリモートデスクトップクライアント
    remmina # VNCクライアント
    slack
    spotify
    vscode
  ];
}
