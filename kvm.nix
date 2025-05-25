# ── KVM/QEMU 基本 ──
{ config, ... }: {
  boot.kernelModules = [ "kvm-intel" ];   # AMD なら kvm-amd

  virtualisation.libvirtd.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;

  networking.firewall.allowedTCPPorts = [ 5900 5901 ]; # VNC 用
  services.spice-vdagentd.enable = true;

  # libvirtd と kvm グループに追加
  users.users.qwaxgo.extraGroups = [ "libvirtd" "kvm" ];

  virtualisation.libvirtd.extraConfig = ''
  unix_sock_group = "libvirtd"
  unix_sock_rw_perms = "0770"
  '';

  networking.bridges.br0.interfaces = [ "wlp0s20f3" ];  # Wi-Fi NIC
  networking.interfaces.br0.useDHCP = true;
}
