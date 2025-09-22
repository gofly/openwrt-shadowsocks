include $(TOPDIR)/rules.mk

PKG_NAME:=shadowsocks-libev
PKG_VERSION:=3.3.6
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/shadowsocks/shadowsocks-libev.git
PKG_SOURCE_VERSION:=9afa3cacf947f910be46b69fc5a7a1fdd02fd5e6

PKG_SOURCE_SUBDIR:=shadowsocks-libev
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_SOURCE_SUBDIR)

PKG_INSTALL:=1
PKG_FIXUP:=autoreconf
PKG_USE_MIPS16:=0
PKG_BUILD_PARALLEL:=1
PKG_BUILD_DEPENDS:=c-ares libev libsodium mbedtls pcre

include $(INCLUDE_DIR)/package.mk

define Package/shadowsocks-libev
	SECTION:=net
	CATEGORY:=Network
	TITLE:=Lightweight Secured Socks5 Proxy
	URL:=https://github.com/shadowsocks/shadowsocks-libev
endef

define Package/shadowsocks-libev/description
	Shadowsocks is a lightweight secured socks5 proxy for embedded devices and low end boxes.
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

define Package/shadowsocks-libev/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/src/ss-redir $(1)/usr/bin
endef

$(eval $(call BuildPackage,shadowsocks-libev))
