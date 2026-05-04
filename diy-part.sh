#!/bin/bash

# 更新并安装 feeds
./scripts/feeds update -a
./scripts/feeds install -a

# 默认开启 WiFi
sed -i "s/option disabled '1'/option disabled '0'/g" package/network/config/wifi-scripts/files/lib/wifi/mac80211.uc

cat << 'EOF' >> package/base-files/files/etc/uci-defaults/99-default-lang
uci set luci.main.lang='zh_cn'
uci commit luci
exit 0
EOF
