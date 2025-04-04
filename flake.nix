{
  description = "Flake for github:mahyarmirrashed/action-kube-diagrams";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
  };

  outputs = { self, nixpkgs }: {
    devShells.aarch64-darwin.default = let
      pkgs = nixpkgs.legacyPackages.aarch64-darwin;
    in
      pkgs.mkShell {
        packages = with pkgs; [
          git
          lazygit

          nodejs_20
          nodePackages.prettier
        ];
      };
  };
}