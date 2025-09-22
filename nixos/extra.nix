{config, pkgs, ...}:
{
  environment.systemPackages = with pkgs; [
   youtube-music
   discord
   file-roller
   chatgpt-cli
  ];
}
