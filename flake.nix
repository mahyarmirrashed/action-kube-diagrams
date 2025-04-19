{
  description = "Flake for github:mahyarmirrashed/action-kube-diagrams";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        pythonEnv = pkgs.python312.withPackages (ps: [ ps.pyyaml ps.diagrams ]);

        kube-diagrams = pkgs.stdenv.mkDerivation rec {
          pname = "kube-diagrams";
          version = "0.2.0";
          src = pkgs.fetchFromGitHub {
            owner = "philippemerle";
            repo = "KubeDiagrams";
            rev = "v${version}";
            hash = "sha256-mF0zL8D8bJ8BoaG43NLBwa+gwK6tHdiL+nGdtRfHj8Q=";
          };
          postPatch = ''
            substituteInPlace bin/kube-diagrams \
              --replace '/usr/bin/env python3' '${pythonEnv}/bin/python'
          '';
          installPhase = ''
            mkdir -p $out/bin
            cp -r bin/* $out/bin/
            chmod +x $out/bin/*-diagrams
          '';
        };
      in {
        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            git
            lazygit
            nodePackages.prettier
          ];
        };

        packages.default = pkgs.dockerTools.buildLayeredImage {
          name = "ghcr.io/mahyarmirrashed/kube-diagrams";
          tag = "latest";
          contents = with pkgs; [
            busybox
            cacert
            graphviz
            kubernetes-helm
            kube-diagrams
            pythonEnv
          ];
          created = "now";
        };
      }
    );
}
