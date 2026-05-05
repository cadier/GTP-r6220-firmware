#!/bin/bash
# =========================================================
# ImmortalWrt R6220 DIY Script（修正版）
# 功能：
# - 更新 feeds
# - 安装软件包
# - 默认开启 WiFi
# - 默认中文
# - 修复 luci SSL 冲突（OpenSSL → mbedTLS）
# =========================================================

# 更新并安装 feeds
./scripts/feeds update -a
./scripts/feeds install -a

# ===== 默认开启 WiFi (开源驱动通用) =====
sed -i "s/option disabled '1'/option disabled '0'/g" \
package/network/config/wifi-scripts/files/lib/wifi/mac80211.uc

# ===== 默认中文语言 =====
mkdir -p package/base-files/files/etc/uci-defaults

cat > package/base-files/files/etc/uci-defaults/99-default-lang << 'EOF'
#!/bin/sh
uci set luci.main.lang='zh_cn'
uci commit luci
exit 0
EOF

chmod +x package/base-files/files/etc/uci-defaults/99-default-lang

# ===== 修复 SSL 包冲突 =====
sed -i '/CONFIG_PACKAGE_luci-ssl=/d' .config
sed -i '/CONFIG_PACKAGE_luci-ssl-mbedtls=/d' .config
sed -i '/CONFIG_PACKAGE_libustream-openssl20201210/d' .config
sed -i '/CONFIG_PACKAGE_libustream-mbedtls20201210/d' .config

cat >> .config << EOF
CONFIG_PACKAGE_luci-ssl-mbedtls=y
# CONFIG_PACKAGE_luci-ssl is not set
# CONFIG_PACKAGE_libustream-openssl20201210 is not set
CONFIG_PACKAGE_libustream-mbedtls20201210=y
EOF

# ===== 更新配置 =====
make defconfig
