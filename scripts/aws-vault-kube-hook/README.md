# AWS Vault Kube Hook

Automatically refresh EKS contexts when spawning an `aws-vault` shell.

## Requirements

- `aws-vault`
- `yq`

## Usage

### 1. Generate EKS config file

`discover-eks-clusters` script crawls through an AWS Organization to capture EKS
cluster data. This data is used by the script to update kubeconfigs of EKS
clusters relevant to the SSO role being assumed.

### 2. Source `av` command

Add the following to your shell bootstrap script (`~/zshrc`):

```bash
# Alias for aws-vault to automatically update kubeconfig on login
alias av='_aws_vault_kube_exec'

_aws_vault_kube_exec() {
  if [ -z "$1" ]; then
    echo "Usage: av <profile-name>"
    aws-vault list
    return 1
  fi

  # The AWS_VAULT variable is set by the aws-vault process itself.
  # We pass it as an argument to our hook script.
  aws-vault exec "$1" -- ~/.config/scripts/aws-vault-kube-hook/aws-vault-kube-hook "$1"
}
```

This will make the `av` command available, which replaces `aws-vault exec`, but
synchronizes kubeconfig with the EKS clusters in scope automatically.
