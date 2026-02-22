# Environment variables — XDG, CUDA, PKG_CONFIG, Rust
{ pkgs, ... }:

{
  environment.etc."usr/bin/which".source = "${pkgs.which}/bin/which";

  environment.sessionVariables = rec {
    XDG_CACHE_HOME = "$HOME/.cache";
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_DATA_HOME = "$HOME/.local/share";
    XDG_STATE_HOME = "$HOME/.local/state";
    XDG_BIN_HOME = "$HOME/.local/bin";

    PATH = [ "${XDG_BIN_HOME}" "$HOME/.cargo/bin" ];
    RUST_SRC_PATH = "${pkgs.rust.packages.stable.rustPlatform.rustLibSrc}";

    CUDA_PATH = "${pkgs.cudatoolkit}";
    EXTRA_LDFLAGS = "-L/lib -L${pkgs.linuxPackages.nvidia_x11}/lib";
    EXTRA_CCFLAGS = "-I/usr/include";

    GDK_SCALE = "1";
    PKG_CONFIG_PATH = builtins.concatStringsSep ":" [
      "${pkgs.openssl.dev}/lib/pkgconfig"
      "${pkgs.webkitgtk_4_1.dev}/lib/pkgconfig"
      "${pkgs.libsoup_3.dev}/lib/pkgconfig"
      "${pkgs.gtk4.dev}/lib/pkgconfig"
      "${pkgs.gtk3.dev}/lib/pkgconfig"
      "${pkgs.pango.dev}/lib/pkgconfig"
      "${pkgs.cairo.dev}/lib/pkgconfig"
      "${pkgs.gdk-pixbuf.dev}/lib/pkgconfig"
      "${pkgs.glib.dev}/lib/pkgconfig"
      "${pkgs.atk.dev}/lib/pkgconfig"
      "${pkgs.gobject-introspection.dev}/lib/pkgconfig"
    ];

    FLAKE = "$HOME/.dotfiles/nixos-config";

    LD_LIBRARY_PATH = [ "/run/current-system/sw/share/nix-ld/lib" ];
  };
}
