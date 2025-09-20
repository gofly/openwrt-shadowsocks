include $(TOPDIR)/rules.mk

PKG_NAME:=shadowsocks
PKG_VERSION:=3.3.5
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/shadowsocks/shadowsocks-libev.git
PKG_SOURCE_VERSION:=8285e5a7de093b8ae5a2ca68f7108e6f273092b1

PKG_SOURCE_SUBDIR:=shadowsocks-libev
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_SOURCE_SUBDIR)

PKG_INSTALL:=1
PKG_FIXUP:=autoreconf
PKG_USE_MIPS16:=0
PKG_BUILD_PARALLEL:=1
PKG_BUILD_DEPENDS:=c-ares libev libpthread libsodium mbedtls pcre

include $(INCLUDE_DIR)/package.mk

define Package/shadowsocks
	SECTION:=net
	CATEGORY:=Network
	TITLE:=Lightweight Secured Socks5 Proxy
	URL:=https://github.com/shadowsocks/shadowsocks-libev
	DEPENDS:=+kmod-nft-socket +kmod-nft-tproxy
endef

define Package/shadowsocks/description
	Shadowsocks is a lightweight secured socks5 proxy for embedded devices and low end boxes.
endef

define Build/Prepare
	$(Build/Prepare/Default)
	rm -rf $(PKG_BUILD_DIR)/root
	cp -r ./root $(PKG_BUILD_DIR)/root
	wget -O $(DL_DIR)/wan_bp4_list.txt https://raw.githubusercontent.com/mayaxcn/china-ip-list/master/chnroute.txt
	wget -O $(DL_DIR)/wan_bp6_list.txt https://raw.githubusercontent.com/mayaxcn/china-ip-list/master/chnroute_v6.txt
endef

CONFIGURE_ARGS += \
	--disable-ssp \
	--disable-documentation \
	--disable-assert \
	--disable-debug \
	--with-ev="$(STAGING_DIR)/usr" \
	--with-pcre="$(STAGING_DIR)/usr" \
	--with-cares="$(STAGING_DIR)/usr" \
	--with-cares-include="$(STAGING_DIR)/usr/include" \
	--with-cares-lib="$(STAGING_DIR)/usr/lib" \
	--with-sodium="$(STAGING_DIR)/usr" \
	--with-mbedtls="$(STAGING_DIR)/usr" \
	ac_cv_lib_cares_ares_library_init=yes \
	ax_pthread_ok=yes \
	CFLAGS="$(TARGET_CFLAGS) -Os -ffunction-sections -fdata-sections" \
	LDFLAGS="$(TARGET_LDFLAGS) -Wl,--gc-sections -s -Wl,-static -static -static-libgcc"

define Build/Compile
	$(call Build/Compile/Default)
endef

define Package/shadowsocks/install
	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_CONF) $(PKG_BUILD_DIR)/root/etc/config/shadowsocks $(1)/etc/config
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/root/etc/init.d/shadowsocks $(1)/etc/init.d
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/root/usr/bin/ss-rules $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/src/ss-redir $(1)/usr/bin
	$(INSTALL_DIR) $(1)/usr/share/shadowsocks
	$(INSTALL_DATA) $(DL_DIR)/wan_bp{4,6}_list.txt $(1)/usr/share/shadowsocks
endef

$(eval $(call BuildPackage,shadowsocks))
