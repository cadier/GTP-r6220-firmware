#!/bin/bash

# 更新 feeds
./scripts/feeds update -a
./scripts/feeds install -a

# 移除冲突 SSL
sed -i '/CONFIG_PACKAGE_luci-ssl=/d' .config
sed -i '/CONFIG_PACKAGE_libustream-openssl/d' .config
sed -i '/CONFIG_PACKAGE_uhttpd-openssl/d' .config

# 启用 mbedtls
echo "CONFIG_PACKAGE_luci-ssl-mbedtls=y" >> .config
echo "CONFIG_PACKAGE_libustream-mbedtls20201210=y" >> .config
echo "CONFIG_PACKAGE_uhttpd-mod-ubus=y" >> .config

# 常用工具
echo "CONFIG_PACKAGE_htop=y" >> .config
echo "CONFIG_PACKAGE_nano=y" >> .config
echo "CONFIG_PACKAGE_curl=y" >> .config
echo "CONFIG_PACKAGE_wget-ssl=y" >> .config

# SSH
echo "CONFIG_PACKAGE_openssh-server=y" >> .config
echo "CONFIG_PACKAGE_openssh-sftp-server=y" >> .config

# TTYD
echo "CONFIG_PACKAGE_ttyd=y" >> .config
echo "CONFIG_PACKAGE_luci-app-ttyd=y" >> .config

# HomeProxy
echo "CONFIG_PACKAGE_luci-app-homeproxy=y" >> .config
echo "CONFIG_PACKAGE_luci-i18n-homeproxy-zh-cn=y" >> .config
echo "CONFIG_PACKAGE_sing-box=y" >> .config
echo "CONFIG_PACKAGE_v2ray-geoip=y" >> .config
echo "CONFIG_PACKAGE_v2ray-geosite=y" >> .config

# 中文
echo "CONFIG_PACKAGE_luci-i18n-base-zh-cn=y" >> .config
echo "CONFIG_PACKAGE_luci-i18n-firewall-zh-cn=y" >> .config
echo "CONFIG_PACKAGE_luci-i18n-package-manager-zh-cn=y" >> .config
echo "CONFIG_PACKAGE_luci-i18n-ttyd-zh-cn=y" >> .config

# USB 蓝牙支持
echo "CONFIG_PACKAGE_kmod-usb-core=y" >> .config
echo "CONFIG_PACKAGE_kmod-usb2=y" >> .config
echo "CONFIG_PACKAGE_kmod-bluetooth=y" >> .config
echo "CONFIG_PACKAGE_kmod-btusb=y" >> .config

# WiFi
echo "CONFIG_PACKAGE_kmod-mt76=y" >> .config
echo "CONFIG_PACKAGE_wpad-basic-mbedtls=y" >> .config
