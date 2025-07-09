#ifdef __has_include
    #if __has_include("lvgl.h")
        #ifndef LV_LVGL_H_INCLUDE_SIMPLE
            #define LV_LVGL_H_INCLUDE_SIMPLE
        #endif
    #endif
#endif

#if defined(LV_LVGL_H_INCLUDE_SIMPLE)
#include "lvgl.h"
#elif defined(LV_BUILD_TEST)
#include "../lvgl.h"
#else
#include "lvgl/lvgl.h"
#endif


#ifndef LV_ATTRIBUTE_MEM_ALIGN
#define LV_ATTRIBUTE_MEM_ALIGN
#endif

#ifndef LV_ATTRIBUTE_IMG_CUBE_TEST
#define LV_ATTRIBUTE_IMG_CUBE_TEST
#endif

static const
LV_ATTRIBUTE_MEM_ALIGN LV_ATTRIBUTE_LARGE_CONST LV_ATTRIBUTE_IMG_CUBE_TEST
uint8_t img_cube_test_map[] = {

    0x4c,0x70,0x47,0x00,0xff,0xff,0xff,0xff,

    0x00,0x00,
    0x7f,0xf8,
    0x80,0x04,
    0x80,0x04,
    0x80,0x04,
    0x80,0x04,
    0x80,0x04,
    0x80,0x04,
    0x80,0x04,
    0x80,0x04,
    0x80,0x04,
    0x80,0x04,
    0x80,0x04,
    0x80,0x04,
    0x80,0x04,
    0x7f,0xf8,

};

const lv_image_dsc_t img_cube_test = {
  .header.magic = LV_IMAGE_HEADER_MAGIC,
  .header.cf = LV_COLOR_FORMAT_I1,
  .header.flags = 0,
  .header.w = 14,
  .header.h = 16,
  .header.stride = 2,
  .data_size = sizeof(img_cube_test_map),
  .data = img_cube_test_map,
};

