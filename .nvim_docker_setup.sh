#!/usr/bin/env bash

# Thanks ChatGPT for this!
# Docker-based nvim launcher with smart workspace detection (if set, else use system nvim)
# Supports `.nvim_workspace` files to define project root

NVIM_CONFIG_FILE="$HOME/.nvim_docker_choice"
NVIM_DOCKER_IMAGE="rbharadwaj9/nvim:latest"
WORKSPACE_MARKER_FILE=".nvim_workspace"

# Function to check if native nvim exists
check_nvim() {
  if command -v nvim &>/dev/null; then
    return 0
  fi
  return 1
}

# Find closest .nvim_workspace in parent dirs
find_nvim_workspace_file() {
    local dir="$1"
    while [[ "$dir" != "/" ]]; do
        if [[ -f "$dir/${WORKSPACE_MARKER_FILE}" ]]; then
            echo "$dir"
            return 0
        fi
        dir="$(dirname "$dir")"
    done
    return 1
}

# Fallback: find Git root
find_git_root() {
    git -C "$1" rev-parse --show-toplevel 2>/dev/null
}

# Main logic to resolve workspace root
resolve_workspace_root() {
    local dir="$1"

    if ws=$(find_nvim_workspace_file "$dir"); then
        echo "$ws"
    elif ws=$(find_git_root "$dir"); then
        echo "$ws"
    else
        echo ""
    fi
}

get_workspace_container_name() {
    local dir="$1"

    if [ -z "$dir" ]; then
        # Adhoc - no persistent container name
        echo ""
        return 0
    fi

    local prefix=$([[ -f "$dir/${WORKSPACE_MARKER_FILE}" ]] && echo "nvim_ws" || echo "nvim")
    echo "${prefix}_$(basename "$root_dir" | tr '[:upper:]' '[:lower:]' | tr -cd 'a-z0-9_')"
}


# Main Docker wrapper
nvim_docker_wrapper() {
    local current_dir="$(pwd)"
    local root_dir="$(resolve_workspace_root "$current_dir")"

    # Optional override: if `.nvim_workspace` has a name
    local container_name=$(get_workspace_container_name "$root_dir")

    if [ -z "${container_name}" ]; then
        # Ad-hoc container — always disposable
        docker run --rm -it \
            --mount type=bind,source="$current_dir",target=/root/workspace \
            --workdir /root/workspace \
            ${NVIM_DOCKER_IMAGE} "$@";
        return $?
    fi

    # Compute relative path from root
    local rel_path="${current_dir#$root_dir}"
    local container_cwd="/root/workspace$rel_path"

    if docker container inspect "$container_name" &>/dev/null; then
        if [[ "$(docker inspect -f '{{.State.Running}}' "$container_name")" == "true" ]]; then
            docker exec -w "$container_cwd" -it "$container_name" nvim "$@"
        else
            docker start -ai "$container_name"
        fi
    else
        docker run -it --name "$container_name" \
            --mount type=bind,source="$root_dir",target=/root/workspace \
            --workdir "$container_cwd" \
            ${NVIM_DOCKER_IMAGE} "$@"
    fi
}

setup_docker_nvim() {
  alias nvim='nvim_docker_wrapper'
}

# User choice setup
handle_missing_nvim() {
    if [ -f "$NVIM_CONFIG_FILE" ]; then
        choice=$(cat "$NVIM_CONFIG_FILE")
        if [[ "$choice" == "docker" ]]; then
            setup_docker_nvim
        fi
        return
    fi

    echo "Neovim not found. Use Docker image instead? (y/n)"
    read -r use_docker
    if [[ "$use_docker" =~ ^[Yy]$ ]]; then
        echo "docker" > "$NVIM_CONFIG_FILE"
        setup_docker_nvim
    else
        echo "manual" > "$NVIM_CONFIG_FILE"
        echo "You chose not to use Docker. Please install Neovim manually."
    fi
}

# Activate docker wrapper if needed
if ! check_nvim; then
    handle_missing_nvim
fi
