-- Copyright 2008 Steven Barth <steven@midlink.org>
-- Copyright 2008 Jo-Philipp Wich <jow@openwrt.org>
-- Licensed to the public under the Apache License 2.0.

local wa  = require "luci.tools.webadmin"
local sys = require "luci.sys"
local fs  = require "nixio.fs"

local has_pptp  = fs.access("/usr/sbin/pptp")
local has_pppoe = fs.glob("/usr/lib/pppd/*/rp-pppoe.so")()

local network = luci.model.uci.cursor_state():get_all("network")

local netstat = sys.net.deviceinfo()
local ifaces = {}

for k, v in pairs(network) do
	if v[".type"] == "interface" and k ~= "loopback" then
		table.insert(ifaces, v)
	end
end

m = Map("network", translate("Network"))
s = m:section(Table, ifaces, translate("Status"))
s.parse = function() end

s:option(DummyValue, ".name", translate("Network"))

hwaddr = s:option(DummyValue, "_hwaddr",
 translate("<abbr title=\"Media Access Control\">MAC</abbr>-Address"), translate("Hardware Address"))
function hwaddr.cfgvalue(self, section)
	local ix = self.map:get(section, "ifname") or ""
	local mac = fs.readfile("/sys/class/net/" .. ix .. "/address")

	if not mac then
		mac = luci.util.exec("ifconfig " .. ix)
		mac = mac and mac:match(" ([A-F0-9:]+)%s*\n")
	end

	if mac and #mac > 0 then
		return mac:upper()
	end

	return "?"
end


s:option(DummyValue, "ipaddr", translate("<abbr title=\"Internet Protocol Version 4\">IPv4</abbr>-Address"))

s:option(DummyValue, "netmask", translate("<abbr title=\"Internet Protocol Version 4\">IPv4</abbr>-Netmask"))


txrx = s:option(DummyValue, "_txrx",
 translate("Traffic"), translate("transmitted / received"))

function txrx.cfgvalue(self, section)
	local ix = self.map:get(section, "ifname")

	local rx = netstat and netstat[ix] and netstat[ix][1]
	rx = rx and wa.byte_format(tonumber(rx)) or "-"

	local tx = netstat and netstat[ix] and netstat[ix][9]
	tx = tx and wa.byte_format(tonumber(tx)) or "-"

	return string.format("%s / %s", tx, rx)
end

errors = s:option(DummyValue, "_err",
 translate("Errors"), translate("TX / RX"))

function errors.cfgvalue(self, section)
	local ix = self.map:get(section, "ifname")

	local rx = netstat and netstat[ix] and netstat[ix][3]
	local tx = netstat and netstat[ix] and netstat[ix][11]

	rx = rx and tostring(rx) or "-"
	tx = tx and tostring(tx) or "-"

	return string.format("%s / %s", tx, rx)
end

s = m:section(NamedSection, "lan", "interface", translate("Local Network"))
s.addremove = false

p = s:option(ListValue, "proto", translate("Protocol"))
p.override_values = true
p:value("static", translate("Static IP"))
p:value("dhcp", translate("DHCP client"))

ip = s:option(Value, "ipaddr", translate("<abbr title=\"Internet Protocol Version 4\">IPv4</abbr>-Address"))
ip:depends("proto", "static")

nm = s:option(Value, "netmask", translate("<abbr title=\"Internet Protocol Version 4\">IPv4</abbr>-Netmask"))
nm:depends("proto", "static")
nm:value("255.255.255.0")
nm:value("255.255.0.0")
nm:value("255.0.0.0")

gw = s:option(Value, "gateway", translate("<abbr title=\"Internet Protocol Version 4\">IPv4</abbr>-Gateway") .. translate(" (optional)"))
gw:depends("proto", "static")
gw.rmempty = true

dns = s:option(Value, "dns", translate("<abbr title=\"Domain Name System\">DNS</abbr>-Server") .. translate(" (optional)"))
dns:depends("proto", "static")
dns.rmempty = true

return m
