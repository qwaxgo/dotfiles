{pkgs, ...}: 
{
  environment.systemPackages = with pkgs; [
    libxcb
    libxcb.lib
    xorg.xcbutil
    xorg.xcbutilcursor
    qt6.qtwayland
  ];

  programs.nix-ld.enable = true;
}
