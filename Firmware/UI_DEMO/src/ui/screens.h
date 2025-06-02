#ifndef EEZ_LVGL_UI_SCREENS_H
#define EEZ_LVGL_UI_SCREENS_H

#include <lvgl.h>

#ifdef __cplusplus
extern "C" {
#endif

typedef struct _objects_t {
    lv_obj_t *main;
    lv_obj_t *reflow;
    lv_obj_t *pid;
    lv_obj_t *obj0;
    lv_obj_t *obj1;
} objects_t;

extern objects_t objects;

enum ScreensEnum {
    SCREEN_ID_MAIN = 1,
    SCREEN_ID_REFLOW = 2,
    SCREEN_ID_PID = 3,
};

void create_screen_main();
void tick_screen_main();

void create_screen_reflow();
void tick_screen_reflow();

void create_screen_pid();
void tick_screen_pid();

void tick_screen_by_id(enum ScreensEnum screenId);
void tick_screen(int screen_index);

void create_screens();


#ifdef __cplusplus
}
#endif

#endif /*EEZ_LVGL_UI_SCREENS_H*/