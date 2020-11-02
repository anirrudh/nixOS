let
  nixpkgs = import ./nixpkgs.nix;
  hmpkgs = import ./hmpkgs.nix;
  pkgs = import nixpkgs {
     config = { allowUnfree = true; };
     overlays = [ (import ./overlays/overlay.nix) (import ./overlays/awesome.nix) ];
  };
in

pkgs.mkShell {

  buildInputs = [ pkgs.nixops pkgs.home-manager ];

  # see README.org for usage

  shellHook = ''
    export NIX_PATH="nixpkgs=${nixpkgs}:.:nixpkgs-overlays=$PWD/overlays"
    export NIXOPS_STATE="./state.nixops"
    export NIXPKGS_ALLOW_UNFREE=1
    export HM_PATH="${hmpkgs}";
      '';
}
