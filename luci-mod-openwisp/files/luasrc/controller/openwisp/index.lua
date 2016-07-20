-- Copyright 2008 Steven Barth <steven@midlink.org>
-- Copyright 2008 Jo-Philipp Wich <jow@openwrt.org>
-- Licensed to the public under the Apache License 2.0.

module("luci.controller.openwisp.index", package.seeall)
require("uci")

function index()
	local root = node()
	if not root.lock then
		root.target = alias("openwisp")
		root.index = true
	end

	entry({"about"}, template("about"))

	local page   = entry({"openwisp"}, alias("openwisp", "index"), _("Installation"), 10)
	page.sysauth = "root"
	-- page.sysauth_authenticator = "htmlauth"
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
							  luci.template.render("sysauth", {duser=default, fuser=user})

							  return false
	end
	page.ucidata = true
	page.index = true



	entry({"openwisp", "index"}, alias("openwisp", "index", "index"), _("Overview"), 10).index = true
	entry({"openwisp", "index", "index"}, form("openwisp/index"), _("General"), 1).ignoreindex = true
	-- entry({"openwisp", "index", "luci"}, cbi("openwisp/luci", {autoapply=true}), _("Settings"), 10)
	entry({"openwisp", "index", "logout"}, call("action_logout"), _("Logout"))
end

function action_logout()
	local dsp = require "luci.dispatcher"
	local utl = require "luci.util"
	if dsp.context.authsession then
		utl.ubus("session", "destroy", {
			ubus_rpc_session = dsp.context.authsession
		})
		dsp.context.urltoken.stok = nil
	end

	luci.http.header("Set-Cookie", "sysauth=; path=" .. dsp.build_url())
	luci.http.redirect(luci.dispatcher.build_url())
end
