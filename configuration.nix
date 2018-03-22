# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running â€˜nixos-helpâ€™).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.cleanTmpDir = true;

  networking.hostName = "acer"; # Define your hostname.
  networking.wireless = {
    enable = true;  # Enables wireless support via wpa_supplicant.
  };

  virtualisation = {
    docker = {
      enable = true;
    };
  };

  #hardware.pulseaudio.package = pkgs.pulseaudioFull; # support for bluetooth headsets
  #hardware.bluetooth.enable = true;

  # Select internationalisation properties.
  i18n = {
     consoleFont = "Lat2-Terminus16";
     consoleKeyMap = "us";
     defaultLocale = "en_US.UTF-8";
  };

  # Set your time zone.
  time.timeZone = "Europe/Bucharest";

  fonts = {
    enableFontDir = true;
    enableGhostscriptFonts = true;
    fonts = with pkgs; [
      inconsolata
      fira-mono
      ubuntu_font_family
    ];
  };

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    acpi
    atop
    blueman
    curl
    chromium
    firefox
    ghostscript
    gimp
    gnumake
    gnupg
    gparted
    htop
    libnotify
    lynx
    mtr
    pavucontrol
    sysdig
    tlp
    tmux
    tree
    unzip 
    vim
    wget
    wirelesstools
    xclip
    xorg.xbacklight
    xorg.xf86inputsynaptics

    git
    go
    leiningen
    openjdk
    maven
    nodejs
    watchman
  ];

  environment.variables = { GOROOT = [ "${pkgs.go.out}/share/go" ]; };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.bash.enableCompletion = true;
  programs.mtr.enable = true;
  programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.layout = "us,ro";
  #services.xserver.xkbOptions = "";

  # Enable touchpad support.
  services.xserver.synaptics.enable = true;
  services.xserver.synaptics.twoFingerScroll = true;
  services.xserver.videoDrivers = [ "intel" ];

  # Enable the KDE Desktop Environment.
  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.desktopManager.xfce.enable = true;
  services.xserver.windowManager.xmonad.enable = true;

  # Define a user account. Don't forget to set a password with â€˜passwdâ€™.
  users.extraUsers.bit-twit = {
     extraGroups = ["wheel" "disk" "audio" "video" "networkmanager" "systemd-journal" "docker"];
     isNormalUser = true;
     uid = 1000;
  };

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "17.09"; # Did you read the comment?

}
