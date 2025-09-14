

{ config, pkgs, ... }:
{
  programs.yazi.enable = true;
  services.blueman.enable = true;


  imports =[
    ./hardware-configuration.nix
    ./hyprland.nix
    ./pwn.nix
    ./extra.nix
  ];

  networking.hostName = "girard-laptop";
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;


  users.users.girard = {
    isNormalUser = true;
    description = "girard";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    packages = with pkgs; [];
  };

  nixpkgs.config.allowUnfree = true;

  services.gvfs.enable = true; # Mount, trash, and other functionalities
  services.tumbler.enable = true; # Thumbnail support for images
  programs.thunar = {
    enable = true;
    plugins = with pkgs.xfce; [thunar-archive-plugin thunar-volman];
  };

  environment.systemPackages = with pkgs; [
      wget
      kitty
      firefox
      lf
      fastfetch
      git
      btop
      procps
      micro
  ];
  

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  virtualisation.docker.enable = true;
  #Auto update
  system.autoUpgrade = {
    enable = true;
    dates = "weekly";
  };
  #Auto garbage collection
  nix.gc = {
    automatic = true;
    dates =  "daily";
    options = "--delete-older-than 10d";
  };
  nix.settings.auto-optimise-store = true;
  programs.noisetorch.enable = true;




  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = false;

  #tlp
  services.tlp = {
    enable = true;   
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
      CPU_MIN_PERF_ON_AC = 0;
      CPU_MAX_PERF_ON_AC = 100;
      CPU_MIN_PERF_ON_BAT = 0;
      CPU_MAX_PERF_ON_BAT = 50;

      START_CHARGE_THRESH_BAT1 = 70;
      STOP_CHARGE_THRESH_BAT1 = 80;

          # PCIe ASPM: enable maximum power savings
          PCIE_ASPM_ON_BAT = "powersupersave";
          PCIE_ASPM_ON_AC  = "performance";
          
          # Runtime PM: enable for all supported devices
          RUNTIME_PM_ON_BAT = "auto";
          RUNTIME_PM_ON_AC  = "on";
          RUNTIME_PM_DRIVER_DENYLIST = "mei_me nouveau radeon";
          
          # Make sure Wi-Fi uses powersave
          WIFI_PWR_ON_BAT = "on";
          WIFI_PWR_ON_AC  = "off";
          
          # USB autosuspend
          USB_AUTOSUSPEND = 1;
    };
  };

 


  systemd.services.huawei-battery-thresholds = {
    description = "Set Huawei Battery Charge Thresholds";
    wantedBy = [ "multi-user.target" ];
    after = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = ''/bin/sh -c "echo 70 80 > /sys/devices/platform/huawei-wmi/charge_control_thresholds"'';  
    };
  };




   
  system.stateVersion = "25.05";
}
