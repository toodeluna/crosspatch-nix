{ self, withSystem, ... }:
{
  flake.overlays.default =
    final: prev:
    let
      self' = withSystem prev.stdenv.hostPlatform.system ({ self', ... }: self');
    in
    {
      crosspatch = self'.packages.default;
      crosspatch-parser = self'.packages.parser;
    };
}
