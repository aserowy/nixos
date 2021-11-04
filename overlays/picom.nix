final: prev: {
  picom = prev.picom.overrideAttrs (oldAttrs: rec {
    inherit (final.sources.picom) pname version src;
  });
}
