{...}: {
  perSystem = {pkgs, ...}: let
  in rec {
    packages = {
      jdk = pkgs.jdk11;
      ant = pkgs.ant;
    };
  };
}
