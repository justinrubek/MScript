{
  description = "Compiler for stationeers MIPS";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    nix-filter.url = "github:numtide/nix-filter";
    pre-commit-hooks.url = "github:cachix/pre-commit-hooks.nix";
  };

  outputs = inputs:
    inputs.flake-parts.lib.mkFlake {inherit inputs;} {
      systems = ["x86_64-linux" "aarch64-linux"];
      imports = [
        inputs.pre-commit-hooks.flakeModule

        ./flake-parts/java.nix
        ./flake-parts/toolchain.nix
        ./flake-parts/pre-commit.nix
        ./flake-parts/formatting.nix
      ];
    };
}
