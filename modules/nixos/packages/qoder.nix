# Qoder — Agentic Coding Platform (from local .deb)
{
  lib,
  stdenv,
  requireFile,
  dpkg,
  autoPatchelfHook,
  makeWrapper,
  wrapGAppsHook3,
  alsa-lib,
  at-spi2-atk,
  at-spi2-core,
  atk,
  cairo,
  cups,
  curl,
  dbus,
  expat,
  gdk-pixbuf,
  glib,
  gtk3,
  libdrm,
  libGL,
  libnotify,
  libsecret,
  libxkbcommon,
  libxkbfile,
  mesa,
  nspr,
  nss,
  pango,
  systemd,
  vulkan-loader,
  xdg-utils,
  libX11,
  libXcomposite,
  libXdamage,
  libXext,
  libXfixes,
  libXrandr,
  libxcb,
  libgbm,
}:

stdenv.mkDerivation rec {
  pname = "qoder";
  version = "0.4.7";

  src = requireFile {
    name = "qoder_amd64.deb";
    sha256 = "1z85k6f2jiz23m3h07i4nmih80a7xnwg76vlsafdm2gpq4542qiy";
    url = "https://qoder.com";
  };

  nativeBuildInputs = [
    dpkg
    autoPatchelfHook
    makeWrapper
    wrapGAppsHook3
  ];

  buildInputs = [
    alsa-lib
    at-spi2-atk
    at-spi2-core
    atk
    cairo
    cups
    curl
    dbus
    expat
    gdk-pixbuf
    glib
    gtk3
    libdrm
    libGL
    libnotify
    libsecret
    libxkbcommon
    libxkbfile
    mesa
    nspr
    nss
    pango
    systemd
    vulkan-loader
    libX11
    libXcomposite
    libXdamage
    libXext
    libXfixes
    libXrandr
    libxcb
    libgbm
  ];

  runtimeDependencies = [
    systemd
    vulkan-loader
  ];

  dontBuild = true;
  dontConfigure = true;
  dontWrapGApps = true;

  unpackPhase = ''
    ar x $src
    tar xf data.tar.xz --no-same-permissions --no-same-owner
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p $out
    cp -r usr/share $out/share
    cp -r usr/bin $out/bin 2>/dev/null || true

    mkdir -p $out/lib
    cp -r usr/share/qoder/* $out/lib/

    mkdir -p $out/bin
    ln -sf $out/lib/qoder $out/bin/qoder

    # Fix desktop files
    substituteInPlace $out/share/applications/qoder.desktop \
      --replace-fail "/usr/share/qoder/qoder" "$out/bin/qoder"

    substituteInPlace $out/share/applications/qoder-url-handler.desktop \
      --replace-fail "/usr/share/qoder/qoder" "$out/bin/qoder"

    runHook postInstall
  '';

  postFixup = ''
    wrapProgram $out/bin/qoder \
      "''${gappsWrapperArgs[@]}" \
      --prefix LD_LIBRARY_PATH : "${lib.makeLibraryPath runtimeDependencies}" \
      --suffix PATH : ${lib.makeBinPath [ xdg-utils ]}
  '';

  meta = with lib; {
    description = "Agentic Coding Platform for Real Software";
    homepage = "https://qoder.com";
    license = licenses.unfree;
    platforms = [ "x86_64-linux" ];
    mainProgram = "qoder";
  };
}
