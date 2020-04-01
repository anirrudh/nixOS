{ pkgs ? import <nixpkgs> {} }:

let
  myEmacs = pkgs.emacs;
  emacsWithPackages = (pkgs.emacsPackagesGen myEmacs).emacsWithPackages;
in
  emacsWithPackages (epkgs: (with epkgs.melpaStablePackages; [
    dracula-theme	# ; Dracula Theme
    nix-mode		# ; nix configuration editing
    python-mode		# ; Python Major Mode!
    typescript-mode	# ; Typescript
  ]) ++ (with epkgs.melpaPackages; [
 
  ]) ++ (with epkgs.elpaPackages; [
    beacon
    undo-tree
  ]) ++ [
    pkgs.notmuch
  ]) 
