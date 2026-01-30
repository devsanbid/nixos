# Productivity & Office
{ pkgs, ... }: {

  environment.systemPackages = with pkgs; [
    # Office suites
    libreoffice
    onlyoffice-desktopeditors

    # File management
    xfce.thunar
    xfce.thunar-volman
    dua

    # Documents
    pandoc
    tesseract

    # Utilities
    libqalculate
    keypunch
    pipeline
    showtime

    # KDE apps
    kdePackages.kbackup
    kdePackages.kdevelop
    kdePackages.krdc
    kdePackages.kruler
    kdePackages.ktimer
    kdePackages.krecorder

    # RStudio with packages
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

    # Database tools
    mycli
    pgadmin4
    pgcli
    postgresql
    sqlitebrowser

    # Design
    bootstrap-studio
  ];
}
