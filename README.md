# Crosspatch Nix

A Nix flake that packages [Crosspatch](https://gamebanana.com/tools/20804), a
mod loader for [Sonic Racing Crossworlds](https://www.sega.com/sonic-the-hedgehog/sonic-racing-crossworlds).

To use it, simply add this flake as an input to your own flake and use the
overlays to add the package to your own configuration:

```nix
{ inputs, ... }:
{
  nixpkgs.overlays = [ inputs.crosspatch.overlays.default ];
  environment.systemPackages = [ pkgs.crosspatch ];
}
```
