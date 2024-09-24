{ pkgs, config, libs, inputs, ... }:

{
  
  # in case of git.sr.ht outage
  #manual.html.enable = false;
  #manual.manpages.enable = false;
  #manual.json.enable = false;


  imports = [
  ];
  #news.display = "silent";
  home.username = "radioaddition";
  home.homeDirectory = "/home/radioaddition";
  nixpkgs.config.allowUnfree = true;
  home.sessionPath = [ "$HOME/.local/bin" "/usr/local/bin" ];
  home.sessionVariables = {
    EDITOR = "nvim";
    DBX_CONTAINER_MANAGER = "podman";
  };
  # GPG
  services.gpg-agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-gnome3;
  };

  # Syncthing
  services.syncthing = {
    enable = true;
    tray.enable = true;
  };

  # ZSH
  programs.zsh = {
    enable = true;
    shellAliases = {
      clearls = "clear && ls -A";
      archive = "tar -czvf archive.tar.gz ";
      extract = "tar -xzvf ";
      vivi = "nvim /home/radioaddition/.config/nvim/init.vim";
      clean = "nix-env --delete-generations old && nix-collect-garbage -d";
      cleanr = "sudo nix-env --delete-generations old && sudo nix-collect-garbage -d";
    };
    zplug = {
      enable = true;
      plugins = [
        { name = "zsh-users/zsh-autosuggestions"; }
        { name = "zsh-users/zsh-syntax-highlighting"; }
        { name = "jeffreytse/zsh-vi-mode"; }
        { name = "romkatv/powerlevel10k"; tags = [ as:theme depth:1 ]; }
      ];
    };
    initExtraFirst = ''
      # Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
      # Initialization code that may require console input (password prompts, [y/n]
      # confirmations, etc.) must go above this block; everything else may go below.
      if [[ -r "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
        source "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
      fi
    '';
    initExtra = ''
. "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"

. ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
      source "$HOME/NixOS-Config/.p10k.zsh"
      eval "$(atuin init zsh)"
'';
  };

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    warn-dirty = false;
  };
  nix.package = pkgs.nixFlakes;
#  home.packages = (with pkgs; [
#
#  # Packages
#
#    adwsteamgtk
#    atuin
#    bat
#    bottles
#    boxbuddy
#    btop
#    cartridges
#    collision
#    curl
#    direnv
#    discover-overlay
#    distrobox
#    docker-compose
#    eza
#    feather
#    firefox
#    fragments
#    freshfetch
#    gcc
#    gettext
#    git
#    git-repo
#    github-desktop
#    glas
#    gleam
#    glib
#    gnome.dconf-editor
#    gnome-extension-manager
#    gnome.gnome-boxes
#    gnome.gnome-tweaks
#    gnome.polari
#    gnome.seahorse
#    gnumake
#    goofcord
#    gparted
#    guake
#    helvum
#    home-manager
#    hyfetch
#    impression
#    iosevka
#    jamesdsp
#    keepassxc
#    librewolf
#    llama-cpp
#    lutris
#    meslo-lgs-nf
#    mindustry-wayland
#    monophony
#    mpv
#    neovim
#    neovim-gtk
#    nix-search-cli
#    nodePackages_latest.pnpm
#    nodejs-slim
#    onionshare-gui
#    openrazer-daemon
#    pavucontrol
#    perl
#    picard
#    pika-backup
#    pinentry-gnome3
#    pipx
#    pnpm-shell-completion
#    polychromatic
#    protonmail-bridge
#    protonmail-bridge-gui
#    protonplus
#    protonvpn-gui
#    ptyxis
#    python3
#    redis
#    sassc
#    shattered-pixel-dungeon
#    simplex-chat-desktop
#    topgrade
#    tor-browser
#    tuckr
#    usbtop
#    ventoy-full
#    wget
#    wl-clipboard
#    wlrctl
#    xmrig-mo
#
#  # Gnome Extensions
#  ]) ++ (with pkgs.gnomeExtensions; [
#      alphabetical-app-grid
#      appindicator
#      blur-my-shell
#      burn-my-windows
#      caffeine
#      dash2dock-lite
#      gsconnect
#      logo-menu
#      night-theme-switcher
#      pop-shell
#      quick-settings-audio-devices-renamer
#      search-light
#      wifi-qrcode
#      wiggle
#      window-title-is-back
#      xwayland-indicator
#      zen
#    ]);
  #home.enableNixpkgsReleaseCheck = false; # If using a package from the unstable branch uncomment this
  home.stateVersion = "24.05";
}
