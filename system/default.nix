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
    ./wm
  ];
}
