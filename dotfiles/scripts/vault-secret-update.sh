#!/bin/bash

vault_secret_update() {
    # Function to put secrets to Vault and then get them
    # Arguments:
    #   $1: Path to put secrets in Vault
    #   $2: Path to the secrets file

    local path="$1"
    local secrets_file="$2"

    # Check if secrets file exists
    if [ ! -f "$secrets_file" ]; then
        echo "Secrets file not found: $secrets_file"
        return 1
    fi

    # Construct the vault kv put command
    local put_cmd="vault kv put $path $(yq -r '.' "$secrets_file" | jq -r 'to_entries[] | "\(.key)=\"\(.value)\""' | tr '\n' ' ')"

    # Execute the vault kv put command
    # echo "Executing command: $put_cmd"
    eval "$put_cmd"

    # Split the provided path into mount and path
    local mount="$(echo "$path" | cut -d '/' -f1)"
    local remaining_path="$(echo "$path" | cut -d '/' -f2-)"

    # Construct the vault kv get command
    local get_cmd="vault kv get -mount=\"$mount\" \"$remaining_path\""

    # Execute the vault kv get command
    # echo "Executing command: $get_cmd"
    eval "$get_cmd"
}

# Check if correct number of arguments are provided
if [ "$#" -ne 2 ]; then
    echo "Usage: vault_secret_update <path_to_put_secrets> <secrets_file>"
    exit 1
fi

vault_secret_update "$1" "$2"
