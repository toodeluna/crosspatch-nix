{
  inputs,
  lib,
  self,
  ...
}:
let
  version = "1.1.5";
in
{
  perSystem =
    { self', pkgs, ... }:
    let
      python = pkgs.python3.withPackages (pythonPackages: [
        pythonPackages.patool
        pythonPackages.py7zr
        pythonPackages.pyqtdarktheme
        pythonPackages.pyside6
        pythonPackages.rarfile
        pythonPackages.requests
      ]);
    in
    {
      # TODO: Make the parser work for this package. It seems to work fine without it
      # but it'd be nice if it didn't throw an error.
      packages.default = pkgs.writeShellApplication {
        name = "crosspatch";
        runtimeInputs = [ python ];
        text = ''python "${inputs.crosspatch}/src/CrossPatch.py"'';
        meta.description = "Mod loader for Sonic Racing Crossworlds";
      };

      packages.parser = pkgs.buildDotnetModule {
        inherit version;
        pname = "crosspatch-parser";
        src = "${inputs.crosspatch}/tools/CrossPatchParser";
        nugetDeps = "${self}/dependencies/nuget-dependencies.json";
      };

      apps.crosspatch = {
        type = "app";
        program = lib.getExe self'.packages.default;
      };
    };
}
