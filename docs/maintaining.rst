.. maintaining the tap

Maintaining the Tap
===================

This document covers how the tap is structured and how casks are updated.

Repository Layout
-----------------

.. code-block:: text

    homebrew-tap/
      Casks/
        bartleby.rb      # generated cask for the bartleby CLI
        reqtrace.rb      # generated cask for the reqtrace tool
      docs/
        index.rst
        usage.rst
        maintaining.rst

Homebrew requires the repository to be named ``homebrew-tap`` (the
``homebrew-`` prefix is how ``brew tap neuronsphere/tap`` resolves to
``neuronsphere/homebrew-tap``). Casks live under ``Casks/``.

Casks, Not Formulae
-------------------

These tools ship as **casks**. A Homebrew formula is meant to build software
from source; a cask installs a pre-built artifact. GoReleaser used to generate
formulae that simply unpacked a downloaded binary, and it deprecated that in
favour of casks — ``brews`` in a ``.goreleaser.yaml`` is a dead end.

The practical consequence: **casks are macOS-only.** Linux users install from
the release tarballs instead. If a tool ever needs to be installable through
Homebrew on Linux, it needs a real formula that builds from source, which is a
different piece of work.

How Casks Are Updated
---------------------

Casks in this tap are written **automatically** by GoReleaser as part of each
tool's release. When a new version is tagged:

1. GoReleaser cross-compiles and publishes tarballs to the tool's GitHub
   Releases page.

2. GoReleaser computes each tarball's sha256.

3. GoReleaser commits an updated ``Casks/<tool>.rb`` to this repository with
   the new version, URLs, and checksums.

The files carry a ``DO NOT EDIT`` header for that reason — the next release
overwrites them. To change something permanently, change the
``homebrew_casks`` section in the source repository's ``.goreleaser.yaml``.

Unsigned Binaries and Gatekeeper
--------------------------------

The binaries are not signed or notarized, so macOS quarantines them and
Gatekeeper refuses to run them. Each cask therefore carries a ``postflight``
hook that clears the quarantine attribute:

.. code-block:: ruby

    postflight do
      if OS.mac?
        system_command "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "#{staged_path}/bartleby"]
      end
    end

Without it, ``brew install`` succeeds and the tool dies on first run. This
comes from ``hooks.post.install`` in the GoReleaser config. Signing and
notarizing the binaries would remove the need for it.

One Release, Several Casks
--------------------------

``hmd-cli-bartleby`` publishes two casks from a single tag: ``bartleby`` and
``reqtrace``. Each ``homebrew_casks`` entry pins ``ids`` so it ships only its own
binary.

They are deliberately **not** one cask with two binaries. Two casks cannot both
link the same binary name, so bundling ``reqtrace`` into ``bartleby`` would make
installing it on its own impossible — and it exists separately precisely so a
project can take it without taking Bartleby or its BSL licence.

The cost of one tag: a cask version says which *Bartleby release* the tool came
from, not the tool's own module version. GoReleaser's per-module tag support is
Pro-only.

Adding a New Cask
-----------------

To distribute a new tool through this tap:

1. Add a ``homebrew_casks`` section to the tool's ``.goreleaser.yaml`` pointing
   at this repository:

   .. code-block:: yaml

       homebrew_casks:
         - repository:
             owner: neuronsphere
             name: homebrew-tap
           directory: Casks
           homepage: https://github.com/neuronsphere/<repo>
           description: "Short description of the tool"
           url:
             verified: github.com/neuronsphere/<repo>

2. Give the release workflow a ``HOMEBREW_TAP_GITHUB_TOKEN`` with write access
   to ``neuronsphere/homebrew-tap`` (see below).

3. Tag and release. GoReleaser creates the cask file.

Also set ``force_token: github`` in the config. GoReleaser chooses its release
provider from whichever token it finds in the environment, so a ``GITLAB_TOKEN``
exported for unrelated work is enough to make it treat the project as a GitLab
one and generate casks pointing at ``gitlab.com`` URLs that do not exist.

Authentication
--------------

GoReleaser authenticates to this repository with a GitHub token supplied as
``HOMEBREW_TAP_GITHUB_TOKEN``. In CI that comes from a repository secret
(``HOMEBREW_TAP_TOKEN``) in each source repository; the built-in
``GITHUB_TOKEN`` cannot be used, because it has no access outside the
repository it runs in.

The token needs ``repo`` scope while this tap is private, or ``public_repo`` if
it is public. A fine-grained token needs Contents: write on
``neuronsphere/homebrew-tap``. Rotate it periodically and update the secret in
every source repository that publishes here.
