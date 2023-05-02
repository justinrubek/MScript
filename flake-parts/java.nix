{inputs, ...}: {
  perSystem = {
    config,
    pkgs,
    system,
    inputs',
    self',
    ...
  }: let
    devTools = [
      self'.packages.ant
      self'.packages.jdk
      self'.packages.treefmt
    ];

    packages = rec {
      compiler-jar = pkgs.stdenv.mkDerivation {
        name = "mscript-jar";
        buildInputs = [
          self'.packages.ant
          self'.packages.jdk
          pkgs.unzip
        ];

        buildCommand = ''
          cp -r ${../.}/* .

          bash build.sh

          mkdir -p $out/bin
          cp MScript.jar $out/bin
        '';
      };

      compiler = pkgs.writeShellApplication {
        name = "mscript-compiler";
        runtimeInputs = [self'.packages.jdk];
        text = ''
          java -jar ${packages.compiler-jar}/bin/MScript.jar "$@"
        '';
      };
    };

    apps = {
      compile = {
        type = "app";
        program = packages.compiler;
      };
    };
  in rec {
    inherit packages apps;

    devShells.default = pkgs.mkShell rec {
      packages = devTools;
      LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath packages;
    };
  };
}
