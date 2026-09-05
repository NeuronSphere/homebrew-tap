# NeuronSphere Homebrew Tap

Pre-built NeuronSphere command-line tools for macOS.

## bartleby

Render reStructuredText documentation with Sphinx, inside Docker.

```bash
brew install neuronsphere/tap/bartleby
```

Docker (or [Colima](https://github.com/abiosoft/colima)) must be running when
you build documentation. See
[hmd-cli-bartleby](https://github.com/neuronsphere/hmd-cli-bartleby) for usage.

## reqtrace

Generate and check a requirements traceability matrix from sphinx-needs
directives and test annotations.

```bash
brew install neuronsphere/tap/reqtrace
```

Needs nothing else installed — no Docker, no Python, nothing outside the Go
standard library. Licensed Apache-2.0, separately from bartleby, so a project
can adopt the requirements practice without adopting bartleby. Run
`reqtrace -check` in a repository with requirements in `docs/requirements/`.

## Notes

Tools here ship as **casks** — pre-compiled binaries rather than
built-from-source formulae — so they install on macOS only. On Linux, take the
tarball from the tool's GitHub Releases page or build from source.

`docs/` covers [using the tap](docs/usage.rst) and
[maintaining it](docs/maintaining.rst).
