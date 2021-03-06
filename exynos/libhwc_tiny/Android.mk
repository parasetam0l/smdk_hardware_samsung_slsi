# Copyright (C) 2012 The Android Open Source Project
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

LOCAL_PATH:= $(call my-dir)
# HAL module implemenation, not prelinked and stored in
# hw/<COPYPIX_HARDWARE_MODULE_ID>.<ro.product.board>.so

include $(CLEAR_VARS)

LOCAL_PRELINK_MODULE := false
LOCAL_MODULE_RELATIVE_PATH := hw
LOCAL_SHARED_LIBRARIES := liblog libcutils libEGL libGLESv1_CM libhardware \
	libhardware_legacy libutils libsync \
	libexynosv4l2 libexynosutils libdisplay

LOCAL_CFLAGS += -DLOG_TAG=\"hwcomposer\"
LOCAL_CFLAGS += -DHLOG_CODE=0

LOCAL_C_INCLUDES += \
	$(TOP)/hardware/samsung_slsi/$(TARGET_SOC)/include \
	$(TOP)/hardware/samsung_slsi/$(TARGET_BOARD_PLATFORM)/include \
	$(TOP)/hardware/samsung_slsi/$(TARGET_SOC)/libhwcmodule \
	$(LOCAL_PATH)/../include \
	$(TOP)/hardware/samsung_slsi/exynos/libexynosutils


LOCAL_C_INCLUDES += $(LOCAL_PATH)/../libvppdisplay_tiny
LOCAL_SRC_FILES := ExynosHWC.cpp

LOCAL_MODULE := hwcomposer.exynos5
LOCAL_MODULE_TAGS := optional

include $(TOP)/hardware/samsung_slsi/exynos/BoardConfigCFlags.mk
include $(BUILD_SHARED_LIBRARY)

