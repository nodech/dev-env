# dev-shell

Containerized development environment launcher.

## Help

```text
dev-shell [-h] {run,attach,list,ls} ...

Containerized development environment launcher

positional arguments:
  {run,attach,list,ls}
    run                 Start a new container session
    attach              Open a shell in the running container
    list (ls)           List containers

options:
  -h, --help            show this help message and exit
```

## `run --help`

```text
usage: dev-shell run [-h] [-n NAME] [--no-git] [-g] [-m DIR] [-w DIR]
                     [--skip-git-check] [-d DEST] [--no-theme] [--no-gpg]
                     [--no-pass] [--codex] [--claude]

options:
  -h, --help       show this help message and exit
  -n, --name NAME  Assign a name to the container
  --no-git         Do not mount Git
  -g, --write-git  Mount Git with write access
  --skip-git-check Skip the Git repository check
  -m, --mount DIR  Mount a directory as read-only
  -w, --write DIR  Mount a directory as writable
  -d, --dest DEST  Mount target inside the container
  --no-theme       Do not forward theme-related environment variables
  --no-gpg         Do not mount the GPG socket
  --no-pass        Do not mount the pass store
  --codex          Mount Codex credentials
  --claude         Mount Claude credentials
```

## `attach --help`

```text
usage: dev-shell attach [-h] [-n NAME]

options:
  -h, --help       show this help message and exit
  -n, --name NAME  Name of the container to open a shell in
```

## `list --help`

```text
usage: dev-shell list [-h] [--format FORMAT] [-a] [--root ROOT] [-q]

options:
  -h, --help       show this help message and exit
  --format FORMAT  Format output using Docker's template syntax.
  -a, --all        Do not limit results to the project root
  --root ROOT      Project root to filter by
  -q, --quiet      Display only container IDs
```
