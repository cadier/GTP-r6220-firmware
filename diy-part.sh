#!/bin/bash
echo "======== 开始执行 diy-part.sh ========"

# 1. 修改版本信息
echo "修改版本号为 23.05.6 ..."
sed -i "s/ENABLED_BACKEND_SNAPSHOTS=y/ENABLED_BACKEND_SNAPSHOTS=n/g" include/version.mk 2>/dev/null || true
sed -i 's/SNAPSHOT/23.05.6/g' include/version.mk 2>/dev/null || true

# 2. 强制开启 WiFi（更安全的写法）
echo "正在执行 WiFi 开启指令..."
find . -name "wireless" -o -name "*.conf" | xargs sed -i "s/option disabled '1'/option disabled '0'/g" 2>/dev/null || true

# 3. 设置默认语言为中文（更稳健的写法）
echo "设置默认语言为中文..."
if [ -f feeds/luci/modules/luci-base/root/etc/config/luci ]; then
    sed -i 's/option lang auto/option lang zh_cn/g' feeds/luci/modules/luci-base/root/etc/config/luci 2>/dev/null || true
else
    echo "警告：luci config 文件未找到，跳过默认语言设置"
fi

echo "======== diy-part.sh 执行完成 ========"
exit 0
