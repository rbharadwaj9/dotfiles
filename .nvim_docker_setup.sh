#!/usr/bin/env bash

# Thanks ChatGPT for this!
# Simple script sourced by the shell to see if a given machine would like to run nvim via docker or manually.
# In case of docker, a new container is created for every unique workspace we start working from.
# TODO: Maybe the workspace can be based on whether it's in a git repo or not to reduce subfolder duplicates but this is not a priority

# Config file to store user choice
NVIM_CONFIG_FILE="$HOME/.nvim_docker_choice"

# Function to check if native nvim exists
check_nvim() {
  if command -v nvim &>/dev/null; then
    return 0
  fi
  return 1
}

# Function to alias nvim to docker wrapper
setup_docker_nvim() {
  alias nvim='nvim_docker_wrapper'
}

# Docker-based nvim wrapper function
nvim_docker_wrapper() {
  local current_dir
  current_dir=$(pwd)
  local container_name
  # TODO: Maybe this can be hashed to prevent same named directories from clashing
  container_name="nvim_$(basename "$current_dir" | tr '[:upper:]' '[:lower:]' | tr -cd 'a-z0-9_')"

  # Check if container exists
  if docker container inspect "$container_name" &>/dev/null; then
    # Check if it's running
    if [[ "$(docker inspect -f '{{.State.Running}}' "$container_name")" == "true" ]]; then
      docker exec -it "$container_name" nvim "$@"
    else
      docker start -ai "$container_name"
    fi
  else
    docker run -it --name "$container_name" \
      --mount type=bind,source="$current_dir",target=/root/workspace \
      --workdir /root/workspace \
      rbharadwaj9/nvim:latest "$@"
  fi
}

# Handle case where nvim isn't installed
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

# === MAIN EXECUTION ===
if ! check_nvim; then
  handle_missing_nvim
fi
