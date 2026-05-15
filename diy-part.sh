#!/bin/bash

# 1. 强制抹除 SNAPSHOT (这一步你已经很熟了)
sed -i "s/ENABLED_BACKEND_SNAPSHOTS=y/ENABLED_BACKEND_SNAPSHOTS=n/g" include/version.mk
sed -i 's/SNAPSHOT/23.05.6/g' include/version.mk

# 2. 【核心】全盘搜索所有 WiFi 配置文件并强行开启
# 这个命令会扫描整个源码目录，寻找包含 "disabled '1'" 的无线配置文件并替换
echo "正在执行全量 WiFi 开启指令..."
grep -rl "option disabled '1'" . | xargs sed -i "s/option disabled '1'/option disabled '0'/g"

# 3. 默认中文
sed -i 's/auto/zh_cn/g' feeds/luci/modules/luci-base/root/etc/config/luci

exit 0
