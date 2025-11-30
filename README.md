# Install devbox

```bash
curl -fsSL https://get.jetify.com/devbox | bash
```

# Load devbox shell

```bash
devbox shell
```

# Run stow

```bash
stow --dotfiles -t "$HOME" devbox bash git scripts tmux -v
```

# Install global packages

```bash
devbox global install
```

# Clone nvim

```bash
git submodule update --init --recursive
```

# Login to gh
```bash
gh auth login
```

# Stow nvim
```bash
stow --dotfiles -t "$HOME" nvim -v
```
