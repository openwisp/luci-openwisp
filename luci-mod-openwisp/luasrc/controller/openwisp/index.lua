module("luci.controller.openwisp.index", package.seeall)
require("uci")
require("nixio")

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
		local configured_username = cursor:get("luci_openwisp", "gui", "username") or ''
		local configured_password = cursor:get("luci_openwisp", "gui", "password") or ''
		local configured_salt = cursor:get("luci_openwisp", "gui", "salt") or ''
		local crypted = ''

		if user and pass then
			crypted = nixio.crypt(pass, "$1$"..configured_salt)
		end

		if user == configured_username and crypted == configured_password then
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

	entry({"openwisp", "index"}, template("openwisp/status/index"), _("Status"), 1).index = true
end
