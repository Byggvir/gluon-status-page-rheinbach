local cbi = require "luci.cbi"
local i18n = require "luci.i18n"
local uci = luci.model.uci.cursor()

local M = {}

function M.section(form)
  local s = form:section(cbi.SimpleSection, nil, i18n.translate(
    'You can provide your homepage address here to '
      .. 'allow a link on the status page. Please note that '
      .. 'this information will be visible <em>publicly</em> '
      .. 'on the internet together with your node\'s coordinates.'
    )
  )

  local o = s:option(cbi.Value, "_homepage", i18n.translate("Homepage info"))
  o.default = uci:get_first("gluon-node-info", "owner", "homepage", "")
  o.rmempty = true
  o.datatype = "string"
  o.description = i18n.translate("Address of your homepage (http://example.com/freifunk)")
  o.maxlen = 140
end

function M.handle(data)
  if data._contact ~= nil then
    uci:set("gluon-node-info", uci:get_first("gluon-node-info", "owner"), "homepage", data._website)
  else
    uci:delete("gluon-node-info", uci:get_first("gluon-node-info", "owner"), "homepage")
  end
  uci:save("gluon-node-info")
  uci:commit("gluon-node-info")
end

return M
