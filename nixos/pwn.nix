{config, pkgs, ... }:
{

 programs.nix-ld = {
   enable = true;
   libraries = with pkgs; [
      glibc
   ];
 };
 
 environment.systemPackages = with pkgs; [
   ghidra
   vscode
   binaryninja-free

   (python3.withPackages (ps: with ps; [ 
     gdb
     pwntools
     requests
     beautifulsoup4 
   ]))
   (import ./pwndbg.nix { inherit pkgs; })
 ];


}
