{ config, pkgs, ... }: {
  imports = [
    ./app
    ./dm
    ./enviroment
    ./package
    ./security
    ./style
    ./wm
  ];
}
