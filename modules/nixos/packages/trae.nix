{ pkgs, ... }:

pkgs.stdenv.mkDerivation rec {
  pname = "trae";
  version = "2.3.24300";

  src = pkgs.fetchurl {
    url = "https://lf-cdn.trae.ai/obj/trae-ai-us/pkg/app/releases/stable/${version}/linux/Trae-linux-x64.deb";
    hash = "sha256-DtJt44xthtO6TGkEwhJi28PJJPWdAbMud/Dpje7zLcY=";
  };

  nativeBuildInputs = with pkgs; [
    autoPatchelfHook
    dpkg
    makeWrapper
    wrapGAppsHook3
  ];

  buildInputs = with pkgs; [
    alsa-lib
    at-spi2-atk
    at-spi2-core
    atk
    cairo
    cups
    dbus
    expat
    glib
    gtk3
    libdrm
    libxkbcommon
    mesa
    nspr
    nss
    pango
    systemd
    libx11
    libxcomposite
    libxdamage
    libxext
    libxfixes
    libxrandr
    libxcb
    libxshmfence
    xcbutilkeysyms
    libxcrypt
    webkitgtk_4_1
    libsoup_3
    libsecret
    libxkbfile
    gsettings-desktop-schemas
  ];

  runtimeDependencies = with pkgs; [
    libxkbcommon
    webkitgtk_4_1
    libsoup_3
    libsecret
  ];

  autoPatchelfIgnoreMissingDeps = [
    "libc.musl-x86_64.so.1"
  ];

  dontWrapGApps = true;

  unpackPhase = ''
    dpkg-deb --fsys-tarfile $src | tar -x --no-same-permissions
  '';

  installPhase = ''
    mkdir -p $out/bin $out/share
    cp -r usr/share/trae $out/share/
    
    if [ -d usr/share/icons ]; then
      cp -r usr/share/icons $out/share/
    fi
    if [ -d usr/share/pixmaps ]; then
      cp -r usr/share/pixmaps $out/share/
    fi
    if [ -d usr/share/applications ]; then
      cp -r usr/share/applications $out/share/
      # Fix desktop file if it exists
      if [ -f $out/share/applications/trae.desktop ]; then
        substituteInPlace $out/share/applications/trae.desktop \
          --replace-fail "/usr/share/trae/trae" "trae"
      fi
    fi
    
    makeWrapper $out/share/trae/trae $out/bin/trae \
      --prefix XDG_DATA_DIRS : "${pkgs.gsettings-desktop-schemas}/share/gsettings-schemas/${pkgs.gsettings-desktop-schemas.name}:${pkgs.gtk3}/share/gsettings-schemas/${pkgs.gtk3.name}:$XDG_DATA_DIRS" \
      --prefix LD_LIBRARY_PATH : "${pkgs.lib.makeLibraryPath [ pkgs.libdbusmenu-gtk3 ]}"
  '';
}
