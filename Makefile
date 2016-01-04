include $(TOPDIR)/rules.mk

PKG_NAME:=gluon-site-page-rheinbach
PKG_VERSION:=1
PKG_RELEASE:=1

PKG_BUILD_DIR := $(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Package/gluon-status-page-rheinbach
  SECTION:=gluon
  CATEGORY:=Gluon
  TITLE:=Adds a status page showing information about the node for FF-RHB.
  DEPENDS:=+gluon-core +gluon-neighbour-info +gluon-status-page uhttpd
endef

define Package/gluon-status-page-rheinbach/description
	Adds a status page showing information about the node for FF-RHB.
	Especially useful in combination with the next-node feature.
	Shows additional information about the provider of the node.
endef

define Build/Prepare
	mkdir -p $(PKG_BUILD_DIR)
endef

define Build/Configure
endef

define Build/Compile
endef

define Package/gluon-status-page-rheinbach/install
	$(CP) ./files/* $(1)/
endef

$(eval $(call BuildPackage,gluon-status-page-rheinbach))
