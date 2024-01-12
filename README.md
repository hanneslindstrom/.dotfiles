# Hannes's Dotfiles

My development setup :- )

## Mac Installation

Start by downloading and installing [HomeBrew](https://brew.sh/) and
[Git](https://formulae.brew.sh/formula/git). Clone this repo, then run the
`install.sh` script from a shell. Run Kitty and everything should be good to go.

## TODOs

- Add plugin installation steps to the installation script
  - Tmux and NeoVim
- Rework old Vim config
  - New one should be much more minimal
- Fix language server configurations
  - The Lua-LS is not working right
  - Clangd and Yaml-LS are a bit too tightly coupled with current local environments
- Add Alfred configuration file
- Find a replacement for Exa
- Add pip install step to installation script
  - Also make sure to append an updated PYTHONPATH to the .zshenv file
