{ config, pkgs, ... }:

let
  pwndbg = pkgs.stdenv.mkDerivation rec {
    pname = "pwndbg";
    version = "0.6.2";

    src = pkgs.fetchurl {
      url = "https://www.dropbox.com/scl/fi/q13hojpijpz7najo44p27/pwndbg.tar.xz?rlkey=o00mo54rjbahyg9ipjflbkxep&st=n0px72in&dl=1";
      sha256 = "PHfN8pMLivHhfEV0j4AycZH5dx1izxkBgKiU/53jcos=";
    };

    unpackPhase = "true";

    installPhase = ''
      mkdir -p $out
      tar -xJf ${src} -C $out --strip-components=2
      find $out/.venv/share/terminfo -type l ! -exec test -e {} \; -delete
    '';

    meta = with pkgs.lib; {
      description = "pwndbg portable + gdb support";
      license = licenses.mit;
    };
  };
in
{
  environment.systemPackages = with pkgs; [
    pwndbg
  ];

  system.activationScripts.gdbinit = let
    gdbinitPath = "${pwndbg}/gdbinit.py";
  in ''
    for dir in /home/*; do
      if [ -d "$dir" ]; then
        echo "source ${gdbinitPath}" > "$dir/.gdbinit"
        chown $(stat -c '%U:%G' "$dir") "$dir/.gdbinit"
      fi
    done
  '';
}
