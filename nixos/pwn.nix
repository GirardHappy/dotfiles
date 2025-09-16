{config, pkgs, ... }:
{

 programs.nix-ld = {
   enable = true;
   libraries = with pkgs; [
      glibc
   ];
 };

 imports = [ ./pwndbg.nix ]; 
 environment.systemPackages = with pkgs; [
   ghidra
   vscode
   binaryninja-free
   gcc
   (python3.withPackages (ps: with ps; [ 
     pwntools
     requests
     beautifulsoup4 
   ]))
 ];


}
