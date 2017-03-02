Change log
^^^^^^^^^^

0.1.2 [2017-03-02]
==================

- `17a21a4 <https://github.com/openwisp/luci-openwisp/commit/17a21a4>`_:
  [makefile] added ``PKGARCH:=all`` in order to compile an architecture indipendent package
- `fd00c43 <https://github.com/openwisp/luci-openwisp/commit/fd00c43>`_:
  [docs] default compile instructions to to `LEDE <https://lede-project.org/>`_ 17.01

0.1.1 [2017-02-15]
==================

- `#2 <https://github.com/openwisp/luci-openwisp/issues/2>`_:
  [auth] Removed the need of redundant salt
- `6c87e7a <https://github.com/openwisp/luci-openwisp/commit/6c87e7a>`_:
  [Makefile] Added more SSL variants

0.1.0 [2016-11-21]
==================

- added custom password validator that allows to log in without supplying root user credentials
- added network settings page
- added status page
- added upgrade firmware page
- added reboot page
- added openwisp theme
- added meta-packages for easier installation:
    - ``luci-openwisp``
    - ``luci-openwisp-polarssl``
    - ``luci-openwisp-openssl``
