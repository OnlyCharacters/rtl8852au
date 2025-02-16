EXTRA_CFLAGS += $(USER_EXTRA_CFLAGS)
EXTRA_CFLAGS += -O1
#EXTRA_CFLAGS += -O3
#EXTRA_CFLAGS += -Wall
#EXTRA_CFLAGS += -Wextra
#EXTRA_CFLAGS += -Werror
#EXTRA_CFLAGS += -pedantic
#EXTRA_CFLAGS += -Wshadow -Wpointer-arith -Wcast-qual -Wstrict-prototypes -Wmissing-prototypes

EXTRA_CFLAGS += -Wno-unused-variable
#EXTRA_CFLAGS += -Wno-unused-value
EXTRA_CFLAGS += -Wno-unused-label
#EXTRA_CFLAGS += -Wno-unused-parameter
#EXTRA_CFLAGS += -Wno-unused-function
EXTRA_CFLAGS += -Wno-unused
#EXTRA_CFLAGS += -Wno-uninitialized

GCC_VER_49 := $(shell echo `$(CC) -dumpversion | cut -f1-2 -d.` \>= 4.9 | bc )

EXTRA_CFLAGS += -I$(src)/include

EXTRA_LDFLAGS += --strip-debug

CONFIG_AUTOCFG_CP = n

SUBARCH := $(shell uname -m | sed -e "s/i.86/i386/; s/ppc.*/powerpc/; s/armv.l/arm/; s/aarch64/arm64/;")
ARCH ?= $(SUBARCH)

ifeq ("","$(wildcard MOK.der)")
NO_SKIP_SIGN := y
endif

########################## WIFI IC ############################
CONFIG_RTL8852A = y
CONFIG_RTL8852B = n
CONFIG_RTL8852C = n
######################### Interface ###########################
CONFIG_USB_HCI = y
CONFIG_PCI_HCI = n
CONFIG_SDIO_HCI = n
CONFIG_GSPI_HCI = n
########################## Features ###########################
CONFIG_MP_INCLUDED = n
CONFIG_CONCURRENT_MODE = n
CONFIG_POWER_SAVING = n
CONFIG_POWER_SAVE = n
CONFIG_IPS_MODE = default
CONFIG_LPS_MODE = default
CONFIG_BTC = n
CONFIG_WAPI_SUPPORT = n
CONFIG_EFUSE_CONFIG_FILE = y
CONFIG_EXT_CLK = n
CONFIG_TRAFFIC_PROTECT = n
CONFIG_LOAD_PHY_PARA_FROM_FILE = y
# Remember to set CONFIG_FILE_FWIMG when set CONFIG_FILE_FWIMG to y,
# or driver will fail on ifconfig up because can't find firmware file
CONFIG_FILE_FWIMG = n
CONFIG_TXPWR_BY_RATE = n
CONFIG_TXPWR_BY_RATE_EN = auto
CONFIG_TXPWR_LIMIT = n
CONFIG_TXPWR_LIMIT_EN = auto
CONFIG_RTW_CHPLAN = 0xFF
CONFIG_RTW_ADAPTIVITY_EN = disable
CONFIG_RTW_ADAPTIVITY_MODE = normal
CONFIG_SIGNAL_SCALE_MAPPING = n
CONFIG_80211W = y
CONFIG_REDUCE_TX_CPU_LOADING = n
CONFIG_BR_EXT = y
CONFIG_TDLS = n
CONFIG_WIFI_MONITOR = y
CONFIG_MCC_MODE = n
CONFIG_APPEND_VENDOR_IE_ENABLE = n
CONFIG_RTW_NAPI = y
CONFIG_RTW_GRO = y
CONFIG_RTW_NETIF_SG = y
CONFIG_RTW_IPCAM_APPLICATION = n
CONFIG_ICMP_VOQ = n
CONFIG_IP_R_MONITOR = n #arp VOQ and high rate
# user priority mapping rule : tos, dscp
CONFIG_RTW_UP_MAPPING_RULE = tos

CONFIG_PHL_ARCH = y
CONFIG_FSM = n
CONFIG_CMD_DISP = y

CONFIG_HWSIM = n

CONFIG_PHL_TEST_SUITE = n
CONFIG_WIFI_6 = y

RTW_PHL_RX = y
RTW_PHL_TX = y
RTW_PHL_BCN = y
DIRTY_FOR_WORK = y

CONFIG_DRV_FAKE_AP = n

CONFIG_DBG_AX_CAM = n

USE_TRUE_PHY = y
CONFIG_I386_BUILD_VERIFY = n
CONFIG_RTW_MBO = n
# AMSDU in security network
CONFIG_SEC_AMSDU_MODE = non-spp
########################## Android ###########################
# CONFIG_RTW_ANDROID - 0: no Android, 4/5/6/7/8/9/10 : Android version
CONFIG_RTW_ANDROID = 0

ifeq ($(shell test $(CONFIG_RTW_ANDROID) -gt 0; echo $$?), 0)
EXTRA_CFLAGS += -DCONFIG_RTW_ANDROID=$(CONFIG_RTW_ANDROID)
endif

########################## Debug ###########################
CONFIG_RTW_DEBUG = 0
# default log level is _DRV_WARNING_ = 3,
# please refer to "How_to_set_driver_debug_log_level.doc" to set the available level.
CONFIG_RTW_LOG_LEVEL = 3

# enable /proc/net/rtlxxxx/ debug interfaces
CONFIG_PROC_DEBUG = n

######################## Wake On Lan ##########################
CONFIG_WOWLAN = n
#bit2: deauth, bit1: unicast, bit0: magic pkt.
CONFIG_WAKEUP_TYPE = 0x7
CONFIG_WOW_LPS_MODE = default
#bit0: disBBRF off, #bit1: Wireless remote controller (WRC)
CONFIG_SUSPEND_TYPE = 0
CONFIG_WOW_STA_MIX = n
CONFIG_GPIO_WAKEUP = n
# Please contact with RTK support team first. After getting the agreement from RTK support team, 
# you are just able to modify the CONFIG_WAKEUP_GPIO_IDX with customized requirement.
CONFIG_WAKEUP_GPIO_IDX = default
CONFIG_HIGH_ACTIVE_DEV2HST = n
######### only for USB #########
CONFIG_ONE_PIN_GPIO = n
CONFIG_HIGH_ACTIVE_HST2DEV = n
CONFIG_PNO_SUPPORT = n
CONFIG_PNO_SET_DEBUG = n
CONFIG_AP_WOWLAN = n
######### Notify SDIO Host Keep Power During Syspend ##########
CONFIG_RTW_SDIO_PM_KEEP_POWER = y
###################### MP HW TX MODE FOR VHT #######################
CONFIG_MP_VHT_HW_TX_MODE = n

###################### ROAMING #####################################
CONFIG_LAYER2_ROAMING = y
#bit0: ROAM_ON_EXPIRED, #bit1: ROAM_ON_RESUME, #bit2: ROAM_ACTIVE
CONFIG_ROAMING_FLAG = 0x3

###################### Platform Related #######################
CONFIG_PLATFORM_I386_PC = y
CONFIG_PLATFORM_RTL8198D = n
CONFIG_PLATFORM_ANDROID_X86 = n
CONFIG_PLATFORM_ANDROID_INTEL_X86 = n
CONFIG_PLATFORM_NV_TK1 = n
CONFIG_PLATFORM_NV_TK1_UBUNTU = n
CONFIG_PLATFORM_ARM_SUNxI = n
CONFIG_PLATFORM_RTK1319 = n
CONFIG_PLATFORM_AML_S905 = n

########### CUSTOMER ################################

CONFIG_DRVEXT_MODULE = n

export TopDIR ?= $(shell pwd)

########### COMMON  #################################
ifeq ($(CONFIG_GSPI_HCI), y)
HCI_NAME = gspi
endif

ifeq ($(CONFIG_SDIO_HCI), y)
HCI_NAME = sdio
endif

ifeq ($(CONFIG_USB_HCI), y)
HCI_NAME = usb
endif

ifeq ($(CONFIG_PCI_HCI), y)
HCI_NAME = pci
endif

ifeq ($(CONFIG_HWSIM), y)
	HAL = hal_sim
else
	HAL = phl
endif

ifeq ($(CONFIG_PLATFORM_RTL8198D), y)
DRV_PATH = $(src)
else
DRV_PATH = $(TopDIR)
endif

########### HAL_RTL8852A #################################
ifeq ($(CONFIG_RTL8852A), y)
IC_NAME := rtl8852a
ifeq ($(CONFIG_USB_HCI), y)
MODULE_NAME = 8852au
endif
ifeq ($(CONFIG_PCI_HCI), y)
MODULE_NAME = 8852ae
endif
ifeq ($(CONFIG_SDIO_HCI), y)
MODULE_NAME = 8852as
endif

endif

########### HAL_RTL8852B #################################
ifeq ($(CONFIG_RTL8852B), y)
IC_NAME := rtl8852b
ifeq ($(CONFIG_USB_HCI), y)
MODULE_NAME = 8852bu
endif
ifeq ($(CONFIG_PCI_HCI), y)
MODULE_NAME = 8852be
endif
ifeq ($(CONFIG_SDIO_HCI), y)
MODULE_NAME = 8852bs
endif

endif

########### HAL_RTL8852C #################################
ifeq ($(CONFIG_RTL8852C), y)
IC_NAME := rtl8852c
ifeq ($(CONFIG_USB_HCI), y)
MODULE_NAME = 8852cu
endif
ifeq ($(CONFIG_PCI_HCI), y)
MODULE_NAME = 8852ce
endif
ifeq ($(CONFIG_SDIO_HCI), y)
MODULE_NAME = 8852cs
endif

endif

########### AUTO_CFG  #################################

ifeq ($(CONFIG_AUTOCFG_CP), y)
$(shell cp $(DRV_PATH)/autoconf_$(IC_NAME)_$(HCI_NAME)_linux.h $(DRV_PATH)/include/autoconf.h)
endif

########### END OF PATH  #################################
ifeq ($(CONFIG_MP_INCLUDED), y)
#MODULE_NAME := $(MODULE_NAME)_mp
EXTRA_CFLAGS += -DCONFIG_MP_INCLUDED
CONFIG_PHL_TEST_SUITE = y
endif

ifeq ($(CONFIG_FSM), y)
EXTRA_CFLAGS += -DCONFIG_FSM
endif

ifeq ($(CONFIG_CMD_DISP), y)
EXTRA_CFLAGS += -DCONFIG_CMD_DISP
endif

ifeq ($(CONFIG_PHL_TEST_SUITE), y)
EXTRA_CFLAGS += -DCONFIG_PHL_TEST_SUITE
endif

ifeq ($(CONFIG_CONCURRENT_MODE), y)
EXTRA_CFLAGS += -DCONFIG_CONCURRENT_MODE
endif

ifeq ($(CONFIG_POWER_SAVING), y)
ifneq ($(CONFIG_IPS_MODE), default)
EXTRA_CFLAGS += -DRTW_IPS_MODE=$(CONFIG_IPS_MODE)
endif
ifneq ($(CONFIG_LPS_MODE), default)
EXTRA_CFLAGS += -DRTW_LPS_MODE=$(CONFIG_LPS_MODE)
endif
ifneq ($(CONFIG_WOW_LPS_MODE), default)
EXTRA_CFLAGS += -DRTW_WOW_LPS_MODE=$(CONFIG_WOW_LPS_MODE)
endif
EXTRA_CFLAGS += -DCONFIG_POWER_SAVING
endif
ifeq ($(CONFIG_POWER_SAVE), y)
EXTRA_CFLAGS += -DCONFIG_POWER_SAVE
endif

ifeq ($(CONFIG_BTC), y)
EXTRA_CFLAGS += -DCONFIG_BTC
endif

ifeq ($(CONFIG_WAPI_SUPPORT), y)
EXTRA_CFLAGS += -DCONFIG_WAPI_SUPPORT
endif

ifeq ($(CONFIG_WIFI_6), y)
EXTRA_CFLAGS += -DCONFIG_WIFI_6
endif

ifeq ($(CONFIG_EFUSE_CONFIG_FILE), y)
EXTRA_CFLAGS += -DCONFIG_EFUSE_CONFIG_FILE

#EFUSE_MAP_PATH
USER_EFUSE_MAP_PATH ?=
ifneq ($(USER_EFUSE_MAP_PATH),)
EXTRA_CFLAGS += -DEFUSE_MAP_PATH=\"$(USER_EFUSE_MAP_PATH)\"
else
EXTRA_CFLAGS += -DEFUSE_MAP_PATH=\"/system/etc/wifi/wifi_efuse_$(MODULE_NAME).map\"
endif

#WIFIMAC_PATH
USER_WIFIMAC_PATH ?=
ifneq ($(USER_WIFIMAC_PATH),)
EXTRA_CFLAGS += -DWIFIMAC_PATH=\"$(USER_WIFIMAC_PATH)\"
else
EXTRA_CFLAGS += -DWIFIMAC_PATH=\"/data/wifimac.txt\"
endif

endif

ifeq ($(CONFIG_EXT_CLK), y)
EXTRA_CFLAGS += -DCONFIG_EXT_CLK
endif

ifeq ($(CONFIG_TRAFFIC_PROTECT), y)
EXTRA_CFLAGS += -DCONFIG_TRAFFIC_PROTECT
endif

ifeq ($(CONFIG_LOAD_PHY_PARA_FROM_FILE), y)
EXTRA_CFLAGS += -DCONFIG_LOAD_PHY_PARA_FROM_FILE
#EXTRA_CFLAGS += -DREALTEK_CONFIG_PATH_WITH_IC_NAME_FOLDER
EXTRA_CFLAGS += -DREALTEK_CONFIG_PATH=\"/lib/firmware/\"
endif

ifeq ($(CONFIG_FILE_FWIMG), y)
EXTRA_CFLAGS += -DCONFIG_FILE_FWIMG
# default external firmware path is [CONFIG_FIRMWARE_PATH][ic_name]/[fw_name]
# ex. Take 8852AE as example:
#     normal firmware is [CONFIG_FIRMWARE_PATH]rtl8852ae/rtl8852afw.bin
#     WOW firmware is [CONFIG_FIRMWARE_PATH]rtl8852ae/rtl8852afw_wowlan.bin
EXTRA_CFLAGS += -DCONFIG_FIRMWARE_PATH=\"\"
# EXTRA_CFLAGS += -DCONFIG_FIRMWARE_PATH=\"/lib/firmware/\"
endif

ifeq ($(CONFIG_TXPWR_BY_RATE), n)
EXTRA_CFLAGS += -DCONFIG_TXPWR_BY_RATE=0
else ifeq ($(CONFIG_TXPWR_BY_RATE), y)
EXTRA_CFLAGS += -DCONFIG_TXPWR_BY_RATE=1
endif
ifeq ($(CONFIG_TXPWR_BY_RATE_EN), n)
EXTRA_CFLAGS += -DCONFIG_TXPWR_BY_RATE_EN=0
else ifeq ($(CONFIG_TXPWR_BY_RATE_EN), y)
EXTRA_CFLAGS += -DCONFIG_TXPWR_BY_RATE_EN=1
else ifeq ($(CONFIG_TXPWR_BY_RATE_EN), auto)
EXTRA_CFLAGS += -DCONFIG_TXPWR_BY_RATE_EN=2
endif

ifeq ($(CONFIG_TXPWR_LIMIT), n)
EXTRA_CFLAGS += -DCONFIG_TXPWR_LIMIT=0
else ifeq ($(CONFIG_TXPWR_LIMIT), y)
EXTRA_CFLAGS += -DCONFIG_TXPWR_LIMIT=1
endif
ifeq ($(CONFIG_TXPWR_LIMIT_EN), n)
EXTRA_CFLAGS += -DCONFIG_TXPWR_LIMIT_EN=0
else ifeq ($(CONFIG_TXPWR_LIMIT_EN), y)
EXTRA_CFLAGS += -DCONFIG_TXPWR_LIMIT_EN=1
else ifeq ($(CONFIG_TXPWR_LIMIT_EN), auto)
EXTRA_CFLAGS += -DCONFIG_TXPWR_LIMIT_EN=2
endif

ifneq ($(CONFIG_RTW_CHPLAN), 0xFF)
EXTRA_CFLAGS += -DCONFIG_RTW_CHPLAN=$(CONFIG_RTW_CHPLAN)
endif

ifeq ($(CONFIG_CALIBRATE_TX_POWER_BY_REGULATORY), y)
EXTRA_CFLAGS += -DCONFIG_CALIBRATE_TX_POWER_BY_REGULATORY
endif

ifeq ($(CONFIG_CALIBRATE_TX_POWER_TO_MAX), y)
EXTRA_CFLAGS += -DCONFIG_CALIBRATE_TX_POWER_TO_MAX
endif

ifeq ($(CONFIG_RTW_ADAPTIVITY_EN), disable)
EXTRA_CFLAGS += -DCONFIG_RTW_ADAPTIVITY_EN=0
else ifeq ($(CONFIG_RTW_ADAPTIVITY_EN), enable)
EXTRA_CFLAGS += -DCONFIG_RTW_ADAPTIVITY_EN=1
endif

ifeq ($(CONFIG_RTW_ADAPTIVITY_MODE), normal)
EXTRA_CFLAGS += -DCONFIG_RTW_ADAPTIVITY_MODE=0
else ifeq ($(CONFIG_RTW_ADAPTIVITY_MODE), carrier_sense)
EXTRA_CFLAGS += -DCONFIG_RTW_ADAPTIVITY_MODE=1
endif

ifeq ($(CONFIG_SIGNAL_SCALE_MAPPING), y)
EXTRA_CFLAGS += -DCONFIG_SIGNAL_SCALE_MAPPING
endif

ifeq ($(CONFIG_80211W), y)
EXTRA_CFLAGS += -DCONFIG_IEEE80211W
endif

ifeq ($(CONFIG_WOWLAN), y)
EXTRA_CFLAGS += -DCONFIG_WOWLAN -DRTW_WAKEUP_EVENT=$(CONFIG_WAKEUP_TYPE)
EXTRA_CFLAGS += -DRTW_SUSPEND_TYPE=$(CONFIG_SUSPEND_TYPE)
ifeq ($(CONFIG_WOW_STA_MIX), y)
EXTRA_CFLAGS += -DRTW_WOW_STA_MIX
endif
ifeq ($(CONFIG_SDIO_HCI), y)
EXTRA_CFLAGS += -DCONFIG_RTW_SDIO_PM_KEEP_POWER
endif
endif

ifeq ($(CONFIG_AP_WOWLAN), y)
EXTRA_CFLAGS += -DCONFIG_AP_WOWLAN
ifeq ($(CONFIG_SDIO_HCI), y)
EXTRA_CFLAGS += -DCONFIG_RTW_SDIO_PM_KEEP_POWER
endif
endif

ifeq ($(CONFIG_LAYER2_ROAMING), y)
	EXTRA_CFLAGS += -DCONFIG_LAYER2_ROAMING -DCONFIG_ROAMING_FLAG=$(CONFIG_ROAMING_FLAG)
endif

ifeq ($(CONFIG_PNO_SUPPORT), y)
EXTRA_CFLAGS += -DCONFIG_PNO_SUPPORT
ifeq ($(CONFIG_PNO_SET_DEBUG), y)
EXTRA_CFLAGS += -DCONFIG_PNO_SET_DEBUG
endif
endif

ifeq ($(CONFIG_GPIO_WAKEUP), y)
EXTRA_CFLAGS += -DCONFIG_GPIO_WAKEUP
ifeq ($(CONFIG_ONE_PIN_GPIO), y)
EXTRA_CFLAGS += -DCONFIG_RTW_ONE_PIN_GPIO
endif
ifeq ($(CONFIG_HIGH_ACTIVE_DEV2HST), y)
EXTRA_CFLAGS += -DHIGH_ACTIVE_DEV2HST=1
else
EXTRA_CFLAGS += -DHIGH_ACTIVE_DEV2HST=0
endif
endif

ifeq ($(CONFIG_HIGH_ACTIVE_HST2DEV), y)
EXTRA_CFLAGS += -DHIGH_ACTIVE_HST2DEV=1
else
EXTRA_CFLAGS += -DHIGH_ACTIVE_HST2DEV=0
endif

ifneq ($(CONFIG_WAKEUP_GPIO_IDX), default)
EXTRA_CFLAGS += -DWAKEUP_GPIO_IDX=$(CONFIG_WAKEUP_GPIO_IDX)
endif

ifeq ($(CONFIG_RTW_SDIO_PM_KEEP_POWER), y)
ifeq ($(CONFIG_SDIO_HCI), y)
EXTRA_CFLAGS += -DCONFIG_RTW_SDIO_PM_KEEP_POWER
endif
endif

ifeq ($(CONFIG_REDUCE_TX_CPU_LOADING), y)
EXTRA_CFLAGS += -DCONFIG_REDUCE_TX_CPU_LOADING
endif

ifeq ($(CONFIG_BR_EXT), y)
BR_NAME = br0
EXTRA_CFLAGS += -DCONFIG_BR_EXT
EXTRA_CFLAGS += '-DCONFIG_BR_EXT_BRNAME="'$(BR_NAME)'"'
endif


ifeq ($(CONFIG_TDLS), y)
EXTRA_CFLAGS += -DCONFIG_TDLS
endif

ifeq ($(CONFIG_WIFI_MONITOR), y)
EXTRA_CFLAGS += -DCONFIG_WIFI_MONITOR
endif

ifeq ($(CONFIG_MCC_MODE), y)
EXTRA_CFLAGS += -DCONFIG_MCC_MODE
endif

ifeq ($(CONFIG_RTW_NAPI), y)
EXTRA_CFLAGS += -DCONFIG_RTW_NAPI
endif

ifeq ($(CONFIG_RTW_GRO), y)
EXTRA_CFLAGS += -DCONFIG_RTW_GRO
endif

ifeq ($(CONFIG_RTW_IPCAM_APPLICATION), y)
EXTRA_CFLAGS += -DCONFIG_RTW_IPCAM_APPLICATION
ifeq ($(CONFIG_WIFI_MONITOR), n)
EXTRA_CFLAGS += -DCONFIG_WIFI_MONITOR
endif
endif

ifeq ($(CONFIG_RTW_NETIF_SG), y)
EXTRA_CFLAGS += -DCONFIG_RTW_NETIF_SG
endif

ifeq ($(CONFIG_ICMP_VOQ), y)
EXTRA_CFLAGS += -DCONFIG_ICMP_VOQ
endif

ifeq ($(CONFIG_IP_R_MONITOR), y)
EXTRA_CFLAGS += -DCONFIG_IP_R_MONITOR
endif

ifeq ($(CONFIG_MP_VHT_HW_TX_MODE), y)
EXTRA_CFLAGS += -DCONFIG_MP_VHT_HW_TX_MODE
ifeq ($(CONFIG_PLATFORM_I386_PC), y)
## For I386 X86 ToolChain use Hardware FLOATING
EXTRA_CFLAGS += -mhard-float
else
## For ARM ToolChain use Hardware FLOATING
EXTRA_CFLAGS += -mfloat-abi=hard
endif
endif

ifeq ($(CONFIG_APPEND_VENDOR_IE_ENABLE), y)
EXTRA_CFLAGS += -DCONFIG_APPEND_VENDOR_IE_ENABLE
endif

ifeq ($(CONFIG_RTW_DEBUG), y)
EXTRA_CFLAGS += -DCONFIG_RTW_DEBUG
EXTRA_CFLAGS += -DRTW_LOG_LEVEL=$(CONFIG_RTW_LOG_LEVEL)
endif

ifeq ($(CONFIG_PROC_DEBUG), y)
EXTRA_CFLAGS += -DCONFIG_PROC_DEBUG
endif

ifeq ($(CONFIG_RTW_UP_MAPPING_RULE), dscp)
EXTRA_CFLAGS += -DCONFIG_RTW_UP_MAPPING_RULE=1
else
EXTRA_CFLAGS += -DCONFIG_RTW_UP_MAPPING_RULE=0
endif

EXTRA_CFLAGS += -DPLATFORM_LINUX

ifeq ($(USE_TRUE_PHY), y)
EXTRA_CFLAGS += -DUSE_TRUE_PHY
endif

ifeq ($(CONFIG_HWSIM), y)
EXTRA_CFLAGS += -DCONFIG_HWSIM

# To use pure sw beacon
EXTRA_CFLAGS += -DCONFIG_SWTIMER_BASED_TXBCN
EXTRA_CFLAGS += -DCONFIG_SUPPORT_MULTI_BCN
endif

ifeq ($(CONFIG_DRV_FAKE_AP), y)
EXTRA_CFLAGS += -DCONFIG_DRV_FAKE_AP
OBJS += core/rtw_fake_ap.o
endif

ifeq ($(CONFIG_DBG_AX_CAM), y)
EXTRA_CFLAGS += -DCONFIG_DBG_AX_CAM
endif

ifeq ($(CONFIG_I386_BUILD_VERIFY), y)
EXTRA_CFLAGS += -DCONFIG_I386_BUILD_VERIFY
endif

ifeq ($(CONFIG_RTW_MBO), y)
EXTRA_CFLAGS += -DCONFIG_RTW_MBO -DCONFIG_RTW_WNM -DCONFIG_RTW_BTM_ROAM
#EXTRA_CFLAGS += -DCONFIG_RTW_80211K
EXTRA_CFLAGS += -DCONFIG_RTW_80211R
endif

ifeq ($(CONFIG_SEC_AMSDU_MODE), non-spp)
EXTRA_CFLAGS += -DRTW_AMSDU_MODE=0
else ifeq ($(CONFIG_SEC_AMSDU_MODE), spp)
EXTRA_CFLAGS += -DRTW_AMSDU_MODE=1
else ifeq ($(CONFIG_SEC_AMSDU_MODE), disable)
EXTRA_CFLAGS += -DRTW_AMSDU_MODE=2
endif

SUBARCH := $(shell uname -m | sed -e "s/i.86/i386/; s/ppc.*/powerpc/; s/armv.l/arm/; s/aarch64/arm64/;")
ARCH ?= $(SUBARCH)

########### PLATFORM OPS  ##########################
# Import platform assigned KSRC and CROSS_COMPILE
# include $(wildcard $(DRV_PATH)/platform/*.mk)
# aml_s905
ifeq ($(CONFIG_PLATFORM_AML_S905), y)
EXTRA_CFLAGS += -DCONFIG_PLATFORM_AML_S905
EXTRA_CFLAGS += -DCONFIG_LITTLE_ENDIAN
EXTRA_CFLAGS += -DCONFIG_IOCTL_CFG80211 -DRTW_USE_CFG80211_STA_EVENT
EXTRA_CFLAGS += -DCONFIG_RADIO_WORK
EXTRA_CFLAGS += -DCONFIG_CONCURRENT_MODE
# default setting for Android
# config CONFIG_RTW_ANDROID in main Makefile
ARCH ?= arm64
CROSS_COMPILE ?= /home/Jimmy/amlogic_905x4+8852AS/skw-rtk/cross_compile_toolchain/gcc-linaro-6.3.1-2017.02-x86_64_aarch64-linux-gnu/bin/aarch64-linux-gnu-
ifndef KSRC
KSRC := /home/Jimmy/amlogic_905x4+8852AS/skw-rtk/kernel
# To locate output files in a separate directory.
KSRC += O=/home/Jimmy/amlogic_905x4+8852AS/skw-rtk/kernel_obj
endif
ifeq ($(CONFIG_PCI_HCI), y)
EXTRA_CFLAGS += -DCONFIG_PLATFORM_OPS
_PLATFORM_FILES := platform/platform_linux_pc_pci.o
OBJS += $(_PLATFORM_FILES)
endif
ifeq ($(CONFIG_RTL8852A), y)
ifeq ($(CONFIG_SDIO_HCI), y)
CONFIG_RTL8852AS ?= m
USER_MODULE_NAME := 8852as
endif
ifeq ($(CONFIG_PCI_HCI), y)
CONFIG_RTL8852AE ?= m
USER_MODULE_NAME := 8852ae
endif
endif
endif

# android_intel_x86
ifeq ($(CONFIG_PLATFORM_ANDROID_INTEL_X86), y)
EXTRA_CFLAGS += -DCONFIG_PLATFORM_ANDROID_INTEL_X86
EXTRA_CFLAGS += -DCONFIG_PLATFORM_INTEL_BYT
EXTRA_CFLAGS += -DCONFIG_LITTLE_ENDIAN -DCONFIG_PLATFORM_ANDROID
EXTRA_CFLAGS += -DCONFIG_CONCURRENT_MODE
EXTRA_CFLAGS += -DCONFIG_IOCTL_CFG80211 -DRTW_USE_CFG80211_STA_EVENT
EXTRA_CFLAGS += -DCONFIG_SKIP_SIGNAL_SCALE_MAPPING
ifeq ($(CONFIG_SDIO_HCI), y)
EXTRA_CFLAGS += -DCONFIG_RESUME_IN_WORKQUEUE
endif
endif

#android_x86
ifeq ($(CONFIG_PLATFORM_ANDROID_X86), y)
EXTRA_CFLAGS += -DCONFIG_LITTLE_ENDIAN
SUBARCH := $(shell uname -m | sed -e s/i.86/i386/)
ARCH := $(SUBARCH)
CROSS_COMPILE := /media/DATA-2/android-x86/ics-x86_20120130/prebuilt/linux-x86/toolchain/i686-unknown-linux-gnu-4.2.1/bin/i686-unknown-linux-gnu-
KSRC := /media/DATA-2/android-x86/ics-x86_20120130/out/target/product/generic_x86/obj/kernel
MODULE_NAME :=wlan
endif

#arm_1319
ifeq ($(CONFIG_PLATFORM_RTK1319), y)
EXTRA_CFLAGS += -DCONFIG_LITTLE_ENDIAN
EXTRA_CFLAGS += -DCONFIG_IOCTL_CFG80211 -DRTW_USE_CFG80211_STA_EVENT
EXTRA_CFLAGS += -DCONFIG_RADIO_WORK
EXTRA_CFLAGS += -DCONFIG_CONCURRENT_MODE
EXTRA_CFLAGS += -DRTK_1319_PLATFORM -DCONFIG_RF4CE_COEXIST
ARCH ?= arm
# For Android 10
#CROSS_COMPILE :=/sweethome/zhenrc/Workshop/1619/atv-9.0/phoenix/toolchain/asdk-6.4.1-a53-EL-4.9-g2.26-a32nut-180831/bin/arm-linux-gnueabi-
#KSRC :=/sweethome/zhenrc/Workshop/1619/atv-9.0/hydra/linux-kernel-1319
# For TV image
CROSS_COMPILE :=/sweethome/zhenrc/Workshop/1619/atv-9.0/phoenix/toolchain/asdk-6.4.1-a53-EL-4.9-g2.26-a32nut-180831/bin/arm-linux-gnueabi-
KSRC := /sweethome/zhenrc/Workshop/1319/q_tv_kernel_ax
ifeq ($(CONFIG_PCI_HCI), y)
EXTRA_CFLAGS += -DCONFIG_PLATFORM_OPS
_PLATFORM_FILES := platform/platform_linux_pc_pci.o
OBJS += $(_PLATFORM_FILES)
endif
endif

#arm_sunxi
ifeq ($(CONFIG_PLATFORM_ARM_SUNxI), y)
EXTRA_CFLAGS += -DCONFIG_LITTLE_ENDIAN
EXTRA_CFLAGS += -DCONFIG_PLATFORM_ARM_SUNxI
# default setting for Android 4.1, 4.2
EXTRA_CFLAGS += -DCONFIG_CONCURRENT_MODE
EXTRA_CFLAGS += -DCONFIG_IOCTL_CFG80211 -DRTW_USE_CFG80211_STA_EVENT
EXTRA_CFLAGS += -DCONFIG_PLATFORM_OPS
ifeq ($(CONFIG_USB_HCI), y)
EXTRA_CFLAGS += -DCONFIG_USE_USB_BUFFER_ALLOC_TX
_PLATFORM_FILES += platform/platform_ARM_SUNxI_usb.o
endif
ifeq ($(CONFIG_SDIO_HCI), y)
# default setting for A10-EVB mmc0
#EXTRA_CFLAGS += -DCONFIG_WITS_EVB_V13
_PLATFORM_FILES += platform/platform_ARM_SUNxI_sdio.o
endif
ARCH := arm
#CROSS_COMPILE := arm-none-linux-gnueabi-
CROSS_COMPILE=/home/android_sdk/Allwinner/a10/android-jb42/lichee-jb42/buildroot/output/external-toolchain/bin/arm-none-linux-gnueabi-
KVER  := 3.0.8
#KSRC:= ../lichee/linux-3.0/
KSRC=/home/android_sdk/Allwinner/a10/android-jb42/lichee-jb42/linux-3.0
endif

#i386_pc
ifeq ($(CONFIG_PLATFORM_I386_PC), y)
EXTRA_CFLAGS += -DCONFIG_LITTLE_ENDIAN
EXTRA_CFLAGS += -DCONFIG_IOCTL_CFG80211 -DRTW_USE_CFG80211_STA_EVENT
EXTRA_CFLAGS += -DCONFIG_RADIO_WORK
#EXTRA_CFLAGS += -DCONFIG_CONCURRENT_MODE
SUBARCH := $(shell uname -m | sed -e s/i.86/i386/)
ARCH ?= $(SUBARCH)
CROSS_COMPILE ?=
KVER  := $(shell uname -r)
KSRC := /lib/modules/$(KVER)/build
MODDESTDIR := /lib/modules/$(KVER)/kernel/drivers/net/wireless/
INSTALL_PREFIX :=
STAGINGMODDIR := /lib/modules/$(KVER)/kernel/drivers/staging
ifeq ($(CONFIG_PCI_HCI), y)
EXTRA_CFLAGS += -DCONFIG_PLATFORM_OPS
_PLATFORM_FILES := platform/platform_linux_pc_pci.o
OBJS += $(_PLATFORM_FILES)
endif
endif

# Import platform specific compile options
EXTRA_CFLAGS += -I$(src)/platform
#_PLATFORM_FILES := platform/platform_ops.o
OBJS += $(_PLATFORM_FILES)

########### CUSTOMER ################################
USER_MODULE_NAME ?=
ifneq ($(USER_MODULE_NAME),)
MODULE_NAME := $(USER_MODULE_NAME)
endif

ifneq ($(KERNELRELEASE),)
########### COMMON #################################
########### OS_DEP PATH  #################################
_OS_INTFS_FILES :=	os_dep/osdep_service.o \
			os_dep/osdep_service_linux.o \
			os_dep/linux/rtw_cfg.o \
			os_dep/linux/os_intfs.o \
			os_dep/linux/ioctl_linux.o \
			os_dep/linux/xmit_linux.o \
			os_dep/linux/mlme_linux.o \
			os_dep/linux/recv_linux.o \
			os_dep/linux/ioctl_cfg80211.o \
			os_dep/linux/rtw_cfgvendor.o \
			os_dep/linux/wifi_regd.o \
			os_dep/linux/rtw_android.o \
			os_dep/linux/rtw_proc.o \
			os_dep/linux/nlrtw.o \
			os_dep/linux/rtw_rhashtable.o

ifeq ($(CONFIG_HWSIM), y)
	_OS_INTFS_FILES += os_dep/linux/hwsim/medium/local.o
	_OS_INTFS_FILES += os_dep/linux/hwsim/medium/sock_udp.o
	_OS_INTFS_FILES += os_dep/linux/hwsim/medium/loopback.o
	_OS_INTFS_FILES += os_dep/linux/hwsim/core.o
	_OS_INTFS_FILES += os_dep/linux/hwsim/txrx.o
	_OS_INTFS_FILES += os_dep/linux/hwsim/netdev.o
	_OS_INTFS_FILES += os_dep/linux/hwsim/cfg80211.o
	_OS_INTFS_FILES += os_dep/linux/hwsim/platform_dev.o

	_OS_INTFS_FILES += os_dep/linux/$(HCI_NAME)_ops_linux.o
else
	_OS_INTFS_FILES += os_dep/linux/$(HCI_NAME)_intf.o
	_OS_INTFS_FILES += os_dep/linux/$(HCI_NAME)_ops_linux.o
endif

ifeq ($(CONFIG_MP_INCLUDED), y)
_OS_INTFS_FILES += os_dep/linux/ioctl_mp.o \
		os_dep/linux/ioctl_efuse.o
endif

ifeq ($(CONFIG_SDIO_HCI), y)
_OS_INTFS_FILES += os_dep/linux/custom_gpio_linux.o
endif

ifeq ($(CONFIG_GSPI_HCI), y)
_OS_INTFS_FILES += os_dep/linux/custom_gpio_linux.o
endif

########### CORE PATH  #################################
_CORE_FILES :=	core/rtw_cmd.o \
		core/rtw_security.o \
		core/rtw_debug.o \
		core/rtw_io.o \
		core/rtw_ioctl_query.o \
		core/rtw_ioctl_set.o \
		core/rtw_ieee80211.o \
		core/rtw_mlme.o \
		core/rtw_mlme_ext.o \
		core/rtw_sec_cam.o \
		core/rtw_mi.o \
		core/rtw_wlan_util.o \
		core/rtw_vht.o \
		core/rtw_he.o \
		core/rtw_pwrctrl.o \
		core/rtw_rf.o \
		core/rtw_chplan.o \
		core/monitor/rtw_radiotap.o \
		core/rtw_recv.o \
		core/rtw_recv_shortcut.o \
		core/rtw_sta_mgt.o \
		core/rtw_ap.o \
		core/wds/rtw_wds.o \
		core/mesh/rtw_mesh.o \
		core/mesh/rtw_mesh_pathtbl.o \
		core/mesh/rtw_mesh_hwmp.o \
		core/rtw_xmit.o	\
		core/rtw_xmit_shortcut.o \
		core/rtw_p2p.o \
		core/rtw_tdls.o \
		core/rtw_br_ext.o \
		core/rtw_sreset.o \
		core/rtw_rm.o \
		core/rtw_rm_fsm.o \
		core/rtw_rm_util.o \
		core/rtw_trx.o \
		core/rtw_beamforming.o \
		core/rtw_scan.o
		#core/efuse/rtw_efuse.o

_CORE_FILES +=	core/rtw_phl.o \
		core/rtw_phl_cmd.o

EXTRA_CFLAGS += -I$(src)/core/crypto
_CORE_FILES += core/crypto/aes-internal.o \
		core/crypto/aes-internal-enc.o \
		core/crypto/aes-gcm.o \
		core/crypto/aes-ccm.o \
		core/crypto/aes-omac1.o \
		core/crypto/ccmp.o \
		core/crypto/gcmp.o \
		core/crypto/aes-siv.o \
		core/crypto/aes-ctr.o \
		core/crypto/sha256-internal.o \
		core/crypto/sha256.o \
		core/crypto/sha256-prf.o \
		core/crypto/rtw_crypto_wrap.o \
		core/rtw_swcrypto.o		

ifeq ($(CONFIG_WOWLAN), y)
_CORE_FILES += core/rtw_wow.o
endif

ifeq ($(CONFIG_PCI_HCI), y)
_CORE_FILES += core/rtw_trx_pci.o
endif

ifeq ($(CONFIG_USB_HCI), y)
_CORE_FILES += core/rtw_trx_usb.o
endif

ifeq ($(CONFIG_SDIO_HCI), y)
_CORE_FILES += core/rtw_sdio.o
_CORE_FILES += core/rtw_trx_sdio.o
endif

ifeq ($(CONFIG_MP_INCLUDED), y)
_CORE_FILES += core/rtw_mp.o
endif

ifeq ($(CONFIG_WAPI_SUPPORT), y)
_CORE_FILES += core/rtw_wapi.o	\
					core/rtw_wapi_sms4.o
endif

ifeq ($(CONFIG_BTC), y)
_CORE_FILES += core/rtw_btc.o
endif

ifeq ($(CONFIG_RTW_MBO), y)
_CORE_FILES +=	core/rtw_mbo.o core/rtw_ft.o core/rtw_wnm.o
endif

OBJS += $(_OS_INTFS_FILES) $(_CORE_FILES)


EXTRA_CFLAGS += -DPHL_PLATFORM_LINUX
EXTRA_CFLAGS += -DCONFIG_PHL_ARCH

ifeq ($(RTW_PHL_RX), y)
EXTRA_CFLAGS += -DRTW_PHL_RX
endif

ifeq ($(RTW_PHL_TX), y)
EXTRA_CFLAGS += -DRTW_PHL_TX
endif

ifeq ($(RTW_PHL_BCN), y)
EXTRA_CFLAGS += -DRTW_PHL_BCN
endif

ifeq ($(DIRTY_FOR_WORK), y)
EXTRA_CFLAGS += -DDIRTY_FOR_WORK
endif

########### COMMON PATH  #################################
ifeq ($(CONFIG_HWSIM), y)
	HAL = hal_sim
else
	ifeq ($(CONFIG_WIFI_6), y)
	HAL = hal_g6
	else
	HAL = hal
	endif
endif

ifeq ($(CONFIG_PHL_ARCH), y)
phl_path := phl/
phl_path_d1 := $(src)/phl/$(HAL)
else
phl_path :=
phl_path_d1 := $(src)/$(HAL)
endif

_PHL_FILES := $(phl_path)phl_init.o \
			$(phl_path)phl_debug.o \
			$(phl_path)phl_tx.o \
			$(phl_path)phl_rx.o \
			$(phl_path)phl_rx_agg.o \
			$(phl_path)phl_api_drv.o \
			$(phl_path)phl_role.o \
			$(phl_path)phl_sta.o \
			$(phl_path)phl_mr.o \
			$(phl_path)phl_sec.o \
			$(phl_path)phl_chan.o \
			$(phl_path)phl_sw_cap.o \
			$(phl_path)phl_util.o \
			$(phl_path)phl_pkt_ofld.o \
			$(phl_path)phl_connect.o \
			$(phl_path)phl_chan_info.o \
			$(phl_path)phl_wow.o\
			$(phl_path)phl_dm.o \
			$(phl_path)phl_chnlplan.o \
			$(phl_path)phl_country.o \
			$(phl_path)phl_chnlplan_6g.o \
			$(phl_path)phl_regulation.o \
			$(phl_path)phl_regulation_6g.o \
			$(phl_path)phl_led.o \
			$(phl_path)phl_trx_mit.o \
			$(phl_path)phl_acs.o \
			$(phl_path)phl_mcc.o \
			$(phl_path)phl_ecsa.o \
			$(phl_path)test/phl_dbg_cmd.o \
			$(phl_path)test/phl_ps_dbg_cmd.o \
			$(phl_path)phl_msg_hub.o \
			$(phl_path)phl_sound.o \
			$(phl_path)phl_twt.o \
			$(phl_path)phl_notify.o \
			$(phl_path)phl_sound_cmd.o \
			$(phl_path)phl_p2pps.o \
			$(phl_path)phl_ps.o \
			$(phl_path)phl_thermal.o

ifeq ($(CONFIG_FSM), y)
_PHL_FILES += $(phl_path)phl_fsm.o \
						$(phl_path)phl_cmd_fsm.o \
						$(phl_path)phl_cmd_job.o \
						$(phl_path)phl_ser_fsm.o \
						$(phl_path)phl_btc_fsm.o \
						$(phl_path)phl_scan_fsm.o \
						$(phl_path)phl_sound_fsm.o
endif

_PHL_FILES += $(phl_path)phl_cmd_dispatch_engine.o\
						$(phl_path)phl_cmd_dispatcher.o\
						$(phl_path)phl_cmd_dispr_controller.o \
						$(phl_path)phl_cmd_ser.o \
						$(phl_path)phl_cmd_general.o \
						$(phl_path)phl_cmd_scan.o \
						$(phl_path)phl_cmd_btc.o \
						$(phl_path)phl_sound_cmd.o \
						$(phl_path)phl_cmd_ps.o \
						$(phl_path)phl_watchdog.o

ifeq ($(CONFIG_PCI_HCI), y)
_PHL_FILES += $(phl_path)hci/phl_trx_pcie.o
endif
ifeq ($(CONFIG_USB_HCI), y)
_PHL_FILES += $(phl_path)hci/phl_trx_usb.o
endif
ifeq ($(CONFIG_SDIO_HCI), y)
_PHL_FILES += $(phl_path)hci/phl_trx_sdio.o
endif

ifeq ($(CONFIG_PHL_CUSTOM_FEATURE), y)
_PHL_FILES += $(phl_path)custom/phl_custom.o
ifeq ($(CONFIG_PHL_CUSTOM_FEATURE_FB), y)
_PHL_FILES += $(phl_path)custom/phl_custom_fb.o
endif
endif

ifeq ($(CONFIG_PHL_TEST_SUITE), y)
_PHL_FILES += $(phl_path)test/trx_test.o
_PHL_FILES += $(phl_path)test/test_module.o
_PHL_FILES += $(phl_path)test/cmd_disp_test.o
_PHL_FILES += $(phl_path)test/mp/phl_test_mp.o
_PHL_FILES += $(phl_path)test/mp/phl_test_mp_config.o
_PHL_FILES += $(phl_path)test/mp/phl_test_mp_tx.o
_PHL_FILES += $(phl_path)test/mp/phl_test_mp_rx.o
_PHL_FILES += $(phl_path)test/mp/phl_test_mp_reg.o
_PHL_FILES += $(phl_path)test/mp/phl_test_mp_efuse.o
_PHL_FILES += $(phl_path)test/mp/phl_test_mp_txpwr.o
_PHL_FILES += $(phl_path)test/mp/phl_test_mp_cal.o
_PHL_FILES += $(phl_path)test/verify/phl_test_verify.o
_PHL_FILES += $(phl_path)test/verify/dbcc/phl_test_dbcc.o
endif

OBJS += $(_PHL_FILES)

EXTRA_CFLAGS += -I$(phl_path_d1)
include $(phl_path_d1)/hal.mk



obj-$(CONFIG_RTL8852AU) := $(MODULE_NAME).o
obj-$(CPTCFG_RTL8852AE) := $(MODULE_NAME).o
$(MODULE_NAME)-y = $(OBJS)

else
export CONFIG_RTL8852AU = m
obj-m := $(MODULE_NAME).o

all: modules

modules:
	#rm -f .symvers.$(MODULE_NAME)
	echo $(phl_path_d1)
	$(MAKE) ARCH=$(ARCH) CROSS_COMPILE=$(CROSS_COMPILE) -C $(KSRC) M=$(shell pwd)  modules

	#cp Module.symvers .symvers.$(MODULE_NAME)

strip:
	$(CROSS_COMPILE)strip $(MODULE_NAME).ko --strip-unneeded


install:
	install -p -m 644 $(MODULE_NAME).ko  $(MODDESTDIR)
	/sbin/depmod -a ${KVER}

# install:
# 	@mkdir -p $(MODDESTDIR)realtek/rtw89/
# 	install -p -m 644 $(MODULE_NAME).ko  $(MODDESTDIR)realtek/rtw89/
# 	/sbin/depmod -a ${KVER}

uninstall:
	rm -f $(MODDESTDIR)/$(MODULE_NAME).ko
	/sbin/depmod -a ${KVER}

# uninstall:
# 	rm -f $(MODDESTDIR)realtek/rtw89/$(MODULE_NAME).ko
# 	/sbin/depmod -a ${KVER}


#.PHONY: modules clean sign
.PHONY: modules clean

# sign:
# 	@openssl req -new -x509 -newkey rsa:2048 -keyout MOK.priv -outform DER -out MOK.der -nodes -days 36500 -subj "/CN=Custom MOK/"
# 	@mokutil --import MOK.der
# 	@$(KSRC)/scripts/sign-file sha256 MOK.priv MOK.der 8852au.ko

# sign-install: all sign install

clean:
	$(MAKE) ARCH=$(ARCH) CROSS_COMPILE=$(CROSS_COMPILE) -C $(KSRC) M=$(shell pwd) clean

# clean:
# 	#$(MAKE) -C $(KSRC) M=$(shell pwd) clean
# 	cd $(HAL) ; rm -fr */*/*/*/*.mod.c */*/*/*/*.mod */*/*/*/*.o */*/*/*/.*.cmd */*/*/*/*.ko
# 	cd $(HAL) ; rm -fr */*/*/*.mod.c */*/*/*.mod */*/*/*.o */*/*/.*.cmd */*/*/*.ko
# 	cd $(HAL) ; rm -fr */*/*.mod.c */*/*.mod */*/*.o */*/.*.cmd */*/*.ko
# 	cd $(HAL) ; rm -fr */*.mod.c */*.mod */*.o */.*.cmd */*.ko
# 	cd $(HAL) ; rm -fr *.mod.c *.mod *.o .*.cmd *.ko
# 	cd core ; rm -fr */*.mod.c */*.mod */*.o */.*.cmd */*.ko
# 	cd core ; rm -fr *.mod.c *.mod *.o .*.cmd *.ko
# 	cd os_dep/linux ; rm -fr *.mod.c *.mod *.o .*.cmd *.ko
# 	cd os_dep/linux/hwsim ; rm -fr *.mod.c *.mod *.o .*.cmd *.ko
# 	cd os_dep ; rm -fr *.mod.c *.mod *.o .*.cmd *.ko
# 	cd platform ; rm -fr *.mod.c *.mod *.o .*.cmd *.ko
# 	rm -fr Module.symvers ; rm -fr Module.markers ; rm -fr modules.order
# 	rm -fr *.mod.c *.mod *.o .*.cmd *.ko *~
# 	rm -fr .tmp_versions
endif

