DEVICE_PACKAGE_OVERLAYS := device/tcl/q39/overlay

TARGET_USES_QCOM_BSP := true
# Add QC Video Enhancements flag
TARGET_ENABLE_QC_AV_ENHANCEMENTS := true

#QTIC flag
-include $(QCPATH)/common/config/qtic-config.mk

#for android_filesystem_config.h
PRODUCT_PACKAGES += \
    fs_config_files

# Enable features in video HAL that can compile only on this platform
TARGET_USES_MEDIA_EXTENSIONS := true

# qcom shell
PRODUCT_PACKAGES += \
    init.qcom.power.sh \
    init.qcom.debug.sh \
    init.ath3k.bt.sh \
    init.crda.sh \
    init.qcom.audio.sh \
    init.qcom.bt.sh \
    init.qcom.coex.sh \
    init.qcom.efs.sync.sh \
    init.qcom.fm.sh \
    init.qcom.post_boot.sh \
    init.qcom.sdio.sh \
    init.qcom.uicc.sh \
    init.qcom.wifi.sh \
    init.qcom.zram.sh

# root
PRODUCT_PACKAGES += \
    init.target.rc \
    init.carrier.rc \
    init.qcom.usb.rc \
    init.rc \
    init.trace.rc \
    init.usb.rc \
    init.zygote32.rc \
    init.zygote64_32.rc \
    init.qcom.usb.sh \
    fstab.qcom \
    init.qcom.class_core.sh \
    init.qcom.sh \
    init.qcom.syspart_fixup.sh

# media_profiles and media_codecs xmls for 8916
ifeq ($(TARGET_ENABLE_QC_AV_ENHANCEMENTS), true)
PRODUCT_COPY_FILES += device/qcom/msm8916_32/media/media_profiles_8916.xml:system/etc/media_profiles.xml \
                      device/qcom/msm8916_32/media/media_codecs_8916.xml:system/etc/media_codecs.xml \
                      device/qcom/msm8916_32/media/media_codecs_performance_8916_64.xml:system/etc/media_codecs_performance.xml \
                      device/qcom/msm8916_32/media/media_codecs_performance_8929.xml:system/etc/media_codecs_performance_8929.xml \
                      device/qcom/msm8916_32/media/media_codecs_8939.xml:system/etc/media_codecs_8939.xml \
                      device/qcom/msm8916_32/media/media_codecs_performance_8916_64_8939.xml:system/etc/media_codecs_performance_8939.xml \
                      device/qcom/msm8916_32/media/media_codecs_8929.xml:system/etc/media_codecs_8929.xml
endif

TARGET_USES_NQ_NFC := false

PRODUCT_PROPERTY_OVERRIDES += \
           dalvik.vm.heapgrowthlimit=128m
$(call inherit-product, device/qcom/common/common64.mk)

PRODUCT_NAME := msm8916_64
PRODUCT_DEVICE := msm8916_64
PRODUCT_BRAND := TCL
PRODUCT_MODEL := TCL_M3G
# When can normal compile this module,  need module owner enable below commands
# font rendering engine feature switch
-include $(QCPATH)/common/config/rendering-engine.mk
ifneq (,$(strip $(wildcard $(PRODUCT_RENDERING_ENGINE_REVLIB))))
     MULTI_LANG_ENGINE := REVERIE
#    MULTI_LANG_ZAWGYI := REVERIE
endif

PRODUCT_BOOT_JARS += qcom.fmradio

#PRODUCT_BOOT_JARS += vcard
PRODUCT_BOOT_JARS += tcmiface
#PRODUCT_BOOT_JARS += qcmediaplayer

# QTI extended functionality of android telephony.
# Required for MSIM manual provisioning and other related features.
PRODUCT_PACKAGES += telephony-ext
PRODUCT_BOOT_JARS += telephony-ext

ifneq ($(strip $(QCPATH)),)
#PRODUCT_BOOT_JARS += com.qti.dpmframework
#PRODUCT_BOOT_JARS += dpmapi
PRODUCT_BOOT_JARS += oem-services
#PRODUCT_BOOT_JARS += com.qti.location.sdk
endif

PRODUCT_BOOT_JARS += WfdCommon

# default is nosdcard, S/W button enabled in resource
PRODUCT_CHARACTERISTICS := nosdcard

#Android EGL implementation
PRODUCT_PACKAGES += libGLES_android

PRODUCT_PACKAGES += \
    libqcomvisualizer \
    libqcompostprocbundle \
    libqcomvoiceprocessing

# Audio configuration file
-include $(TOPDIR)hardware/qcom/audio/configs/msm8916_64/msm8916_64.mk

# MIDI feature
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.midi.xml:system/etc/permissions/android.software.midi.xml

#ANT+ stack
PRODUCT_PACKAGES += \
    AntHalService \
    libantradio \
    antradio_app
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
    camera2.portability.force_api=1
PRODUCT_PACKAGES += wcnss_service

# MSM IRQ Balancer configuration file
PRODUCT_COPY_FILES += \
    device/tcl/q39/msm_irqbalance.conf:system/vendor/etc/msm_irqbalance.conf

# Keylayout
PRODUCT_COPY_FILES += \
    device/tcl/q39/keylayout/ft5x06_ts.kl:system/usr/keylayout/ft5x06_ts.kl \
    device/tcl/q39/keylayout/gpio-keys.kl:system/usr/keylayout/gpio-keys.kl \
    device/tcl/q39/keylayout/synaptics_dsx.kl:system/usr/keylayout/synaptics_dsx.kl \
    device/tcl/q39/keylayout/synaptics_rmi4_i2c.kl:system/usr/keylayout/synaptics_rmi4_i2c.kl

# acdb
PRODUCT_COPY_FILES += \
    device/tcl/q39/acdbdata/MTP/msm8939-tapan-snd-card/MTP_WCD9306_Bluetooth_cal.acdb:system/etc/acdbdata/MTP/msm8939-tapan-snd-card/MTP_WCD9306_Bluetooth_cal.acdb \
    device/tcl/q39/acdbdata/MTP/msm8939-tapan-snd-card/MTP_WCD9306_General_cal.acdb:system/etc/acdbdata/MTP/msm8939-tapan-snd-card/MTP_WCD9306_General_cal.acdb \
    device/tcl/q39/acdbdata/MTP/msm8939-tapan-snd-card/MTP_WCD9306_Global_cal.acdb:system/etc/acdbdata/MTP/msm8939-tapan-snd-card/MTP_WCD9306_Global_cal.acdb \
    device/tcl/q39/acdbdata/MTP/msm8939-tapan-snd-card/MTP_WCD9306_Handset_cal.acdb:system/etc/acdbdata/MTP/msm8939-tapan-snd-card/MTP_WCD9306_Handset_cal.acdb \
    device/tcl/q39/acdbdata/MTP/msm8939-tapan-snd-card/MTP_WCD9306_Hdmi_cal.acdb:system/etc/acdbdata/MTP/msm8939-tapan-snd-card/MTP_WCD9306_Hdmi_cal.acdb \
    device/tcl/q39/acdbdata/MTP/msm8939-tapan-snd-card/MTP_WCD9306_Headset_cal.acdb:system/etc/acdbdata/MTP/msm8939-tapan-snd-card/MTP_WCD9306_Headset_cal.acdb \
    device/tcl/q39/acdbdata/MTP/msm8939-tapan-snd-card/MTP_WCD9306_Speaker_cal.acdb:system/etc/acdbdata/MTP/msm8939-tapan-snd-card/MTP_WCD9306_Speaker_cal.acdb \
    device/tcl/q39/acdbdata/MTP/MTP_Bluetooth_cal.acdb:system/etc/acdbdata/MTP/MTP_Bluetooth_cal.acdb \
    device/tcl/q39/acdbdata/MTP/MTP_General_cal.acdb:system/etc/acdbdata/MTP/MTP_General_cal.acdb \
    device/tcl/q39/acdbdata/MTP/MTP_Global_cal.acdb:system/etc/acdbdata/MTP/MTP_Global_cal.acdb \
    device/tcl/q39/acdbdata/MTP/MTP_Handset_cal.acdb:system/etc/acdbdata/MTP/MTP_Handset_cal.acdb \
    device/tcl/q39/acdbdata/MTP/MTP_Hdmi_cal.acdb:system/etc/acdbdata/MTP/MTP_Hdmi_cal.acdb \
    device/tcl/q39/acdbdata/MTP/MTP_Headset_cal.acdb:system/etc/acdbdata/MTP/MTP_Headset_cal.acdb \
    device/tcl/q39/acdbdata/MTP/MTP_Speaker_cal.acdb:system/etc/acdbdata/MTP/MTP_Speaker_cal.acdb \
    device/tcl/q39/acdbdata/QRD/QRD_Bluetooth_cal.acdb:system/etc/acdbdata/QRD/QRD_Bluetooth_cal.acdb \
    device/tcl/q39/acdbdata/QRD/QRD_General_cal.acdb:system/etc/acdbdata/QRD/QRD_General_cal.acdb \
    device/tcl/q39/acdbdata/QRD/QRD_Global_cal.acdb:system/etc/acdbdata/QRD/QRD_Global_cal.acdb \
    device/tcl/q39/acdbdata/QRD/QRD_Handset_cal.acdb:system/etc/acdbdata/QRD/QRD_Handset_cal.acdb \
    device/tcl/q39/acdbdata/QRD/QRD_Hdmi_cal.acdb:system/etc/acdbdata/QRD/QRD_Hdmi_cal.acdb \
    device/tcl/q39/acdbdata/QRD/QRD_Headset_cal.acdb:system/etc/acdbdata/QRD/QRD_Headset_cal.acdb \
    device/tcl/q39/acdbdata/QRD/QRD_Speaker_cal.acdb:system/etc/acdbdata/QRD/QRD_Speaker_cal.acdb

#wlan driver
PRODUCT_COPY_FILES += \
    device/tcl/q39/wifi/WCNSS_cfg.dat:system/etc/firmware/wlan/prima/WCNSS_cfg.dat \
    device/tcl/q39/wifi/WCNSS_qcom_cfg.ini:system/etc/wifi/WCNSS_qcom_cfg.ini \
    device/tcl/q39/wifi/WCNSS_wlan_dictionary.dat:persist/WCNSS_wlan_dictionary.dat \
    device/tcl/q39/wifi/WCNSS_qcom_wlan_nv.bin:persist/WCNSS_qcom_wlan_nv.bin

ifeq ($(strip $(BOARD_HAS_QCOM_WLAN)),true)
PRODUCT_COPY_FILES += \
    device/tcl/q39/wifi/wpa_supplicant_overlay.conf:system/etc/wifi/wpa_supplicant_overlay.conf \
    device/tcl/q39/wifi/p2p_supplicant_overlay.conf:system/etc/wifi/p2p_supplicant_overlay.conf \
    device/tcl/q39/wifi/hostapd.conf:system/etc/hostapd/hostapd_default.conf \
    device/tcl/q39/wifi/hostapd.accept:system/etc/hostapd/hostapd.accept \
    device/tcl/q39/wifi/hostapd.deny:system/etc/hostapd/hostapd.deny
endif

PRODUCT_PACKAGES += \
    wpa_supplicant

# dhcpcd
PRODUCT_PACKAGES += \
    dhcpcd-6.8.2

# debuggerd
PRODUCT_PACKAGES += \
    debuggerd \
    debuggerd64

# sdcard
PRODUCT_PACKAGES += \
    sdcard

# logwrapper
PRODUCT_PACKAGES += \
    logwrapper

# ip
PRODUCT_PACKAGES += \
    ip

# mdnsd
PRODUCT_PACKAGES += \
    mdnsd

# keystore
PRODUCT_PACKAGES += \
    keystore

# healthd
PRODUCT_PACKAGES += \
    healthd

# rild
PRODUCT_PACKAGES += \
    rild

# init
PRODUCT_PACKAGES += \
    init

# mtpd
PRODUCT_PACKAGES += \
    mtpd

# logd
PRODUCT_PACKAGES += \
    logd

# Defined the locales
PRODUCT_LOCALES += th_TH vi_VN tl_PH hi_IN ar_EG ru_RU tr_TR pt_BR bn_IN mr_IN ta_IN te_IN zh_HK \
        in_ID my_MM km_KH sw_KE uk_UA pl_PL sr_RS sl_SI fa_IR kn_IN ml_IN ur_IN gu_IN or_IN zh_CN

# When can normal compile this module,  need module owner enable below commands
# Add the overlay path
PRODUCT_PACKAGE_OVERLAYS := $(QCPATH)/qrdplus/Extension/res \
        $(PRODUCT_PACKAGE_OVERLAYS)
        #$(QCPATH)/qrdplus/globalization/multi-language/res-overlay \

PRODUCT_SUPPORTS_VERITY := true
PRODUCT_SYSTEM_VERITY_PARTITION := /dev/block/bootdevice/by-name/system

# Sensor HAL conf file
PRODUCT_COPY_FILES += \
    device/tcl/q39/sensors/hals.conf:system/etc/sensors/hals.conf

GMS_ENABLE_OPTIONAL_MODULES := false
