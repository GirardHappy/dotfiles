{ pkgs }:

pkgs.stdenv.mkDerivation rec {
  pname = "pwndbg-portable";
  version = "2025.05.30";

  src = pkgs.fetchurl {
    url = "https://github.com/pwndbg/pwndbg/releases/download/2025.05.30/pwndbg_2025.05.30_x86_64-portable.tar.xz";
    sha256 = "hLG7DLRog97jTyHte5YAoRMYm1BhRN3T29fWPHlaQjU=";
  };

  nativeBuildInputs = [ pkgs.python3 ];

  unpackPhase = "true";

  buildPhase = ''
    mkdir -p $out
    tar -xJf $src --strip-components=2 -C $out
  '';

  installPhase = ''
    chmod +x $out/bin/pwndbg
  '';

  meta = with pkgs.lib; {
    description = "Portable Pwndbg downloaded from GitHub";
    license = licenses.mit;
  };
}
