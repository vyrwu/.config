{
  inputs,
  username,
  ...
}:
{
  imports = [ inputs.sops-nix.homeManagerModules.sops ];
  sops = {
    defaultSopsFile = ./secrets.yaml;
    age = {
      sshKeyPaths = [
        "/Users/${username}/.ssh/id_ed25519"
      ];
      keyFile = "/Users/${username}/.config/sops/age/keys.txt";
    };
    secrets = {
      gemini_api_key = { };
      google_search_api_key = { };
      google_search_engine_id = { };
      gh_token = { };
    };
  };
}
