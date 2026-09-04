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

## Notes

Tools here ship as **casks** — pre-compiled binaries rather than
built-from-source formulae — so they install on macOS only. On Linux, take the
tarball from the tool's GitHub Releases page or build from source.

`docs/` covers [using the tap](docs/usage.rst) and
[maintaining it](docs/maintaining.rst).
