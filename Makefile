include $(TOPDIR)/rules.mk

PKG_NAME:=shadowsocks
PKG_VERSION:=3.3.5
PKG_RELEASE:=1

include $(INCLUDE_DIR)/package.mk

define Package/shadowsocks
	SECTION:=net
	CATEGORY:=Network
	TITLE:=Shadowsocks
	DEPENDS:=+kmod-nft-socket +kmod-nft-tproxy
endef

define Build/Prepare
	$(Build/Prepare/Default)
	rm -rf $(PKG_BUILD_DIR)/root
	cp -r ./root $(PKG_BUILD_DIR)/root
	wget -O $(DL_DIR)/ss-redir  https://github.com/gofly/openwrt-shadowsocks/releases/download/v3.3.5/ss-redir
	wget -O $(DL_DIR)/wan_bp4_list.txt https://raw.githubusercontent.com/mayaxcn/china-ip-list/master/chnroute.txt
	wget -O $(DL_DIR)/wan_bp6_list.txt https://raw.githubusercontent.com/mayaxcn/china-ip-list/master/chnroute_v6.txt
endef

define Build/Compile
endef

define Package/shadowsocks/install
	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_CONF) $(PKG_BUILD_DIR)/root/etc/config/shadowsocks $(1)/etc/config
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/root/etc/init.d/shadowsocks $(1)/etc/init.d
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/root/usr/bin/ss-rules $(1)/usr/bin
	$(INSTALL_BIN) $(DL_DIR)/ss-redir $(1)/usr/bin
	$(INSTALL_DIR) $(1)/usr/share/shadowsocks
	$(INSTALL_DATA) $(DL_DIR)/wan_bp4_list.txt $(1)/usr/share/shadowsocks
	$(INSTALL_DATA) $(DL_DIR)/wan_bp6_list.txt $(1)/usr/share/shadowsocks
endef

$(eval $(call BuildPackage,shadowsocks))
