#!/sbin/sh
#
# Copyright (C) 2018 The LineageOS Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Remove duplicated genfscon rules
sed -i "/genfscon exfat/d" /system/etc/selinux/plat_sepolicy.cil
sed -i "/genfscon fuseblk/d" /system/etc/selinux/plat_sepolicy.cil

# Fix logd service definition
sed -i "s/socket logdw dgram+passcred 0222 logd logd/socket logdw dgram 0222 logd logd/g" /system/etc/init/logd.rc

# Disable parsing intra-refresh-mode parameter in libstagefright
sed -i 's/intra-refresh-mode/intra-refresh-nope/' /system/lib64/libstagefright.so
sed -i 's/intra-refresh-mode/intra-refresh-nope/' /system/lib/libstagefright.so

if [ "$(cat /proc/device-tree/hisi,product_name)" = "LLD-L31" ]; then
    # Keep NFC
    echo 0
else
    # Remove NFC
    rm -rf /system/app/NfcNci
    rm -rf /system/etc/permissions/android.hardware.nfc.hce.xml
    rm -rf /system/etc/permissions/android.hardware.nfc.xml
    rm -rf /system/etc/permissions/com.android.nfc_extras.xml
    rm -rf /system/framework/com.android.nfc_extras.jar
    rm -rf /system/priv-app/Tag
fi
