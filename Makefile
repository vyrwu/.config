ROOT_DIR := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))

install:
	nix run nix-darwin -- switch --flake "${ROOT_DIR}nix-darwin"

check:
	darwin-rebuild check --flake "${ROOT_DIR}nix-darwin"

update-nixpkgs:
	@cd "${ROOT_DIR}nix-darwin"
	nix flake lock --update-input nixpkgs
	@cd "${ROOT_DIR}"

update-nix-darwin:
	@cd "${ROOT_DIR}nix-darwin"
	nix flake lock --update-input nix-darwin
	@cd "${ROOT_DIR}"

update-home-manager:
	@cd "${ROOT_DIR}nix-darwin"
	nix flake lock --update-input home-manager
	@cd "${ROOT_DIR}"

update:
	@cd "${ROOT_DIR}nix-darwin"
	nix flake update --flake "${ROOT_DIR}nix-darwin"
	@cd "${ROOT_DIR}"

preview:
	darwin-rebuild switch --flake "${ROOT_DIR}nix-darwin"

switch:
	darwin-rebuild switch --flake "${ROOT_DIR}nix-darwin" --commit-lock-file

