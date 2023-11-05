# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  imports = [ # Include the results of the hardware scan.
  ./hardware-configuration.nix
  ./cachix.nix
  ];

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/nvme0n1";
  boot.loader.grub.useOSProber = true;

  security.pam.services.swaylock = { };

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Set your time zone.
  time.timeZone = "Europe/London";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;

  # Configure keymap in X11
  services.xserver = {
    layout = "gb";
    xkbVariant = "";
  };

  # Configure console keymap
  console.keyMap = "dvorak-programmer";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Hyprland
  programs.hyprland.enable = true;

  # Flatpak
  services.flatpak.enable = true;

  programs.sway.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    audio.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  hardware.openrazer.enable = true;
  hardware.openrazer.users = [ "josh" ];

  programs.steam = {
    enable = true;
    remotePlay.openFirewall =
      true; # Open ports in the firewall for Steam Remote Play
      dedicatedServer.openFirewall =
        true; # Open ports in the firewall for Source Dedicated Server
  };

  hardware.opengl.driSupport32Bit = true;
  users.extraGroups.vboxusers.members = [ "josh" ];

  services.openssh.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.josh = {
    isNormalUser = true;
    description = "Josh RL";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      firefox-wayland
      localsend
      yt-dlp
      desktop-file-utils
      grim
      emacs
      slurp
      home-manager
      hwinfo
      nodePackages_latest.pnpm
      wireplumber
      pipewire
      nixfmt
      gtk4
      kate
      thunderbird
      unzip
      love
      neovim
      git
      zsh
      nodejs_20
      neofetch
      pipes
      swww
      pfetch
      cava
      xdotool
      bat
      kitty
      lazygit
      bottom
      tmux
      emacsPackages.git-commit
      python311Packages.requests
      cava
      vlc
      ncspot
      lf
      ripgrep
      quickemu
      fd
      swayosd
      gcc
      rofi-wayland
      myWaybar
      catppuccin-kde
      catppuccin-gtk
      catppuccin-cursors
      catppuccin-papirus-folders
      zellij
      exa
      webcord
      swaylock-effects
      zoxide
      hyprland-protocols
      xdg-desktop-portal-hyprland
      hyprpicker
      wl-clipboard
      jq
      tty-clock
      killall
      file
      superTuxKart
      cargo
      rustup
      rustfmt
      cargo
      rust-analyzer
      rustc
      rustdesk
      steam
      dconf
      fzf
      xwayland
      xdg-desktop-portal-hyprland
      extremetuxracer
      amdvlk
      hyprpaper
      ncspot
      python3
      pkgs.waybar
      gnumake
      cmake
      multimarkdown
      black
      python311Packages.pyflakes
      isort
      pipenv
      steamcmd
      python311Packages.nose
      mods
      cmatrix
      gum
      python311Packages.pytest
      python311Packages.setuptools
      shfmt
      shellcheck
      html-tidy
      nodePackages_latest.stylelint
      btop
      gimp
      nodePackages.prettier
      vscode
      google-chrome
      jsbeautifier
      xorg.xwininfo
      wtype
      wl-clipboard-x11
      openssh
      linuxKernel.packages.linux_zen.amdgpu-pro
      libGLU
      blender
      gtk3
      glib
      emacsPackages.gsettings
      glibc
      usbmuxd
      krita
      libimobiledevice
      docbook5
    ];
  };

  nixpkgs.config = {
    packageOverrides = pkgs: {
      myWaybar = pkgs.waybar.overrideAttrs (oldAttrs: {
        mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
      });
    };
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
  ];
  nixpkgs.overlays = [
    (final: prev: {
      steam = prev.steam.override ({ extraPkgs ? pkgs': [ ], ... }: {
        extraPkgs = pkgs': (extraPkgs pkgs') ++ (with pkgs'; [ libgdiplus ]);
      });
    })
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
    #   enable = true;
    #   enableSSHSupport = true;
    # };

    # List services that you want to enable:

    # Enable the OpenSSH daemon.
    # services.openssh.enable = true;

    # Open ports in the firewall.
    # networking.firewall.allowedTCPPorts = [ ... ];
    # networking.firewall.allowedUDPPorts = [ ... ];
    # Or disable the firewall altogether.
    # networking.firewall.enable = false;

    # This value determines the NixOS release from which the default
    # settings for stateful data, like file locations and database versions
    # on your system were taken. It‘s perfectly fine and recommended to leave
    # this value at the release version of the first install of this system.
    # Before changing this value read the documentation for this option
    # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    system.stateVersion = "23.05"; # Did you read the comment?

}
