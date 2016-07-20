#
# Copyright (C) 2016 openwisp.org
#
# This is free software, licensed under the GNU General Public License v3.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=luci-mod-openwisp
PKG_RELEASE:=1
PKG_BUILD_DIR := $(BUILD_DIR)/$(PKG_NAME)/$(PKG_SOURCE_SUBDIR)

include $(INCLUDE_DIR)/package.mk

define Package/luci-mod-openwisp
	SECTION:=luci
	CATEGORY:=LuCI
	SUBMENU:=2. Modules
	TITLE:=LuCI OpenWISP module
	DEPENDS:=+luci-base
	MAINTAINER:=Riccardo Bloise <r.bloise@cineca.it>
endef

define Package/luci-mod-openwisp/description
	OpenWISP configuration Web UI.
endef

define Build/Compile
endef

define Package/luci-mod-openwisp/conffiles
/etc/config/luci_openwisp
endef

define Package/luci-mod-openwisp/install
	$(INSTALL_DIR) \
		$(1)/etc/config \
		$(1)/usr/lib/lua/luci/controller/openwisp \
		$(1)/usr/lib/lua/luci/model/cbi/openwisp \
		$(1)/usr/lib/lua/luci/view/openwisp

	$(INSTALL_CONF) \
		files/luci_openwisp \
		$(1)/etc/config/luci_openwisp

	$(CP) -r files/luasrc/controller/openwisp/* \
		$(1)/usr/lib/lua/luci/controller/openwisp/

	$(CP) -r files/luasrc/model/cbi/openwisp/* \
		$(1)/usr/lib/lua/luci/model/cbi/openwisp/

	$(CP) -r files/luasrc/view/openwisp/* \
		$(1)/usr/lib/lua/luci/view/openwisp/
endef

$(eval $(call BuildPackage,luci-mod-openwisp))
