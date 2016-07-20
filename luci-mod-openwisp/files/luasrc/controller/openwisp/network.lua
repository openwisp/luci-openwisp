-- Copyright 2008 Steven Barth <steven@midlink.org>
-- Copyright 2008 Jo-Philipp Wich <jow@openwrt.org>
-- Licensed to the public under the Apache License 2.0.

module("luci.controller.openwisp.network", package.seeall)

function index()
	entry({"openwisp", "network"}, alias("openwisp", "network", "index"), _("Network"), 20).index = true
	entry({"openwisp", "network", "index"}, cbi("openwisp/network", {autoapply=true}), _("General"), 1)
--	entry({"openwisp", "network", "wifi"}, cbi("openwisp/wifi", {autoapply=true}), _("Wireless"), 10)
	entry({"openwisp", "network", "dhcp"}, cbi("openwisp/dhcp", {autoapply=true}), _("DHCP"), 20)
end
