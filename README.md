# dot-files

Personal dotfiles managed with [chezmoi](https://chezmoi.io).

## Bootstrap

Install chezmoi, then run:

```sh
chezmoi init --apply https://github.com/ahal/dot-files
```

You will be prompted for a few options:

- **Enable Mozilla configuration** — use Mozilla email, signing key, and related tools
- **Enable Watchman** — enable Watchman filesystem monitor integration

After answering, chezmoi will apply all dotfiles to your home directory.
