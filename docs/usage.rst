.. using the tap

Using the Tap
=============

Adding the Tap
--------------

Register the NeuronSphere tap with Homebrew once:

.. code-block:: bash

    brew tap neuronsphere/tap

After tapping, any formula in this repository can be installed by name.

Available Formulae
------------------

bartleby
~~~~~~~~

Render reStructuredText documentation using Sphinx inside Docker.

.. code-block:: bash

    brew install bartleby

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

Upgrading
---------

.. code-block:: bash

    brew update
    brew upgrade bartleby

To check which version is installed:

.. code-block:: bash

    bartleby --help

Uninstalling
------------

.. code-block:: bash

    brew uninstall bartleby

To remove the tap entirely:

.. code-block:: bash

    brew untap neuronsphere/tap
