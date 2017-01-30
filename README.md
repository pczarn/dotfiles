## dotfiles

Install by cloning to a directory.
```bash
echo ".piotrconfig" >> .gitignore
git clone --bare git@github.com:pczarn/dotfiles.git $HOME/.cfg
```
Backing up conflicting files
```bash
mkdir -p .config-backup && \
config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | \
xargs -I{} mv {} .config-backup/{}
```

