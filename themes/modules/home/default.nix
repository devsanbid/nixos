# Home-Manager modules — all user-level configuration
{ ... }:

{
  imports = [
    ./desktop
    ./shell
    ./terminal
    ./apps
    ./dev
    ./theming
  ];
}
