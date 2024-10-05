install:
	@nix run nix-darwin -- switch --flake ./nix-darwin

update:
	@darwin-rebuild switch --flake ~/.config/nix-darwin
