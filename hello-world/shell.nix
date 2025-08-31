# save this as shell.nix
{ pkgs ? import <nixpkgs> {}}:

pkgs.mkShell {
  packages = with pkgs; [ 
      pkg-config 
      ncurses 
      flex
      bison
      bc
      pahole
      elfutils # Be careful, libelf has some implicit declaration errors
      perl
      rsync
      kmod
      gettext
      openssl
  ];
}
