local cbi = require "luci.cbi"
local i18n = require "luci.i18n"
local uci = luci.model.uci.cursor()

local M = {}

function M.section(form)
  local s = form:section(cbi.SimpleSection, nil, i18n.translate(
    'You can provide your name and homepage here to '
      .. 'allow a link on the status page. Please note that '
      .. 'this information will be visible <em>publicly</em> '
      .. 'on the internet together with your node\'s coordinates.'
    )
  )

  local o
  
  o = s:option(cbi.Value, "_name", i18n.translate("Owner's name"))
  o.default = uci:get_first("gluon-node-info", "owner", "name", "")
  o.rmempty = true
  o.datatype = "string"
  o.description = i18n.translate("Owner name (e.g. Jane Doe)")
  o.maxlen = 40

  o = s:option(cbi.Value, "_homepage", i18n.translate("Owner's homepage"))
  o.default = uci:get_first("gluon-node-info", "owner", "homepage", "")
  o.rmempty = true
  o.datatype = "string"
  o.description = i18n.translate("Owner's homepage (e.g. http://example.com)")
  o.maxlen = 140
  
end

function M.handle(data)
  local sname = uci:get_first("gluon-node-info", "owner")
  
  if data._name ~= nil and data._homepage~= nil then
    uci:set("gluon-node-info", sname, "name", data._name)
    uci:set("gluon-node-info", sname, "homepage", data._homepage)
  else
    uci:delete("gluon-node-info", sname, "name")
    uci:delete("gluon-node-info", sname, "homepage")
  end
  uci:save("gluon-node-info")
  uci:commit("gluon-node-info")
end

return M