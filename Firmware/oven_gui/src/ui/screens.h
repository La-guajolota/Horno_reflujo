#ifndef EEZ_LVGL_UI_SCREENS_H
#define EEZ_LVGL_UI_SCREENS_H

#include <lvgl/lvgl.h>

#ifdef __cplusplus
extern "C" {
#endif

typedef struct _objects_t {
    lv_obj_t *main;
    lv_obj_t *oven_settings;
    lv_obj_t *pid_settings;
    lv_obj_t *temp_profile;
    lv_obj_t *main_page_btn;
    lv_obj_t *obj0;
    lv_obj_t *main_page_btn_1;
    lv_obj_t *obj1;
    lv_obj_t *main_page_btn_2;
    lv_obj_t *obj2;
    lv_obj_t *main_page_btn_3;
    lv_obj_t *obj3;
    lv_obj_t *obj4;
    lv_obj_t *obj5;
} objects_t;

extern objects_t objects;

enum ScreensEnum {
    SCREEN_ID_MAIN = 1,
    SCREEN_ID_OVEN_SETTINGS = 2,
    SCREEN_ID_PID_SETTINGS = 3,
};

void create_screen_main();
void tick_screen_main();

void create_screen_oven_settings();
void tick_screen_oven_settings();

void create_screen_pid_settings();
void tick_screen_pid_settings();

void tick_screen_by_id(enum ScreensEnum screenId);
void tick_screen(int screen_index);

void create_screens();


#ifdef __cplusplus
}
#endif

#endif /*EEZ_LVGL_UI_SCREENS_H*/