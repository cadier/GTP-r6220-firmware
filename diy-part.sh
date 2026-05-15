#!/bin/bash
# =========================================================
# ImmortalWrt R6220 DIY Script (2026 优化版)
# =========================================================

# 1. 强制修改版本显示（解决 SNAPSHOT 问题）
# 修改源码里的版本定义
sed -i "s/ENABLED_BACKEND_SNAPSHOTS=y/ENABLED_BACKEND_SNAPSHOTS=n/g" include/version.mk
sed -i 's/SNAPSHOT/23.05.6/g' include/version.mk
# 确保版本代号一致
sed -i 's/v$(VERSION_NUMBER)/v23.05.6/g' include/version.mk

# 2. 默认开启 WiFi
sed -i "s/option disabled '1'/option disabled '0'/g" \
package/network/config/wifi-scripts/files/lib/wifi/mac80211.uc

# 3. 默认中文语言设置
# 这种方式比 uci-defaults 更直接，直接修改源码默认值
sed -i 's/auto/zh_cn/g' feeds/luci/modules/luci-base/root/etc/config/luci

# 注意：不要在脚本里操作 .config，因为 Workflow 下一步会覆盖它。
# 所有的配置请全部写在你仓库根目录的 .config 文件里。
