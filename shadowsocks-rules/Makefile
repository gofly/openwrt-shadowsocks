include $(TOPDIR)/rules.mk

PKG_NAME:=shadowsocks-rules
PKG_VERSION:=1.0.0
PKG_RELEASE:=1
PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk

define Package/shadowsocks-rules
	SECTION:=net
	CATEGORY:=Network
	TITLE:=Lightweight Secured Socks5 Proxy
	URL:=https://github.com/gofly/openwrt-shadowsocks
	DEPENDS:=+kmod-nft-socket +kmod-nft-tproxy
endef

define Package/shadowsocks-rules/description
	Shadowsocks is a lightweight secured socks5 proxy for embedded devices and low end boxes.
endef

define Build/Prepare
	$(Build/Prepare/Default)
	rm -rf $(PKG_BUILD_DIR)/root
	cp -r ./root $(PKG_BUILD_DIR)/root
endef

define Build/Compile

endef

define Package/shadowsocks-rules/install
	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_CONF) $(PKG_BUILD_DIR)/root/etc/config/shadowsocks $(1)/etc/config
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/root/etc/init.d/shadowsocks $(1)/etc/init.d
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/root/usr/bin/ss-rules $(1)/usr/bin
	$(INSTALL_DIR) $(1)/usr/share/shadowsocks
	# https://raw.githubusercontent.com/mayaxcn/china-ip-list/master/chnroute.txt
	# https://raw.githubusercontent.com/mayaxcn/china-ip-list/master/chnroute_v6.txt
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/root/usr/share/shadowsocks/wan_bp{4,6}_list.txt $(1)/usr/share/shadowsocks
endef

$(eval $(call BuildPackage,shadowsocks-rules))
