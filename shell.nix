let
  nixpkgs = fetchTarball "https://github.com/NixOS/nixpkgs/tarball/release-24.05";
  pkgs = (import nixpkgs {}).pkgsCross.i686-embedded;
in

# callPackage is needed due to https://github.com/NixOS/nixpkgs/pull/126844
pkgs.pkgsStatic.callPackage ({ mkShell, pkg-config, file, binutils, grub2, xorriso}: mkShell {
  # these tools run on the build platform, but are configured to target the host platform
  nativeBuildInputs = [ pkg-config file binutils];
  # libraries needed for the host platform
  buildInputs = [  ];
}) {}
