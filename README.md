# DotKit
>b
>y :  
>m
>u
>x
>x
>e
>_
> <3


##### A fully automated system toolkit for Fedora and Ubuntu that configures your machine into a powerful, personalized development and daily driver environment. It installs packages, sets up your preferred window manager, applies your dotfiles, and integrates additional tools — all in one go.

## Features

- 🔄 Automated system updates
- 📦 Package installation by categories:
  - Core system utilities
  - Window manager and desktop tools
  - Development tools
  - Fonts
  - Applications
  - Audio packages
- ⚙️ Automatic service configuration and enabling
- 🗃️ Dotfile installation and management using GNU Stow
- 💥 Tmux Plugin Manager automatic setup
- 🎮 Flatpak integration for specific applications
- 🧑‍💻 Supports both Fedora (dnf) and Ubuntu (apt) — auto-detects and uses the correct package manager
- ⚡ Optional `--dev-only` flag to install only essential dev packages

## Prerequisites

> \- A fresh Fedora or Ubuntu installation\
> \- Internet connection\
> \- `git` installed manually before running (e.g., `sudo dnf install git` or `sudo apt install git`)\
> \- SSH key added to GitHub if using private dotfile repo

## Installation

1.  Clone this repository:

        git clone git@github.com:muxx3/dotkit.git
        cd dotkit


2.  Run the setup script:

        bash run.sh

        (Optional) If you only want development essentials, run:

        bash run.sh --dev-only

3. Sit back and relax! The script will:

        Update your system

        Install all selected packages

        Enable needed services

        Clone and stow your dotfiles

        Install Tmux Plugin Manager

        Install Flatpaks

4. Once complete, reboot to enjoy your freshly crafted setup.

## How it works

> Dotkit uses a modular, easily extensible architecture inspired by Typecraft’s Crucible project. The main `run.sh` script orchestrates everything and sources smaller shell scripts:

--
    `utils.sh` — Common helper functions and package manager detection
--
    `install-dotfiles.sh` — Clones and stows your dotfiles
--
    `install-tpm.sh` — Installs Tmux Plugin Manager
--
    `install-flatpaks.sh` — Installs select Flatpak apps

>Your packages are organized into logical categories in `packages.conf`, making them easy to customize.

## Contributing
Contributions and suggestions are welcome! Feel free to fork this repository and submit pull requests.

