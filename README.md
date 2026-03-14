# dev-shell

Containerized development environment launcher.

## Help

```text
usage: dev-shell [-h] {run,attach,list,ls} ...

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
usage: dev-shell run [-h] [-n NAME] [--no-git] [-g] [--skip-git-check]
                     [-m DIR] [-w DIR] [-d DEST] [--no-theme] [--no-pass]
                     [--no-sessions] [--codex] [--claude]

options:
  -h, --help        show this help message and exit
  -n, --name NAME   Assign a name to the container
  --no-git          Do not mount Git
  -g, --write-git   Mount Git with write access
  --skip-git-check  Skip the Git repository check
  -m, --mount DIR   Mount a directory as read-only
  -w, --write DIR   Mount a directory as writable
  -d, --dest DEST   Mount target inside the container
  --no-theme        Do not forward theme-related environment variables
  --no-pass         Do not mount the pass store and GPG socket
  --no-sessions     Do not mount the sessions/projects for the agents
  --codex           Mount Codex credentials
  --claude          Mount Claude credentials
```

## `attach --help`

```text
usage: dev-shell attach [-h] [name]

positional arguments:
  name        Name of the container to open a shell in

options:
  -h, --help  show this help message and exit
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
