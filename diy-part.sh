#!/bin/bash
# =========================================================
#!/bin/bash

# 1. 强制修改版本显示
sed -i "s/ENABLED_BACKEND_SNAPSHOTS=y/ENABLED_BACKEND_SNAPSHOTS=n/g" include/version.mk
sed -i 's/SNAPSHOT/23.05.6/g' include/version.mk
sed -i 's/v$(VERSION_NUMBER)/v23.05.6/g' include/version.mk

# 2. 默认开启 WiFi (用 find 兼容不同路径)
find package -name "mac80211.uc" | xargs -i sed -i "s/option disabled '1'/option disabled '0'/g" {} || true

# 3. 默认中文 (修改 luci-base 的默认配置)
# 注意：在 23.05 中，luci-base 可能在 feeds 目录下
if [ -f feeds/luci/modules/luci-base/root/etc/config/luci ]; then
    sed -i 's/auto/zh_cn/g' feeds/luci/modules/luci-base/root/etc/config/luci
fi
