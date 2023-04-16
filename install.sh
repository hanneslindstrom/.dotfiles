#!/usr/bin/env bash

# ------------------------------------------------------------------------------
# Basic Environment Setup

# Figure out where the dotfiles repo has been placed.
script_dir=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# Add a file for local environment customization (or append to it one exists).
echo "export DOTFILES=${script_dir}" >> $HOME/.zshenv

# ------------------------------------------------------------------------------
# Full Install

# Stow configuration files.
cd $script_dir/config/stow
stow --verbose --target $HOME *

# Install applications listed in the Brewfile.
brew bundle install --verbose --file=$script_dir/config/manual/homebrew/Brewfile
