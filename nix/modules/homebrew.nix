{ ... }:
{
  homebrew.enable = true;
  homebrew.casks = [
    "1password"
    "aws-vpn-client"
    "linear-linear"
    "amazon-workspaces"
    "crystalfetch"
  ];
  homebrew.brews = [
    "postgresql@17"
    "redis"
    "tmux"
    "overmind"
    "vips"
    "stripe/stripe-cli/stripe"
    "foreman"
    "overmind"
    "vite"
    "ruby"
    "ruby-lsp"
  ];
  homebrew.taps = [
    "stripe/stripe-cli"
  ];
}
