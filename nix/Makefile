ROOT_DIR := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))

all: update check switch

install:
	nix --extra-experimental-features 'nix-command flakes' run nix-darwin/master#darwin-rebuild -- switch --flake .

check:
	darwin-rebuild check --flake . --impure

update-nixpkgs:
	nix flake lock --update-input nixpkgs

update-nix-darwin:
	nix flake lock --update-input nix-darwin

update-home-manager:
	nix flake lock --update-input home-manager

update:
	nix --extra-experimental-features 'nix-command flakes' flake update --flake . --impure

preview:
	darwin-rebuild switch --flake . --impure

switch:
	darwin-rebuild switch --flake . --commit-lock-file --impure

