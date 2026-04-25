# dev-shell

`dev-shell` starts and manages Docker-backed development shells for the current project.

## What It Does

- `run` starts a new container for the current project.
- `connect` opens a shell, runs a command, or attaches to an existing container.
- `list` and `ls` show matching containers.

Containers are labeled with project metadata so `connect` and `list` can filter by project root, project name, or project ID.

## Command Execution

Both `run` and `connect` only treat arguments after a literal `--` as the command to execute.

Examples:

```sh
dev-shell run -- pwd
dev-shell run -- npm test
dev-shell connect -- git status
dev-shell connect --raw -- bash
```

Without `--`, `run` starts the default shell and `connect` opens `zsh` in the target container.

## Notes

- `run` expects to be launched from inside a Git repository unless `--skip-git-check` is set.
- Extra `--mount` and `--write` paths must exist and must stay inside the project root.
- Agent credentials are only mounted when you opt into them with `--claude`, `--codex`, `--opencode`, or `--pi`.
- `--claude` and `--opencode` currently do not support `--pass`; use them with `--no-pass`.
- `--no-sessions` disables the per-project session mounts normally created for enabled agents.
- `list` defaults to the current project root when no explicit filters are provided.
- `connect` auto-selects the only matching running container; if multiple match, pass `--container` or add filters.

## Help

```text
usage: dev-shell [-h] {run,connect,list,ls} ...

Containerized development environment launcher

positional arguments:
  {run,connect,list,ls}
    run                 Start a new container session
    connect             Open a shell in the running container
    list (ls)           List containers

options:
  -h, --help            show this help message and exit
```

## `run --help`

```text
usage: dev-shell run [-h] [-n NAME] [-p PROJECT] [-i PROJECT_ID] [--no-git]
                     [-g] [--skip-git-check] [-m DIR] [-w DIR] [-d DEST]
                     [--no-theme] [--no-pass] [--no-sessions] [-r] [--codex]
                     [--claude] [--opencode] [--pi]
                     ...

positional arguments:
  exec                  Pass the cmd to run after --.

options:
  -h, --help            show this help message and exit
  -n, --name NAME       Assign a name to the container
  -p, --project PROJECT
                        Assign a custom project name to the container.
  -i, --project-id PROJECT_ID
                        Assign a custom project ID to the container.
  --no-git              Do not mount Git
  -g, --write-git       Mount Git with write access
  --skip-git-check      Skip the Git repository check
  -m, --mount DIR       Mount a directory as read-only
  -w, --write DIR       Mount a directory as writable
  -d, --dest DEST       Mount target inside the container
  --no-theme            Do not forward theme-related environment variables
  --no-pass             Do not mount the pass store and GPG socket
  --no-sessions         Do not mount the sessions/projects for the agents.
  -r, --raw             Do not nest cmd inside zsh
  --codex               Mount Codex credentials
  --claude              Mount Claude credentials
  --opencode            Mount OpenCode credentials
  --pi                  Mount PI credentials
```

## `connect --help`

```text
usage: dev-shell connect [-h] [-c CONTAINER] [--root ROOT] [-p PROJECT]
                         [-i PROJECT_ID] [--attach] [-r]
                         ...

positional arguments:
  exec                  Pass the cmd to execute on connect after --.

options:
  -h, --help            show this help message and exit
  -c, --container CONTAINER
                        Container name or ID to connect to directly. Overrides
                        filters.
  --root ROOT           Filter projects by root.
  -p, --project PROJECT
                        Filter projects by name.
  -i, --project-id PROJECT_ID
                        Filter projects by project ID.
  --attach              Attach directly to the container's primary process
                        instead of starting a shell.
  -r, --raw             Do not nest cmd inside zsh
```

## `list --help`

```text
usage: dev-shell list [-h] [--root ROOT] [-p PROJECT] [-i PROJECT_ID]
                      [--format FORMAT] [-a] [-q]

options:
  -h, --help            show this help message and exit
  --root ROOT           Filter projects by root.
  -p, --project PROJECT
                        Filter projects by name.
  -i, --project-id PROJECT_ID
                        Filter projects by project ID.
  --format FORMAT       Format output using Docker's template syntax.
  -a, --all             Do not limit results to the project root
  -q, --quiet           Display only container IDs
```

## Zsh Completion

The repository ships a completion file at [completions/_dev-shell](./completions/_dev-shell). The `Makefile` includes `make oh-my-zsh` and `make unoh-my-zsh` targets for installing or removing it from an Oh My Zsh setup.
