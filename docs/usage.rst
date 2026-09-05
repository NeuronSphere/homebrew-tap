.. using the tap

Using the Tap
=============

Installing
----------

One command — it registers the tap and installs the tool:

.. code-block:: bash

    brew install neuronsphere/tap/bartleby

The ``neuronsphere/tap`` prefix is the tap path, and it is required: these
tools are not in Homebrew core, so a bare ``brew install bartleby`` will not
find them. Tapping first with ``brew tap neuronsphere/tap`` and then installing
by name works too, but there is no reason to make it two steps.

macOS only
----------

Tools in this tap are distributed as `casks
<https://docs.brew.sh/Cask-Cookbook>`_ — pre-compiled binaries — and Homebrew
supports casks on macOS only. On Linux, download the tarball from the tool's
GitHub Releases page or build from source; ``hmd-cli-bartleby`` publishes
``linux/amd64`` and ``linux/arm64`` binaries with every release.

Available Casks
---------------

bartleby
~~~~~~~~

Render reStructuredText documentation using Sphinx inside Docker.

**Requirements:** Docker (or `Colima <https://github.com/abiosoft/colima>`_)
must be running when you execute builds. Bartleby launches a container from
the ``hmd-tf-bartleby`` image to perform Sphinx rendering.

**Quick start:**

.. code-block:: bash

    cd /path/to/your-docs-repo
    bartleby html            # render HTML
    bartleby pdf             # render PDF
    bartleby                 # render all configured formats

See the `hmd-cli-bartleby documentation
<https://github.com/neuronsphere/hmd-cli-bartleby>`_ for full usage details.

reqtrace
~~~~~~~~

Generate and check a requirements traceability matrix from sphinx-needs
directives and test annotations.

.. code-block:: bash

    brew install neuronsphere/tap/reqtrace

**Requirements:** none. It needs nothing outside the Go standard library — no
Docker, no Python — which is the point: it is licensed Apache-2.0 separately
from ``bartleby``, so a project can adopt the requirements practice without
adopting Bartleby or a BSL dependency.

**Quick start:**

.. code-block:: bash

    cd /path/to/a-repo-with-requirements
    reqtrace              # regenerate docs/requirements/traceability.rst
    reqtrace -check       # fail on a gap or stale output; for CI
    reqtrace -version

Both tools ship from the same ``hmd-cli-bartleby`` release, so their cask
versions move together. Installing one does not install the other.

Upgrading
---------

.. code-block:: bash

    brew update
    brew upgrade --cask bartleby

To see the installed version:

.. code-block:: bash

    bartleby --version

Uninstalling
------------

.. code-block:: bash

    brew uninstall --cask bartleby

To remove the tap entirely:

.. code-block:: bash

    brew untap neuronsphere/tap
