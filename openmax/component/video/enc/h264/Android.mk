LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)

LOCAL_MODULE_TAGS := optional

LOCAL_SRC_FILES := \
	Exynos_OMX_H264enc.c \
	library_register.c

LOCAL_PRELINK_MODULE := false
LOCAL_MODULE := libOMX.Exynos.AVC.Encoder
LOCAL_MODULE_RELATIVE_PATH := omx

LOCAL_CFLAGS :=

ifeq ($(BOARD_USE_ANDROID), true)
LOCAL_CFLAGS += -DUSE_ANDROID
endif

ifeq ($(BOARD_USE_METADATABUFFERTYPE), true)
LOCAL_CFLAGS += -DUSE_METADATABUFFERTYPE

ifeq ($(BOARD_USE_ANDROIDOPAQUE), true)
LOCAL_CFLAGS += -DUSE_ANDROIDOPAQUE
endif
endif

ifeq ($(BOARD_USE_DMA_BUF), true)
LOCAL_CFLAGS += -DUSE_DMA_BUF
endif

ifeq ($(BOARD_USE_CSC_HW), true)
LOCAL_CFLAGS += -DUSE_CSC_HW
endif

ifeq ($(BOARD_USE_QOS_CTRL), true)
LOCAL_CFLAGS += -DUSE_QOS_CTRL
endif

ifeq ($(BOARD_USE_SINGLE_PLANE_IN_DRM), true)
LOCAL_CFLAGS += -DUSE_SINGLE_PLANE_IN_DRM
endif

LOCAL_ARM_MODE := arm

LOCAL_STATIC_LIBRARIES := libExynosOMX_Venc libExynosOMX_OSAL libExynosOMX_Basecomponent \
	libExynosVideoApi

LOCAL_SHARED_LIBRARIES := libc libdl libcutils libutils libui \
	libExynosOMX_Resourcemanager libcsc libexynosv4l2 libion libhardware

LOCAL_C_INCLUDES := \
	$(EXYNOS_OMX_INC)/exynos \
	$(EXYNOS_OMX_TOP)/osal \
	$(EXYNOS_OMX_TOP)/core \
	$(EXYNOS_OMX_COMPONENT)/common \
	$(EXYNOS_OMX_COMPONENT)/video/enc \
	$(EXYNOS_VIDEO_CODEC)/include \
	$(TOP)/hardware/samsung_slsi/exynos/include \
	$(TOP)/hardware/samsung_slsi/$(TARGET_BOARD_PLATFORM)/include \
	$(TOP)/hardware/samsung_slsi/exynos/kernel-3.18-headers

ifeq ($(BOARD_USE_SKYPE_HD), true)
LOCAL_CFLAGS += -DUSE_SKYPE_HD
LOCAL_CFLAGS += -DBUILD_ENC
LOCAL_C_INCLUDES += $(EXYNOS_OMX_INC)/skype
LOCAL_STATIC_LIBRARIES += libExynosOMX_SkypeHD_Enc
endif

ifeq ($(BOARD_USE_KHRONOS_OMX_HEADER), true)
LOCAL_CFLAGS += -DUSE_KHRONOS_OMX_HEADER
LOCAL_C_INCLUDES += $(EXYNOS_OMX_INC)/khronos
else
ifeq ($(BOARD_USE_ANDROID), true)
LOCAL_C_INCLUDES += $(ANDROID_MEDIA_INC)/openmax
endif
endif

include $(BUILD_SHARED_LIBRARY)
