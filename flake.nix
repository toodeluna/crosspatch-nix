{
  description = "CrossPatch nixified";
  outputs = inputs: inputs.flake-parts.lib.mkFlake { inherit inputs; } ./nix;

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    systems.url = "github:nix-systems/default-linux";

    crosspatch = {
      url = "github:nickplayzgithub/crosspatch?ref=1.1.5";
      flake = false;
    };

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    treefmt = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
