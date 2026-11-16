#!/bin/bash
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#
# Copyright (c) 2019-2024 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#

# Modify default IP
sed -i 's/192.168.1.1/192.168.1.253/g' package/base-files/files/bin/config_generate

git clone --depth=1 https://github.com/Openwrt-Passwall/openwrt-passwall-packages /tmp/passwall-packages
rm -rf feeds/packages/net/sing-box
cp -rf /tmp/passwall-packages/sing-box feeds/packages/net/sing-box
rm -rf /tmp/passwall-packages

# 修改网页后台“状态 -> 概览 -> 固件版本”末尾的修订号，追加北京时间日期
sed -i "s/%R/%R ($(TZ='Asia/Shanghai' date +"%Y.%m.%d"))/g" package/base-files/files/etc/openwrt_release

# 修改 SSH 登录时的欢迎界面标签
sed -i "s/%D %V, %C/%D %V, %C (Built on $(TZ='Asia/Shanghai' date +"%Y.%m.%d"))/g" package/base-files/files/etc/banner
