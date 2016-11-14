#
# Copyright (C) 2016 openwisp.org
#
# This is free software, licensed under the GNU General Public License v3.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=luci-theme-openwisp
PKG_VERSION:=$(shell cat ../VERSION)
PKG_RELEASE:=1
PKG_BUILD_DIR := $(BUILD_DIR)/$(PKG_NAME)/$(PKG_SOURCE_SUBDIR)
PKG_LICENSE:=GPL-3.0

include $(INCLUDE_DIR)/package.mk

define Package/luci-theme-openwisp
	SECTION:=luci
	CATEGORY:=LuCI
	SUBMENU:=4. Themes
	TITLE:=OpenWISP theme
	DEPENDS:=+luci-theme-bootstrap
	MAINTAINER:=Federico Capoano <f.capoano@cineca.it>
endef

define Package/luci-theme-openwisp/description
	OpenWISP theme for LuCI, based on the bootstrap theme.
endef

define Build/Compile
endef

define Package/luci-theme-openwisp/install
	$(INSTALL_DIR) \
		$(1)/usr/lib/lua/luci/view/themes/openwisp \
		$(1)/www/luci-static/openwisp

	$(CP) -r luasrc/view/themes/openwisp/* \
		$(1)/usr/lib/lua/luci/view/themes/openwisp/

	$(CP) -r htdocs/luci-static/openwisp/* \
		$(1)/www/luci-static/openwisp/
endef

$(eval $(call BuildPackage,luci-theme-openwisp))
