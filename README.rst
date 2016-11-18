=============
LuCI OpenWISP
=============

.. image:: https://ci.publicwifi.it/buildStatus/icon?job=luci-openwisp

.. image:: http://img.shields.io/github/release/openwisp/luci-openwisp.svg

------------

LuCI (OpenWRT Web Interface) customizations for the OpenWISP project.

.. image:: http://netjsonconfig.openwisp.org/en/latest/_images/openwisp.org.svg
  :target: http://openwisp.org

.. contents:: **Table of Contents**:
 :backlinks: none
 :depth: 3

------------

Features
--------

* login with a different username and password combination than the root SSH password
* possibility to edit LAN settings
* status page (inherited from ``luci-admin-full``)
* upgrade firmware page
* reboot
* logout
* meta-packages for easier installation:
    * ``luci-openwisp``
    * ``luci-openwisp-polarssl`` with HTTPs support
    * ``luci-openwisp-openssl`` with HTTPs support

Install precompiled package
---------------------------

First run:

.. code-block:: shell

    opkg update

Then install one of the `latest builds <http://downloads.openwisp.org/luci-openwisp/>`_:

.. code-block:: shell

    opkg install <URL>

Where ``<URL>`` is the URL of the image that is suitable for your case.

For a list of the latest built images, take a look at `downloads.openwisp.org
<http://downloads.openwisp.org/luci-openwisp/>`_.

If the SoC or OpenWRT (or LEDE) version you are using is not available, you have to compile the package,
(see `Compiling luci-openwisp`_).

Configuration options
---------------------

UCI configuration options must go in ``/etc/config/luci_openwisp``.

- ``username``: username for the web interface, defaults to ``operator``
- ``password``: encrypted password for the web interface, defaults ``password`` (encrypted)
- ``salt``: salt used during encryption, defaults to ``openwisp``

Change web UI password
----------------------

To change the default password for the web UI, use the ``openwisp-passwd`` script::

    openwisp-passwd
    Changing password for luci-mod-openwisp, username: operator
    New password:
    secret
    Retype password:
    secret
    luci-mod-openwisp password for user operator changed successfully

Compiling luci-openwisp
-----------------------

There are 3 variants of *luci-openwisp*:

- **luci-openwisp**:
- **luci-openwisp-openssl**: adds support for HTTPs and depends *libopenssl*
- **luci-openwisp-polarssl**: adds support for HTTPs and depends on *libpolarssl*

The following procedure illustrates how to compile the different packages in this repository:

.. code-block:: shell

    git clone git://git.openwrt.org/openwrt.git --depth 1
    cd openwrt

    # configure feeds
    cp feeds.conf.default feeds.conf
    echo "src-git openwisp https://github.com/openwisp/luci-openwisp.git" >> feeds.conf
    ./scripts/feeds update -a
    ./scripts/feeds install -a
    # replace with your desired arch target
    arch="ar71xx"
    echo "CONFIG_TARGET_$arch=y" > .config;
    echo "CONFIG_PACKAGE_luci-openwisp-polarssl=y" >> .config
    make defconfig
    make tools/install
    make toolchain/install
    make package/luci-mod-openwisp/compile
    make package/luci-mod-openwisp/install
    make package/luci-theme-openwisp/compile
    make package/luci-theme-openwisp/install
    make package/luci-openwisp/compile
    make package/luci-openwisp/install
    make package/luci-openwisp-polarssl/compile
    make package/luci-openwisp-polarssl/install
    make package/luci-openwisp-openssl/compile
    make package/luci-openwisp-openssl/install

Alternatively, you can configure your build interactively with ``make menuconfig``, in this case
you will need to select the *luci-openwisp* variant by going to ``Luci > 1. Collections``:

.. code-block:: shell

    git clone git://git.openwrt.org/openwrt.git --depth 1
    cd openwrt

    # configure feeds
    cp feeds.conf.default feeds.conf
    echo "src-git openwispluci https://github.com/openwisp/luci-openwisp.git" >> feeds.conf
    ./scripts/feeds update -a
    ./scripts/feeds install -a
    make menuconfig
    # go to Luci > 1. Collections and select one of the variants

Changelog
---------

See `CHANGELOG <https://github.com/openwisp/luci-openwisp/blob/master/CHANGELOG.rst>`_.

License
-------

See `LICENSE <https://github.com/openwisp/luci-openwisp/blob/master/LICENSE>`_.

Support
-------

Send questions to the `OpenWISP Mailing List <https://groups.google.com/d/forum/openwisp>`_.
