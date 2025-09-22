{config, pkgs, ... }:
{
  
 programs.bash.shellAliases = {
   oli   = "python3 /home/girard/Chall/Oli/olipy/olipy.py";
 };

 programs.nix-ld = {
   enable = true;
   libraries = with pkgs; [
      glibc
      libgcc
   ];
 };

  environment = {
    variables = {
      LD_LIBRARY_PATH = "${pkgs.stdenv.cc.cc.lib}/lib";
    };
  };
 #imports = [ ./pwndbg.nix ]; 
 environment.systemPackages = with pkgs; [
   openjdk21
   vscode
   binaryninja-free
   gcc
   gdb
   libgcc
   ghidra-bin
   burpsuite
   (python3.withPackages (ps: with ps; [ 
     pwntools
     requests
     beautifulsoup4
     rzpipe
     ropgadget
   ]))
   man-pages
   man-pages-posix
   glibc
   (rizin.withPlugins(ps: with ps;[rz-ghidra]))
];
}
