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
