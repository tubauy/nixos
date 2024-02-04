{ config, pkgs, ... }:

{

  imports = [
    
  ];

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home = {
    username = "tbu";
    homeDirectory = "/home/tbu";

    # This value determines the Home Manager release that your
    # configuration is compatible with. This helps avoid breakage
    # when a new Home Manager release introduces backwards
    # incompatible changes.
    #
    # You can update Home Manager without changing this value. See
    # the Home Manager release notes for a list of state version
    # changes in each release.
    stateVersion = "23.11";

  
  };

  programs.git = {
    enable = true;
    userName = "tubauy";
    userEmail = "basartugrul.2005@hotmail.com";
    extraConfig = {
      credential.helper = "${
          pkgs.git.override { withLibsecret = true; }
        }/bin/git-credential-libsecret";
    };
  };

  home.packages = with pkgs; [
    # here is some command line tools I use frequently
    # feel free to add your own or remove some of them
    # Other
    audacious
    audacious-plugins
    neofetch
    nnn # terminal file manager


    aalib
    asciiquarium
    cava
    cmatrix


    # archives
    p7zip
    unzip
    xz
    zip

    #dev
    distrobox
    emacs
    gtk4
    neovide
    neovim
    openfortivpn
    vscode

    #desktop
    mimic
    bibata-cursors
    clipman
    eww-wayland
    fira-code
    grim
    hyprpicker
    jetbrains-mono
    kitty
    kooha
    libreoffice-qt
    pulseaudioFull
    slurp
    swaybg    
    swww
    tesseract
    tofi
    tokyo-night-gtk
    waypaper
    wl-clipboard
    wofi
    wofi-emoji
    xfce.thunar

    ryujinx
    
    #browser
    firefox
    qutebrowser

    #flatpaks
    flatpak
    #communication
    discord
    slack
    whatsapp-for-linux
    zoom-us


    # nix related
    #
    # it provides the command `nom` works just like `nix`
    # with more details log output
    nix-output-monitor

  ];

  home.file.".config/hypr" = {
    source = ./hypr;
    # copy the scripts directory recursively
    recursive = true;
    executable = true;  # make all scripts executable
  };
  home.file.".config/fish" = {
    source = ./fish;
    # copy the scripts directory recursively
    recursive = true;
    executable = true;  # make all scripts executable
  };
  home.file.".config/kitty" = {
    source = ./kitty;
    # copy the scripts directory recursively
    recursive = true;
    executable = true;  # make all scripts executable
  };
    home.file.".config/eww" = {
    source = ./eww;
    # copy the scripts directory recursively
    recursive = true;
    executable = true;  # make all scripts executable
  };
  home.file.".config/tofi" = {
    source = ./tofi;
    # copy the scripts directory recursively
    recursive = true;
    executable = true;  # make all scripts executable
  };
  home.file.".config/i3" = {
    source = ./i3;
    # copy the scripts directory recursively
    recursive = true;
    executable = true;  # make all scripts executable
  };
  home.file.".config/qutebrowser" = {
    source = ./qutebrowser;
    # copy the scripts directory recursively
    recursive = true;
    executable = true;  # make all scripts executable
  };
  home.file.".config/dunst" = {
    source = ./dunst;
    # copy the scripts directory recursively
    recursive = true;
    executable = true;  # make all scripts executable
  };
  home.file.".config/waypaper" = {
    source = ./waypaper;
    recursive = true;
  };
  home.file.".config/nvim/lua/custom" = {
    source = ./custom;
    recursive = true;
  };

  home.file.".config/Kvantum/kvantum.kvconfig" = {
    text = ''
      [General]
      theme=MonochromeSolid
    '';

  };
  
  gtk.enable = true;
  gtk.theme.name = "WhiteSur-Dark";
  gtk.iconTheme.name = "Tela";
  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Ice";
    size = 25;
  };

  qt = {
    enable = true;

    platformTheme = "qtct";

    style.name = pkgs.lib.mkForce "kvantum";
  };

  programs.kitty.enable = true;
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
