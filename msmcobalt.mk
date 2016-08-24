DEVICE_PACKAGE_OVERLAYS := device/qcom/msmcobalt/overlay
TARGET_KERNEL_VERSION := 4.4
BOARD_HAVE_QCOM_FM := true
TARGET_USES_NQ_NFC := true
TARGET_ENABLE_QC_AV_ENHANCEMENTS := true
# Video codec configuration files
ifeq ($(TARGET_ENABLE_QC_AV_ENHANCEMENTS), true)
PRODUCT_COPY_FILES += device/qcom/msmcobalt/media_profiles.xml:system/etc/media_profiles.xml \
                      device/qcom/msmcobalt/media_codecs.xml:system/etc/media_codecs.xml
endif #TARGET_ENABLE_QC_AV_ENHANCEMENTS


# Add support for whitelisted apps
PRODUCT_COPY_FILES += device/qcom/msmcobalt/whitelistedapps.xml:system/etc/whitelistedapps.xml

#QTIC flag
-include $(QCPATH)/common/config/qtic-config.mk


$(call inherit-product, device/qcom/common/common64.mk)

PRODUCT_NAME := msmcobalt
PRODUCT_DEVICE := msmcobalt
PRODUCT_BRAND := Android
PRODUCT_MODEL := Cobalt for arm64

# default is nosdcard, S/W button enabled in resource
PRODUCT_CHARACTERISTICS := nosdcard

# Enable features in video HAL that can compile only on this platform
TARGET_USES_MEDIA_EXTENSIONS := true

#Android EGL implementation
PRODUCT_PACKAGES += libGLES_android
PRODUCT_BOOT_JARS += tcmiface
PRODUCT_BOOT_JARS += telephony-ext

PRODUCT_PACKAGES += telephony-ext

ifneq ($(strip $(QCPATH)),)
PRODUCT_BOOT_JARS += WfdCommon
endif

ifeq ($(strip $(BOARD_HAVE_QCOM_FM)),true)
PRODUCT_BOOT_JARS += qcom.fmradio
endif #BOARD_HAVE_QCOM_FM

# Audio configuration file
-include $(TOPDIR)hardware/qcom/audio/configs/msmcobalt/msmcobalt.mk

PRODUCT_PACKAGE_OVERLAYS := $(QCPATH)/qrdplus/Extension/res \
        $(PRODUCT_PACKAGE_OVERLAYS)

# Sensor HAL conf file
PRODUCT_COPY_FILES += \
    device/qcom/msmcobalt/sensors/hals.conf:system/etc/sensors/hals.conf

# WLAN driver configuration file
PRODUCT_COPY_FILES += \
    device/qcom/msmcobalt/WCNSS_qcom_cfg.ini:system/etc/wifi/WCNSS_qcom_cfg.ini \
    device/qcom/msmcobalt/wifi_concurrency_cfg.txt:system/etc/wifi/wifi_concurrency_cfg.txt

PRODUCT_PACKAGES += \
    wpa_supplicant_overlay.conf \
    p2p_supplicant_overlay.conf

#ANT+ stack
PRODUCT_PACKAGES += \
    AntHalService \
    libantradio \
    antradio_app \
    libvolumelistener


# Sensor features
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.sensor.accelerometer.xml:system/etc/permissions/android.hardware.sensor.accelerometer.xml \
    frameworks/native/data/etc/android.hardware.sensor.compass.xml:system/etc/permissions/android.hardware.sensor.compass.xml \
    frameworks/native/data/etc/android.hardware.sensor.gyroscope.xml:system/etc/permissions/android.hardware.sensor.gyroscope.xml \
    frameworks/native/data/etc/android.hardware.sensor.light.xml:system/etc/permissions/android.hardware.sensor.light.xml \
    frameworks/native/data/etc/android.hardware.sensor.proximity.xml:system/etc/permissions/android.hardware.sensor.proximity.xml \
    frameworks/native/data/etc/android.hardware.sensor.barometer.xml:system/etc/permissions/android.hardware.sensor.barometer.xml \
    frameworks/native/data/etc/android.hardware.sensor.stepcounter.xml:system/etc/permissions/android.hardware.sensor.stepcounter.xml \
    frameworks/native/data/etc/android.hardware.sensor.stepdetector.xml:system/etc/permissions/android.hardware.sensor.stepdetector.xml \
    frameworks/native/data/etc/android.hardware.sensor.ambient_temperature.xml:system/etc/permissions/android.hardware.sensor.ambient_temperature.xml \
    frameworks/native/data/etc/android.hardware.sensor.relative_humidity.xml:system/etc/permissions/android.hardware.sensor.relative_humidity.xml \
    frameworks/native/data/etc/android.hardware.sensor.hifi_sensors.xml:system/etc/permissions/android.hardware.sensor.hifi_sensors.xml

# MSM IRQ Balancer configuration file
PRODUCT_COPY_FILES += device/qcom/msmcobalt/msm_irqbalance.conf:system/vendor/etc/msm_irqbalance.conf

#for android_filesystem_config.h
PRODUCT_PACKAGES += \
    fs_config_files

# dm-verity configuration
PRODUCT_SUPPORTS_VERITY := true
PRODUCT_SYSTEM_VERITY_PARTITION := /dev/block/bootdevice/by-name/system

# List of AAPT configurations
PRODUCT_AAPT_CONFIG += xlarge large
