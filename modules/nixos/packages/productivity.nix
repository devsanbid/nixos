# Productivity — office, file managers, databases
{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # ── Office ──────────────────────────────────────────────
    libreoffice
    onlyoffice-desktopeditors

    # ── File managers ───────────────────────────────────────
    thunar
    thunar-volman
    dua

    # ── Documents ───────────────────────────────────────────
    pandoc
    tesseract

    # ── Utilities ───────────────────────────────────────────
    libqalculate
    keypunch
    pipeline
    showtime

    # ── KDE apps ────────────────────────────────────────────
    kdePackages.kbackup
    kdePackages.kdevelop
    kdePackages.krdc
    kdePackages.kruler
    kdePackages.ktimer
    kdePackages.krecorder

    # ── R / Data Science ────────────────────────────────────
    (rstudioWrapper.override {
      packages = with pkgs.rPackages; [
        ggplot2
        dplyr
        xts
        tidyverse
        randomForest
        snakecase
      ];
    })

    # ── Database tools ──────────────────────────────────────
    mycli
    pgadmin4
    pgcli
    postgresql
    sqlitebrowser

    bootstrap-studio
  ];
}
