{
  inputs,
  lib,
  self,
  ...
}:
let
  name = "crosspatch";
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

      # TODO: Make the parser work for this package. It seems to work fine without it
      # but it'd be nice if it didn't throw an error.
      script = pkgs.writeShellApplication {
        inherit name;
        runtimeInputs = [ python ];
        text = ''python "${inputs.crosspatch}/src/CrossPatch.py"'';
      };

      desktopItem = pkgs.makeDesktopItem {
        inherit name;
        desktopName = "Crosspatch";
        exec = lib.getExe script;
      };
    in
    {
      packages.default = pkgs.symlinkJoin {
        inherit name;
        meta.description = "Mod loader for Sonic Racing Crossworlds";

        paths = [
          script
          desktopItem
        ];
      };

      packages.parser = pkgs.buildDotnetModule {
        inherit version;
        pname = "${name}-parser";
        src = "${inputs.crosspatch}/tools/CrossPatchParser";
        nugetDeps = "${self}/dependencies/nuget-dependencies.json";
      };

      apps.crosspatch = {
        type = "app";
        program = lib.getExe self'.packages.default;
      };
    };
}
