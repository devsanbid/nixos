# Libraries & Development Headers
{ pkgs, ... }: {

  environment.systemPackages = with pkgs; [
    # GTK & GLib
    atk
    atk.dev
    cairo
    cairo.dev
    glib
    glib.dev
    gdk-pixbuf
    gdk-pixbuf.dev
    gobject-introspection
    gobject-introspection.dev
    gtk3
    gtk3.dev
    gtk4
    gtk4.dev
    pango
    pango.dev

    # WebKit
    webkitgtk_4_1
    webkitgtk_4_1.dev
    libsoup_3.dev

    # Qt
    qt6.qtwayland

    # Other libraries
    libadwaita
    libappindicator-gtk3
    librsvg
    librsvg.dev
    openssl
    pkg-config

    # CUDA & GPU
    cudaPackages.libcublas
    cudatoolkit
    upscayl

    # Mobile support
    scrcpy
    libimobiledevice
    ifuse

    # Virtualization
    gnome-boxes
    spice
    spice-gtk
    spice-protocol
    virt-viewer

    # Gnome Extensions
    gnomeExtensions.appindicator
    gnomeExtensions.nordvpn-quick-toggle
    gvfs

    # Misc
    kdePackages.kde-gtk-config
    lact
    ocs-url
    poweralertd
    psi-notify
    tk
  ];
}
