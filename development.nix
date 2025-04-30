{pkgs, ...}: {
  home.packages = with pkgs; [
    gcc
    go
    nodejs_22
    nodePackages.pnpm
    nodePackages.wrangler
    deno
    bun
    python313
    zig
    rust-bin.stable.latest.default
    godot_4
  ];
}
