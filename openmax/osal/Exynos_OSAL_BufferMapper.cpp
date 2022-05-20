/*
 * Copyright (C) 2020 The LineageOS Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#define LOG_TAG "Exynos_OSAL_BufferMapper"
#define LOG_NDEBUG 0

#include <string.h>
#include <stdint.h>
#include <errno.h>

#include <utils/Errors.h>
#include <utils/Log.h>
#include <utils/Trace.h>

#include <hardware/gralloc.h>

#include "Exynos_OSAL_BufferMapper.h"

namespace android {

ANDROID_SINGLETON_STATIC_INSTANCE( BufferMapper )

BufferMapper::BufferMapper()
	: mModule(nullptr)
{
	const hw_module_t* module;
	int err = hw_get_module(GRALLOC_HARDWARE_MODULE_ID, &module);

	ALOGE_IF(err, "cannot find gralloc-module %s", GRALLOC_HARDWARE_MODULE_ID);
	if (err == 0) {
		mModule = reinterpret_cast<gralloc_module_t const *>(module);
	}
}

android::status_t BufferMapper::lock(buffer_handle_t handle,
		uint32_t usage, uint32_t width, uint32_t height, void** vaddr)
{
	ATRACE_CALL();
	android::status_t err;

	if (mModule->lock == NULL) {
		ALOGW("lock(%p) not found", handle);
		return -EINVAL;
	}

	err = mModule->lock(mModule, handle, static_cast<int>(usage),
			0, 0, width, height, vaddr);

	ALOGW_IF(err, "lock(%p) failed: %d (%s)", handle, -err, strerror(-err));
	return err;
}

android::status_t BufferMapper::unlock(buffer_handle_t handle)
{
	ATRACE_CALL();
	android::status_t err;

	if (mModule->unlock == NULL) {
		ALOGW("unlock(%p) not found", handle);
		return -EINVAL;
	}

	err = mModule->unlock(mModule, handle);

	ALOGW_IF(err, "unlock(%p) failed: %d (%s)", handle, -err, strerror(-err));
	return err;
}

}; // namespace android
