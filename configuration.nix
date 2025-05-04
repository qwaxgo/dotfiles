# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ inputs, config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ]
    ++ (with inputs.nixos-hardware.nixosModules; [
      common-cpu-intel
      common-gpu-intel
      common-pc-ssd
      common-pc-laptop
    ])
    ++ [
      inputs.xremap.nixosModules.default
    ];
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelPackages = pkgs.linuxKernel.packages.linux_zen;

  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = ["nix-command" "flakes"];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };
  services.xremap = {
    userName = "qwaxgo";
    serviceMode = "system";
    config = {
      modmap = [
        {
          name = "CapsLock is dead";
	  remap = {
	    CapsLock = "Shift_L";
	  };
	}
      ];
    };
  };
  # Bluetooth Setting
  hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
  };

  networking.hostName = "nixos-qwaxgo"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;
   
  # Set your time zone.
  time.timeZone = "Asia/Tokyo";

  # Select internationalisation properties.
  i18n.defaultLocale = "ja_JP.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "ja_JP.UTF-8";
    LC_IDENTIFICATION = "ja_JP.UTF-8";
    LC_MEASUREMENT = "ja_JP.UTF-8";
    LC_MONETARY = "ja_JP.UTF-8";
    LC_NAME = "ja_JP.UTF-8";
    LC_NUMERIC = "ja_JP.UTF-8";
    LC_PAPER = "ja_JP.UTF-8";
    LC_TELEPHONE = "ja_JP.UTF-8";
    LC_TIME = "ja_JP.UTF-8";
  };

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  console = {
    keyMap = "jp106";
    earlySetup = true;
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "jp";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;
  
  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.qwaxgo = {
    isNormalUser = true;
    description = "qwaxgo";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      kdePackages.kate
   #  thunderbird
    ];
    shell = pkgs.zsh;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  wget
    (vivaldi.overrideAttrs
      (oldAttrs: {
        dontWrapQtApps = false;
        dontPatchELF = true;
        nativeBuildInputs = oldAttrs.nativeBuildInputs ++ [pkgs.kdePackages.wrapQtAppsHook];
    })) 
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };
  programs = {
    git = {
      enable = true;
    };
    neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
    };
    zsh = {
      enable = true;
    };
    noisetorch.enable = true;
    dconf = {
      enable = true;
    };
    wl-clipboard-rs = {
      enable = true;
    };
  };

  i18n.inputMethod = {
    enabled = "fcitx5";
    enable = true;
    fcitx5.addons = with pkgs;[
      fcitx5-mozc
      fcitx5-gtk
      kdePackages.fcitx5-qt
      fcitx5-nord
    ];
    fcitx5.waylandFrontend = true;
    fcitx5.plasma6Support = true;
  };

  fonts = {
    fonts = with pkgs; [
      noto-fonts-cjk-serif
      noto-fonts-cjk-sans
      noto-fonts-emoji
      nerdfonts
      migu
    ];
    fontDir.enable = true;
    packages = with pkgs; [
    # Cica
    # cf. https://github.com/NixOS/nixpkgs/blob/nixos-24.05/pkgs/data/fonts/ricty/default.nix
      (stdenv.mkDerivation rec {
        pname = "cica";
        version = "5.0.3";
        src = fetchurl {
          url = "https://github.com/miiton/Cica/releases/download/v${version}/Cica_v${version}.zip";
          sha256 = "cbd1bcf1f3fd1ddbffe444369c76e42529add8538b25aeb75ab682d398b0506f";
        };
        nativeBuildInputs = [ unzip ];
        unpackPhase = "unzip $src";
        installPhase = "install -m644 --target $out/share/fonts/truetype/cica -D Cica-*.ttf";
      })
    ];
    fontconfig = {
      defaultFonts = {
        serif = ["Noto Serif CJK JP" "Noto Color Emoji"];
	sansSerif = ["Noto Sans CJK JP" "Noto Color Emoji"];
	monospace = ["Cica" "Noto Color Emoji"];
	emoji = ["Noto Color Emoji"];
      };
      localConf = ''
        <?xml version="1.0"?>
        <!DOCTYPE fontconfig SYSTEM "urn:fontconfig:fonts.dtd">
	<fontconfig>
	  <description>Change default fonts for Steam client</description>
	  <match>
	    <test name ="prgname">
	      <string>steamwebhelper</string>
            </test>
	    <test name="family" qual="any">
	      <string>sans-serif</string>
            </test>
	    <edit mode="prepend" name="family">
	      <string>Migu 1P</string>
	    </edit>
          </match>
	</fontconfig>
      '';
    };
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  services.tailscale.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall = {
    enable = true;
    trustedInterfaces = ["tailscale0"];
    allowedUDPPorts = [config.services.tailscale.port];
  };

  virtualisation = {
    docker = {
      enable = true;
      rootless = {
        enable = true;
	setSocketVariable = true;
      };
    };
  };

  services.flatpak.enable = true;
  xdg.portal.enable = true;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}
