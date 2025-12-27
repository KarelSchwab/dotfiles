# Dotfiles

## Install devbox

```bash
curl -fsSL https://get.jetify.com/devbox | bash
```

## Run setup script

```bash
devbox run stow
```

## Install global packages

```bash
devbox global install
```

## Overview

This is a dotfiles manager written in Go that helps you manage your configuration files (dotfiles) and clone Git repositories. It uses symbolic links to keep your dotfiles in sync across systems while maintaining them in a centralized repository. It also supports cloning additional Git repos for tools, themes, or plugins.

## Features

- **Symlink Management**: Create and remove symbolic links for dotfiles.
- **Git Repo Cloning**: Clone configured Git repositories to specified directories.
- **Flexible Configuration**: JSON-based config for dotfiles and repos with environment variable expansion.
- **Selective Operations**: Target specific dotfiles or repos with flags.
- **Safety Checks**: Validates paths to prevent linking to root or home directories.
- **Devbox Integration**: Designed to work with Devbox for reproducible environments.

## Installation

### Using Devbox (Recommended)

Follow the steps above to install Devbox and set up the environment.

### Building from Source

If you prefer not to use Devbox:

1. Ensure you have Go installed (version 1.25.4 or later).
2. Clone this repository.
3. Build the binary:

```bash
go build -o dotfiles
```

4. Place the binary in your PATH or run it directly.

## Configuration

Create a `config.json` file in the project root. The config supports environment variable expansion (e.g., `$HOME`).

### Structure

```json
{
  "binDir": "$HOME/bin",
  "dotfiles": [
    {
      "name": "bashrc",
      "source": "bash/bashrc",
      "destination": "$HOME/.bashrc"
    },
    {
      "name": "vimrc",
      "source": "nvim/init.vim",
      "destination": "$HOME/.vimrc"
    }
  ],
  "repos": [
    {
      "name": "oh-my-zsh",
      "url": "https://github.com/ohmyzsh/ohmyzsh.git",
      "destination": "$HOME/.oh-my-zsh"
    }
  ]
}
```

- `binDir`: Directory for binary scripts (created automatically).
- `dotfiles`: Array of dotfile configs (name for reference, source relative to project root, destination absolute path).
- `repos`: Array of Git repo configs (name for reference, URL, destination path).

Paths are validated to ensure they are not empty, root (`/`), or your home directory for safety.

## Usage

All commands read from `config.json`. Run them from the project root.

### stow

Symlinks dotfiles from source to destination. Removes any existing files/links at the destination first.

```bash
# Stow all dotfiles
./dotfiles stow

# Stow specific dotfiles
./dotfiles stow --files bashrc,vimrc
```

Flags:
- `--files, -f`: Comma-separated list of dotfile names to stow.

### unstow

Removes symlinks for dotfiles.

```bash
# Unstow all dotfiles
./dotfiles unstow

# Unstow specific dotfiles
./dotfiles unstow --files bashrc
```

Flags:
- `--files, -f`: Comma-separated list of dotfile names to unstow.

### clone

Clones configured Git repositories.

```bash
# Clone all repos
./dotfiles clone

# Clone specific repos
./dotfiles clone --repos oh-my-zsh

# Skip certain repos
./dotfiles clone --skip oh-my-zsh

# Remove existing directories before cloning
./dotfiles clone --rm
```

Flags:
- `--repos`: Comma-separated list of repo names to clone (if specified, only these are cloned).
- `--skip`: Comma-separated list of repo names to skip.
- `--rm`: Remove existing directories at destination before cloning.

## Examples

### Setting Up Dotfiles

1. Configure your `config.json` with dotfiles.
2. Run `./dotfiles stow` to create symlinks.
3. Edit files in the repo; changes reflect immediately.

### Cloning Repos

1. Add repos to `config.json`.
2. Run `./dotfiles clone` to clone them.
3. If a directory exists, use `--rm` to overwrite.

### Full Setup Workflow

```bash
# Clone repos
./dotfiles clone

# Stow dotfiles
./dotfiles stow

# Install global packages
devbox global install
```

## Troubleshooting

- **Permission Denied**: Ensure you have write access to destination directories.
- **Destination Exists**: Use appropriate flags (e.g., `--rm` for clone) or remove manually.
- **Invalid Paths**: Check `config.json` for typos; paths cannot be root or home.
- **Git Clone Fails**: Verify URLs and network access; check for authentication if private repos.
- **Config Not Found**: Ensure `config.json` is in the current directory.

## Contributing/Development

- **Building**: Run `go build` to compile.
- **Linting**: Use `go fmt` and `go vet` for code quality.
- **Testing**: Add tests in `_test.go` files; run with `go test`.
- **Dependencies**: Managed via `go.mod`; uses Cobra for CLI, Viper for config, go-git for cloning.

For issues or contributions, please open a GitHub issue or PR.


