{pkgs ? import <nixpkgs> {}} :

pkgs.stdenv.mkDerivation rec {
    pname = "kernel-modules";
    version = "0.0.1";
    src = ./.;

    nativeBuildInputs = with pkgs; [
      pkg-config 
      ncurses 
      flex
      bison
      bc
      pahole
      elfutils 
      perl
      rsync
      kmod
      gettext
      openssl
    ];

    unpackPhase = ''
        cp $src/*.c $src/Makefile .
    '';

    buildPhase = ''
        chmod -R u+w ./ # Building requires writing!
        make -C ${pkgs.linux.dev}/lib/modules/*/build M=$PWD
    '';

    installPhase = ''
        mkdir -p $out/modules
        cp *.ko $out/modules/
    '';
}
