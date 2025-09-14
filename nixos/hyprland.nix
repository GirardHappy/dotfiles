{config,pkgs,...}:
{
  environment.systemPackages = with pkgs; [
    sddm-astronaut
    rofi
    adw-gtk3
    hyprpaper
    hypridle
    hyprlock
    rose-pine-hyprcursor
    hyprshot
    playerctl
    networkmanagerapplet
    pavucontrol
    hyprpolkitagent
    brightnessctl
    swaynotificationcenter
    libnotify
    wlogout    
    papirus-icon-theme
    cliphist
    wl-clipboard
  ];

 environment.sessionVariables = {
     NIXOS_OZONE_WL = "1";
  };

 programs.xfconf.enable = true;
 programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  programs.waybar.enable = true;
   
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  services.displayManager.sddm = {
    wayland.enable = true;
    enable = true;
    package = pkgs.kdePackages.sddm;
    theme = "sddm-astronaut-theme";
    extraPackages = [pkgs.sddm-astronaut];
  };
 
  
  time.timeZone = "Europe/Rome";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "it_IT.UTF-8";
    LC_IDENTIFICATION = "it_IT.UTF-8";
    LC_MEASUREMENT = "it_IT.UTF-8";
    LC_MONETARY = "it_IT.UTF-8";
    LC_NAME = "it_IT.UTF-8";
    LC_NUMERIC = "it_IT.UTF-8";
    LC_PAPER = "it_IT.UTF-8";
    LC_TELEPHONE = "it_IT.UTF-8";
    LC_TIME = "it_IT.UTF-8";
  };

  services.xserver = {
    enable = true;
  };

  fonts.packages = with pkgs; [
      nerd-fonts.jetbrains-mono
  ];

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
  };
  
  programs.dconf = {
    enable = true;
    profiles.user.databases = [{
      settings = {  
        "org/gnome/desktop/interface" = {
          color-scheme = "prefer-dark";
          gtk-theme = "Adwaita-dark";
          icon-theme = "Papirus-Dark";
        };
      };
    }];
  };
  
  environment.sessionVariables = {
    GTK_THEME = "adw-gtk3-dark";
  };  

}
