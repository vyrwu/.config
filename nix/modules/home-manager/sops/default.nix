{
  inputs,
  username,
  ...
}:
{
  imports = [ inputs.sops-nix.homeManagerModules.sops ];
  sops = {
    defaultSopsFile = ./secrets.yaml;
    defaultSopsFormat = "yaml";
    age = {
      sshKeyPaths = [
        "/Users/${username}/.ssh/sops_ed25519"
      ];
      keyFile = "/Users/${username}/.config/sops/age/keys.txt";
    };
    secrets.avante_gemini_api_key = { };
    secrets.google_search_api_key = { };
    secrets.google_search_engine_id = { };
  };
}
