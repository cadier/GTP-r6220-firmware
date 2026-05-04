#!/bin/bash

# 更新并安装 feeds
./scripts/feeds update -a
./scripts/feeds install -a

# 默认开启 WiFi
sed -i "s/option disabled '1'/option disabled '0'/g" package/network/config/wifi-scripts/files/lib/wifi/mac80211.uc
