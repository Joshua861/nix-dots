{ config, pkgs, ... }:

{

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "josh";
  home.homeDirectory = "/home/josh";

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting
    '';
    plugins = [
      {
        name = "z";
        src = pkgs.fishPlugins.z;
      }
      {
        name = "autopair";
        src = pkgs.fishPlugins.autopair;
      }
      {
        name = "fzf.fish";
        src = pkgs.fishPlugins.fzf-fish;
      }
      {
        name = "done";
        src = pkgs.fishPlugins.done;
      }
    ];
    shellAliases = {
      e = "exa -a";
      et = "exa -a -T";
      prettier = "npx prettier";
      fb = ''
        fzf --preview "bat --color=always --style=numbers --line-range=:500 {}"'';
      nv = "nvim";
      gc = "gh repo clone";
      hmc = "nvim ~/.config/home-manager/home.nix";
      nixc = "sudo nvim /etc/nixos/configuration.nix";
      nixr = "sudo nixos-rebuild switch";
      hmr = "home-manager switch";
      hm = "home-manager";
      doom = "~/.config/emacs/bin/doom";
      ytd = "yt-dlp";
    };
  };

  gtk = {
    enable = true;
    theme.name = "catppuccin-gtk";
    cursorTheme.name = "catppuccin-cursors";
    iconTheme.name = "catppuccin-papirus-folders";
  };

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "22.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    pkgs.fish
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';

    ".config/doom".source = ./config/doom;
    ".config/hypr".source = ./config/hypr;
    ".config/bottom".source = ./config/bottom;
    ".config/nvim".source = ./config/nvim;
    ".config/kitty".source = ./config/kitty;
    ".config/neofetch".source = ./config/neofetch;
    ".config/rofi".source = ./config/rofi;
    ".config/cava".source = ./config/cava;
    ".config/waybar".source = ./config/waybar;
    ".config/dunst".source = ./config/dunst;
    ".config/swaylock".source = ./config/swaylock;
    ".config/bat".source = ./config/bat;
    # ".config/fish".source = ./config/fish;
  };

  # You can also manage environment variables but you will have to manually
  # source
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/josh/etc/profile.d/hm-session-vars.sh
  #
  # if you don't want to manage your shell through Home Manager.
  home.sessionVariables = { EDITOR = "emacs"; };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
