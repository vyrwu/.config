ROOT_DIR := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))

all: update check switch

install:
	nix run --extra-experimental-features 'nix-command flakes' nix-darwin -- switch --flake "${ROOT_DIR}nix-darwin"
check:
	darwin-rebuild check --flake .

update-nixpkgs:
	nix flake lock --update-input nixpkgs

update-nix-darwin:
	nix flake lock --update-input nix-darwin

update-home-manager:
	nix flake lock --update-input home-manager

update:
	nix flake update --flake .

preview:
	darwin-rebuild switch --flake .

switch:
	darwin-rebuild switch --flake . --commit-lock-file

