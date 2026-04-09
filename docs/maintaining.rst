.. maintaining the tap

Maintaining the Tap
===================

This document covers how the tap is structured and how formulae are updated.

Repository Layout
-----------------

.. code-block:: text

    homebrew-tap/
      Formula/
        bartleby.rb      # Homebrew formula for the bartleby CLI
      docs/
        index.rst
        usage.rst
        maintaining.rst

Homebrew requires the repository to be named ``homebrew-tap`` (the
``homebrew-`` prefix is how ``brew tap neuronsphere/tap`` resolves to
``neuronsphere/homebrew-tap``). Formulae live under ``Formula/``.

How Formulae Are Updated
-------------------------

Formulae in this tap are updated **automatically** by GoReleaser as part of
each tool's release pipeline. When a new version of ``bartleby`` is tagged
and released:

1. GoReleaser builds platform-specific tarballs and publishes them to the
   tool's GitHub Releases page.

2. GoReleaser computes the sha256 checksum of each tarball.

3. GoReleaser pushes an updated ``Formula/bartleby.rb`` to this repository
   with the new version, download URLs, and checksums.

No manual edits to the formula are required for routine releases. The
GoReleaser configuration that drives this lives in the source repository
(e.g., ``.goreleaser.yaml`` in ``hmd-cli-bartleby``).

Adding a New Formula
---------------------

To distribute a new tool through this tap:

1. Add a ``brews`` section to the tool's ``.goreleaser.yaml`` pointing at
   this repository:

   .. code-block:: yaml

       brews:
         - repository:
             owner: neuronsphere
             name: homebrew-tap
           directory: Formula
           homepage: https://github.com/neuronsphere/<repo>
           description: "Short description of the tool"

2. Ensure the release workflow has a ``HOMEBREW_TAP_GITHUB_TOKEN`` secret
   with ``repo`` scope on ``neuronsphere/homebrew-tap``.

3. Tag and release. GoReleaser will create the new formula file
   automatically.

Manual Formula Edits
---------------------

If you need to adjust a formula outside of the automated pipeline (for
example, adding a ``depends_on`` or changing the ``caveats`` text):

1. Edit the ``.rb`` file under ``Formula/``.
2. Test locally:

   .. code-block:: bash

       brew install --build-from-source Formula/bartleby.rb

3. Commit and push. The next automated release will overwrite the file, so
   also update the corresponding ``brews`` section in the source
   repository's ``.goreleaser.yaml`` to keep the change permanent.

Authentication
--------------

GoReleaser authenticates to this repository using a GitHub PAT stored as
``HOMEBREW_TAP_GITHUB_TOKEN`` in each source repository's secrets. This
token needs:

- ``repo`` scope (full control of private repositories) if this tap is
  private
- ``public_repo`` scope if this tap is public

Rotate the token periodically and update the secret in each source
repository that publishes to this tap.
