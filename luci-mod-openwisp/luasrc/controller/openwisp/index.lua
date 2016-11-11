module("luci.controller.openwisp.index", package.seeall)
require("uci")

function index()
	local root = node()
	if not root.lock then
		root.target = alias("openwisp")
		root.index = true
	end

	local page   = entry({"openwisp"}, alias("openwisp", "index"), _("OpenWISP setup"), 10)
	page.sysauth = "root"
	page.sysauth_authenticator = function(callback, user, pass)
		local http = require "luci.http"
		local user = http.formvalue("luci_username")
		local pass = http.formvalue("luci_password")
		local cursor = uci.cursor()
		local configured_username = cursor:get("luci_openwisp", "gui", "username")
		local configured_password = cursor:get("luci_openwisp", "gui", "password")

		if user == configured_username and pass == configured_password then
			return "root"
		end

		require("luci.i18n")
		require("luci.template")
		context.path = {}
		http.status(403, "Forbidden")
		luci.template.render("sysauth", {duser='operator', fuser=user})

		return false
	end
	page.ucidata = true
	page.index = true

	entry({"openwisp", "index"}, form("openwisp/index"), _("Home"), 1).index = true
end
