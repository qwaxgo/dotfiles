{pkgs, ...}: 
{
  environment.systemPackages = with pkgs; [
    xorg.libxcb
    xorg.xcbutil
    xorg.xcbutilcursor
    qt6.qtwayland
  ];

  programs.nix-ld.enable = true;
}
