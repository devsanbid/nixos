{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./app
    ./enviroment
    ./package
    ./security
    ./style
    ./wm
  ];
}
