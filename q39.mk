DEVICE_PACKAGE_OVERLAYS := device/tcl/q39/overlay
QC_PROP_ROOT := vendor/qcom/msm8916_64

TARGET_USES_QCOM_BSP := true
# Add QC Video Enhancements flag
TARGET_ENABLE_QC_AV_ENHANCEMENTS := true

ifeq ($(strip $(TARGET_BOARD_SUFFIX)),)
    PREBUILT_BOARD_PLATFORM_DIR := $(TARGET_BOARD_PLATFORM)$(TARGET_BOARD_SUFFIX)
else
    PREBUILT_BOARD_PLATFORM_DIR := $(TARGET_BOARD_PLATFORM)
endif

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

PRODUCT_NAME := TCL_M3G
PRODUCT_DEVICE := q39
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
    device/tcl/q39/config/acdbdata/MTP/msm8939-tapan-snd-card/MTP_WCD9306_Bluetooth_cal.acdb:system/etc/acdbdata/MTP/msm8939-tapan-snd-card/MTP_WCD9306_Bluetooth_cal.acdb \
    device/tcl/q39/config/acdbdata/MTP/msm8939-tapan-snd-card/MTP_WCD9306_General_cal.acdb:system/etc/acdbdata/MTP/msm8939-tapan-snd-card/MTP_WCD9306_General_cal.acdb \
    device/tcl/q39/config/acdbdata/MTP/msm8939-tapan-snd-card/MTP_WCD9306_Global_cal.acdb:system/etc/acdbdata/MTP/msm8939-tapan-snd-card/MTP_WCD9306_Global_cal.acdb \
    device/tcl/q39/config/acdbdata/MTP/msm8939-tapan-snd-card/MTP_WCD9306_Handset_cal.acdb:system/etc/acdbdata/MTP/msm8939-tapan-snd-card/MTP_WCD9306_Handset_cal.acdb \
    device/tcl/q39/config/acdbdata/MTP/msm8939-tapan-snd-card/MTP_WCD9306_Hdmi_cal.acdb:system/etc/acdbdata/MTP/msm8939-tapan-snd-card/MTP_WCD9306_Hdmi_cal.acdb \
    device/tcl/q39/config/acdbdata/MTP/msm8939-tapan-snd-card/MTP_WCD9306_Headset_cal.acdb:system/etc/acdbdata/MTP/msm8939-tapan-snd-card/MTP_WCD9306_Headset_cal.acdb \
    device/tcl/q39/config/acdbdata/MTP/msm8939-tapan-snd-card/MTP_WCD9306_Speaker_cal.acdb:system/etc/acdbdata/MTP/msm8939-tapan-snd-card/MTP_WCD9306_Speaker_cal.acdb \
    device/tcl/q39/config/acdbdata/MTP/MTP_Bluetooth_cal.acdb:system/etc/acdbdata/MTP/MTP_Bluetooth_cal.acdb \
    device/tcl/q39/config/acdbdata/MTP/MTP_General_cal.acdb:system/etc/acdbdata/MTP/MTP_General_cal.acdb \
    device/tcl/q39/config/acdbdata/MTP/MTP_Global_cal.acdb:system/etc/acdbdata/MTP/MTP_Global_cal.acdb \
    device/tcl/q39/config/acdbdata/MTP/MTP_Handset_cal.acdb:system/etc/acdbdata/MTP/MTP_Handset_cal.acdb \
    device/tcl/q39/config/acdbdata/MTP/MTP_Hdmi_cal.acdb:system/etc/acdbdata/MTP/MTP_Hdmi_cal.acdb \
    device/tcl/q39/config/acdbdata/MTP/MTP_Headset_cal.acdb:system/etc/acdbdata/MTP/MTP_Headset_cal.acdb \
    device/tcl/q39/config/acdbdata/MTP/MTP_Speaker_cal.acdb:system/etc/acdbdata/MTP/MTP_Speaker_cal.acdb \
    device/tcl/q39/config/acdbdata/QRD/QRD_Bluetooth_cal.acdb:system/etc/acdbdata/QRD/QRD_Bluetooth_cal.acdb \
    device/tcl/q39/config/acdbdata/QRD/QRD_General_cal.acdb:system/etc/acdbdata/QRD/QRD_General_cal.acdb \
    device/tcl/q39/config/acdbdata/QRD/QRD_Global_cal.acdb:system/etc/acdbdata/QRD/QRD_Global_cal.acdb \
    device/tcl/q39/config/acdbdata/QRD/QRD_Handset_cal.acdb:system/etc/acdbdata/QRD/QRD_Handset_cal.acdb \
    device/tcl/q39/config/acdbdata/QRD/QRD_Hdmi_cal.acdb:system/etc/acdbdata/QRD/QRD_Hdmi_cal.acdb \
    device/tcl/q39/config/acdbdata/QRD/QRD_Headset_cal.acdb:system/etc/acdbdata/QRD/QRD_Headset_cal.acdb \
    device/tcl/q39/config/acdbdata/QRD/QRD_Speaker_cal.acdb:system/etc/acdbdata/QRD/QRD_Speaker_cal.acdb

# firmware
PRODUCT_COPY_FILES += \
    device/tcl/q39/config/firmware/wcd9306/wcd9306_anc.bin:system/etc/firmware/wcd9306/wcd9306_anc.bin \
    device/tcl/q39/config/firmware/wcd9306/wcd9306_mbhc.bin:system/etc/firmware/wcd9306/wcd9306_mbhc.bin \
    device/tcl/q39/config/firmware/a225p5_pm4.fw:system/etc/firmware/a225p5_pm4.fw \
    device/tcl/q39/config/firmware/a225_pfp.fw:system/etc/firmware/a225_pfp.fw \
    device/tcl/q39/config/firmware/a225_pm4.fw:system/etc/firmware/a225_pm4.fw \
    device/tcl/q39/config/firmware/a300_pfp.fw:system/etc/firmware/a300_pfp.fw \
    device/tcl/q39/config/firmware/a300_pm4.fw:system/etc/firmware/a300_pm4.fw \
    device/tcl/q39/config/firmware/a330_pfp.fw:system/etc/firmware/a330_pfp.fw \
    device/tcl/q39/config/firmware/a330_pm4.fw:system/etc/firmware/a330_pm4.fw \
    device/tcl/q39/config/firmware/a420_pfp.fw:system/etc/firmware/a420_pfp.fw \
    device/tcl/q39/config/firmware/a420_pm4.fw:system/etc/firmware/a420_pm4.fw \
    device/tcl/q39/config/firmware/cpp_firmware_v1_1_1.fw:system/etc/firmware/cpp_firmware_v1_1_1.fw \
    device/tcl/q39/config/firmware/cpp_firmware_v1_1_6.fw:system/etc/firmware/cpp_firmware_v1_1_6.fw \
    device/tcl/q39/config/firmware/cpp_firmware_v1_2_0.fw:system/etc/firmware/cpp_firmware_v1_2_0.fw \
    device/tcl/q39/config/firmware/cpp_firmware_v1_4_0.fw:system/etc/firmware/cpp_firmware_v1_4_0.fw \
    device/tcl/q39/config/firmware/ice40.bin:system/etc/firmware/ice40.bin \
    device/tcl/q39/config/firmware/leia_pfp_470.fw:system/etc/firmware/leia_pfp_470.fw \
    device/tcl/q39/config/firmware/leia_pm4_470.fw:system/etc/firmware/leia_pm4_470.fw \
    device/tcl/q39/config/firmware/Signedrompatch_v20.bin:system/etc/firmware/Signedrompatch_v20.bin \
    device/tcl/q39/config/firmware/Signedrompatch_v21.bin:system/etc/firmware/Signedrompatch_v21.bin \
    device/tcl/q39/config/firmware/Signedrompatch_v24.bin:system/etc/firmware/Signedrompatch_v24.bin \
    device/tcl/q39/config/firmware/Signedrompatch_v30.bin:system/etc/firmware/Signedrompatch_v30.bin \
    device/tcl/q39/config/firmware/venus.b00:system/etc/firmware/venus.b00 \
    device/tcl/q39/config/firmware/venus.b01:system/etc/firmware/venus.b01 \
    device/tcl/q39/config/firmware/venus.b02:system/etc/firmware/venus.b02 \
    device/tcl/q39/config/firmware/venus.b03:system/etc/firmware/venus.b03 \
    device/tcl/q39/config/firmware/venus.b04:system/etc/firmware/venus.b04 \
    device/tcl/q39/config/firmware/venus.mbn:system/etc/firmware/venus.mbn \
    device/tcl/q39/config/firmware/venus.mdt:system/etc/firmware/venus.mdt

# cacert
PRODUCT_COPY_FILES += \
    device/tcl/q39/config/cacert_location.pem:system/etc/cacert_location.pem

# config
PRODUCT_COPY_FILES += \
    device/tcl/q39/config/capability.xml:system/etc/capability.xml \
    device/tcl/q39/config/cdma_call_conf.xml:system/etc/cdma_call_conf.xml \
    device/tcl/q39/config/ftm_test_config:system/etc/ftm_test_config \
    device/tcl/q39/config/ftm_test_config_mtp:system/etc/ftm_test_config_mtp \
    device/tcl/q39/config/ftm_test_config_wcd9306:system/etc/ftm_test_config_wcd9306 \
    device/tcl/q39/config/lowi.conf:system/etc/lowi.conf \
    device/tcl/q39/config/qmi_fw.conf:system/etc/qmi_fw.conf \
    device/tcl/q39/config/spn-conf.xml:system/etc/spn-conf.xml \
    device/tcl/q39/config/wfdconfigsink.xml:system/etc/wfdconfigsink.xml \
    device/tcl/q39/config/wfdconfig.xml:system/etc/wfdconfig.xml \
    device/tcl/q39/config/xtra_root_cert.pem:system/etc/xtra_root_cert.pem \
    device/tcl/q39/config/xtwifi.conf:system/etc/xtwifi.conf \
    device/tcl/q39/config/apns-conf.xml:system/etc/apns-conf.xml

# surround sound
PRODUCT_COPY_FILES += \
    device/tcl/q39/config/surround_sound/filter1i.pcm:system/etc/surround_sound/filter1i.pcm \
    device/tcl/q39/config/surround_sound/filter1r.pcm:system/etc/surround_sound/filter1r.pcm \
    device/tcl/q39/config/surround_sound/filter2i.pcm:system/etc/surround_sound/filter2i.pcm \
    device/tcl/q39/config/surround_sound/filter2r.pcm:system/etc/surround_sound/filter2r.pcm \
    device/tcl/q39/config/surround_sound/filter3i.pcm:system/etc/surround_sound/filter3i.pcm \
    device/tcl/q39/config/surround_sound/filter3r.pcm:system/etc/surround_sound/filter3r.pcm \
    device/tcl/q39/config/surround_sound/filter4i.pcm:system/etc/surround_sound/filter4i.pcm \
    device/tcl/q39/config/surround_sound/filter4r.pcm:system/etc/surround_sound/filter4r.pcm

# cne
PRODUCT_COPY_FILES += \
    device/tcl/q39/config/cne/andsfCne.xml:system/etc/cne/andsfCne.xml \
    device/tcl/q39/config/cne/SwimConfig.xml:system/etc/cne/SwimConfig.xml \
    device/tcl/q39/config/cne/wqeclient/profile1.xml:system/etc/cne/wqeclient/profile1.xml \
    device/tcl/q39/config/cne/wqeclient/profile2.xml:system/etc/cne/wqeclient/profile2.xml \
    device/tcl/q39/config/cne/wqeclient/profile3.xml:system/etc/cne/wqeclient/profile3.xml \
    device/tcl/q39/config/cne/wqeclient/profile4.xml:system/etc/cne/wqeclient/profile4.xml \
    device/tcl/q39/config/cne/wqeclient/profile5.xml:system/etc/cne/wqeclient/profile5.xml

# dpm
PRODUCT_COPY_FILES += \
    device/tcl/q39/config/dpm/dpm.conf:system/etc/dpm/dpm.conf \
    device/tcl/q39/config/dpm/nsrm/NsrmConfiguration.xml:system/etc/dpm/nsrm/NsrmConfiguration.xml

# mmi
PRODUCT_COPY_FILES += \
    device/tcl/q39/config/mmi/fail.png:system/etc/mmi/fail.png \
    device/tcl/q39/config/mmi/fonts.ttf:system/etc/mmi/fonts.ttf \
    device/tcl/q39/config/mmi/pass.png:system/etc/mmi/pass.png \
    device/tcl/q39/config/mmi/strings.xml:system/etc/mmi/strings.xml \
    device/tcl/q39/config/mmi/strings-zh-rCN.xml:system/etc/mmi/strings-zh-rCN.xml

# permissions
PRODUCT_COPY_FILES += \
    device/tcl/q39/config/permissions/btmultisim.xml:system/etc/permissions/btmultisim.xml \
    device/tcl/q39/config/permissions/cneapiclient.xml:system/etc/permissions/cneapiclient.xml \
    device/tcl/q39/config/permissions/com.qrd.wappush.xml:system/etc/permissions/com.qrd.wappush.xml \
    device/tcl/q39/config/permissions/com.qti.dpmframework.xml:system/etc/permissions/com.qti.dpmframework.xml \
    device/tcl/q39/config/permissions/com.qti.snapdragon.sdk.display.xml:system/etc/permissions/com.qti.snapdragon.sdk.display.xml \
    device/tcl/q39/config/permissions/com.qualcomm.qmapbridge.xml:system/etc/permissions/com.qualcomm.qmapbridge.xml \
    device/tcl/q39/config/permissions/com.qualcomm.qti.smartsearch.xml:system/etc/permissions/com.qualcomm.qti.smartsearch.xml \
    device/tcl/q39/config/permissions/com.quicinc.cne.xml:system/etc/permissions/com.quicinc.cne.xml \
    device/tcl/q39/config/permissions/ConnectivityExt.xml:system/etc/permissions/ConnectivityExt.xml \
    device/tcl/q39/config/permissions/dpmapi.xml:system/etc/permissions/dpmapi.xml \
    device/tcl/q39/config/permissions/embms.xml:system/etc/permissions/embms.xml \
    device/tcl/q39/config/permissions/imscm.xml:system/etc/permissions/imscm.xml \
    device/tcl/q39/config/permissions/qcnvitems.xml:system/etc/permissions/qcnvitems.xml \
    device/tcl/q39/config/permissions/qcrilhook.xml:system/etc/permissions/qcrilhook.xml \
    device/tcl/q39/config/permissions/qti_permissions.xml:system/etc/permissions/qti_permissions.xml \
    device/tcl/q39/config/permissions/rcsimssettings.xml:system/etc/permissions/rcsimssettings.xml

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

$(call inherit-product-if-exists, $(QC_PROP_ROOT)/prebuilt_HY22/Android.mk)

$(call inherit-product-if-exists, $(QC_PROP_ROOT)/prebuilt_HY22/target/product/$(PREBUILT_BOARD_PLATFORM_DIR)/prebuilt.mk)
