{ pkgs, lib, ... }:

let
  roxyBrowser = pkgs.stdenv.mkDerivation rec {
    pname = "roxybrowser";
    version = "1.0.0";

    src = ./RoxyBrowser.deb;

    nativeBuildInputs = with pkgs; [
      dpkg
      autoPatchelfHook
      makeWrapper
    ];

    buildInputs = with pkgs; [
      # Core libraries
      glib
      glibc
      gcc-unwrapped.lib
      
      # GTK & GUI
      gtk3
      gtk4
      pango
      cairo
      gdk-pixbuf
      atk
      
      # Audio
      alsa-lib
      pulseaudio
      pipewire
      
      # Graphics
      libGL
      libdrm
      mesa
      vulkan-loader
      
      # X11
      xorg.libX11
      xorg.libXcomposite
      xorg.libXdamage
      xorg.libXext
      xorg.libXfixes
      xorg.libXrandr
      xorg.libxcb
      xorg.libXcursor
      xorg.libXi
      xorg.libXrender
      xorg.libXtst
      xorg.libXScrnSaver
      
      # Wayland
      libxkbcommon
      wayland
      
      # Security & Crypto
      nss
      nspr
      openssl
      
      # System
      systemd
      dbus
      expat
      cups
      libnotify
      
      # Fonts
      fontconfig
      freetype
      
      # Misc
      at-spi2-atk
      at-spi2-core
      libsecret
      libappindicator-gtk3
      libdbusmenu
    ];

    unpackPhase = ''
      runHook preUnpack
      dpkg-deb -x $src .
      runHook postUnpack
    '';

    installPhase = ''
      runHook preInstall

      mkdir -p $out/opt/RoxyBrowser
      mkdir -p $out/bin
      mkdir -p $out/share

      # Copy the application
      cp -r opt/RoxyBrowser/* $out/opt/RoxyBrowser/

      # Copy icons and desktop file
      cp -r usr/share/* $out/share/

      # Create wrapper script
      makeWrapper $out/opt/RoxyBrowser/roxybrowser $out/bin/roxybrowser \
        --prefix LD_LIBRARY_PATH : "${lib.makeLibraryPath buildInputs}" \
        --set ELECTRON_ENABLE_LOGGING 1 \
        --add-flags "--no-sandbox" \
        --add-flags "--disable-setuid-sandbox" \
        --add-flags "--disable-gpu-sandbox" \
        --add-flags "--enable-features=UseOzonePlatform" \
        --add-flags "--ozone-platform=wayland" \
        --add-flags "--enable-wayland-ime" \
        --add-flags "--remote-debugging-port=0" \
        --add-flags "--disable-background-networking" \
        --add-flags "--disable-dev-shm-usage"

      # Fix desktop file
      substituteInPlace $out/share/applications/roxybrowser.desktop \
        --replace "/opt/RoxyBrowser/roxybrowser" "$out/bin/roxybrowser" \
        --replace "Icon=roxybrowser" "Icon=$out/share/icons/hicolor/256x256/apps/roxybrowser.png"

      runHook postInstall
    '';

    meta = with lib; {
      description = "Premier Antidetect Browser - Streamline Your Workflow Effortlessly";
      homepage = "https://roxybrowser.com";
      platforms = [ "x86_64-linux" ];
      mainProgram = "roxybrowser";
    };
  };
in
{
  environment.systemPackages = [ roxyBrowser ];
}
