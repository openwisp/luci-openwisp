module("luci.controller.openwisp.settings", package.seeall)
require("uci")

function index()
	entry({"openwisp", "system"}, cbi("openwisp/system", {autoapply=true}), _("System"), 21)
	entry({"openwisp", "network"}, cbi("openwisp/network", {autoapply=true}), _("Network"), 22)
end
