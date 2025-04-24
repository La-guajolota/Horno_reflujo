/*
 * gui_backend.h
 *
 * Header file for multi-page GUI system for reflow oven controller
 * Defines UI structures, enumerations, and interface functions
 *
 * Created on: Apr 21, 2025
 * Author: Adrián Silva Palafox
 * Documentation: Apr 22, 2025
 */

#ifndef INC_GUI_BACKEND_H_
#define INC_GUI_BACKEND_H_

/******************************************************************************
 * INCLUDES
 *****************************************************************************/
#include "stm32f4xx.h"
#include <stdint.h>
#include <stdbool.h>
#include "pid.h"

/******************************************************************************
 * EXTERNAL REFERENCES
 *****************************************************************************/
/* PID's data type instance */
extern PIDController PID;
/* Microcontroller's hardware related to rotary encoder for user's interaction with GUI */
extern TIM_HandleTypeDef htim2;

/******************************************************************************
 * USER INPUT DEFINITIONS
 *****************************************************************************/
/**
 * @brief  Encoder event types
 */
typedef enum {
    IDLE_EVENT,              /* No event detected */
    CLOCK_WISE_EVENT,        /* Encoder rotated clockwise */
    ANTI_CLCOK_WISE_EVENT,   /* Encoder rotated counter-clockwise */
    PULSE_BUTTON_EVENT,      /* Encoder button pressed briefly */
    LONG_PRESS_EVENT,        /* Encoder button held down */
    TIMEOUT_EVENT,           /* Timeout elapsed with no activity */
    NUM_EVENTS               /* Total number of event types */
} encoder_event_t;

/**
 * @brief  Encoder structure tracking physical encoder state
 */
typedef struct {
    encoder_event_t ev;      /* Current event type */
    uint8_t isr_reg;         /* Bit 0 is pulse_flag */
    uint8_t prev_cnt;        /* Previous counter value */
    uint8_t current_cnt;     /* Current counter value */
    uint8_t prev_dir;        /* Previous direction */
    uint8_t current_dir;     /* Current direction */
} encoder_t;

/******************************************************************************
 * UI PAGE DEFINITIONS
 *****************************************************************************/
/**
 * @brief  UI page identifiers
 */
typedef enum {
    MAIN_PAGE,               /* Display graph and running parameters */
    OVEN_SETTINGS_PAGE,      /* Configure reflow oven parameters */
    PID_SETTINGS_PAGE,       /* Configure PID controller parameters */
    NUM_STATES               /* Total number of UI pages */
} ui_pages_t;

/**
 * @brief  Main page elements
 */
typedef enum {
    START_BTN,               /* Starts reflow process */
    STOP_BTN,                /* Stops reflow process */
    OVEN_SETTINGS_BTN,       /* Navigate to oven settings page */
    PID_SETTINGS_BTN,        /* Navigate to PID settings page */
    NUM_MAIN_PAGE_BTN        /* Total number of main page elements */
} ui_main_page_boxes_t;

/**
 * @brief  Oven settings page elements
 */
typedef enum {
    PREHEAT_RISE_TIME_BOX,   /* Preheat rise time (°C/s) */
    SOAK_TIME_BOX,           /* Soak duration (seconds) */
    SOAK_TEMP_BOX,           /* Soak temperature (°C) */
    REFLOW_RISE_TIME_BOX,    /* Reflow rise time (°C/s) */
    REFLOW_TEMP_BOX,         /* Reflow temperature (°C) */
    COOL_TIME_BOX,           /* Cooling duration (seconds) */
    COOL_TEMP_BOX,           /* Cooling temperature (°C) */
    OVEN_RETURN_BTN,         /* Return to main page */
    NUM_OVEN_BOXES           /* Total number of oven settings elements */
} ui_oven_settings_page_boxes_t;

/**
 * @brief  PID settings page elements
 */
typedef enum {
    PID_KP_BOX,              /* Proportional gain */
    PID_KI_BOX,              /* Integral gain */
    PID_KD_BOX,              /* Derivative gain */
    PID_RETURN_BTN,          /* Return to main page */
    NUM_PID_BOXES            /* Total number of PID settings elements */
} ui_pid_settings_page_boxes_t;

/******************************************************************************
 * UI ELEMENT STRUCTURES
 *****************************************************************************/
/**
 * @brief  UI element structure (represents boxes, buttons, etc.)
 */
typedef struct {
    uint16_t x, y;           /* Position coordinates */
    uint16_t width, height;  /* Element dimensions */
    bool selectable;         /* If this element can be selected/focused */
    bool selected;           /* If this element is currently selected */
    bool editable;           /* If this element's value can be edited */
    void* value_ptr;         /* Pointer to the actual data value */
    uint16_t value_min;      /* Minimum value allowed */
    uint16_t value_max;      /* Maximum value allowed */
    float value_step;        /* Increment/decrement step size */
    char label[20];          /* Text label for this element */
    void (*draw_func)(void*); /* Function to draw this element */
} ui_element_t;

/**
 * @brief  UI page structure
 */
typedef struct {
    ui_pages_t id;           /* Page identifier */
    uint8_t num_elements;    /* Number of elements in this page */
    ui_element_t* elements;  /* Array of elements */
    uint8_t current_element; /* Index of the currently selected element */
    void (*draw_func)(void); /* Function to draw this page */
} ui_page_t;

/**
 * @brief  State machine structure for UI navigation
 */
typedef struct {
    ui_pages_t current_page;     /* Currently displayed page */
    ui_pages_t previous_page;    /* Previous page (for back navigation) */
    ui_page_t* page_array;       /* Array of all pages */
    uint8_t current_element_idx; /* Index of currently selected element */
    /* uint32_t last_event_time;    Time of the last user event */
    /* uint32_t timeout_ms;         Timeout for returning to main screen */
    bool needs_redraw;           /* Flag indicating if redraw is needed */
    bool is_editing;             /* Flag indicating if in edit mode */
    bool is_process_running;     /* Flag indicating if reflow process is running */
} state_machine_t;

/******************************************************************************
 * EXTERNAL VARIABLES
 *****************************************************************************/
extern encoder_t encoder;
extern state_machine_t gui_sm;

/******************************************************************************
 * FUNCTION TYPES AND STATE HANDLERS
 *****************************************************************************/
/**
 * @brief  Function pointer type for page event handlers
 */
typedef void (*state_handler_t)(state_machine_t*, encoder_event_t);

/**
 * @brief  Event handlers for each page
 */
void main_page_handler(state_machine_t *sm, encoder_event_t ev);
void oven_settings_page_handler(state_machine_t *sm, encoder_event_t ev);
void pid_settings_page_handler(state_machine_t *sm, encoder_event_t ev);

/******************************************************************************
 * EXTERNAL FUNCTION DECLARATIONS
 *****************************************************************************/
/* External function declarations for LCD interface */
/* extern void LCD_Clear(void);                       Clear the LCD */
/* extern void LCD_DrawElement(ui_element_t*);        Draw an element on the LCD */
/* extern void LCD_DrawPage(ui_page_t*);              Draw a complete page */


/******************************************************************************
 * PUBLIC FUNCTION DECLARATIONS
 *****************************************************************************/
/**
 * @brief  Update encoder state and determine event type
 * @param  encoder: Pointer to encoder structure
 * @retval None
 */
void ENCODER_EVENT_UPDATE(encoder_t* encoder);

/**
 * @brief  Initialize GUI system including pages and state machine
 * @param  None
 * @retval None
 */
void GUI_Init(void);

/**
 * @brief  Process GUI events and update state machine
 * @param  None
 * @retval None
 */
void GUI_Process(void);

/**
 * @brief  Set value for a specific UI element
 * @param  page: Page identifier
 * @param  element_idx: Element index within page
 * @param  value: New value to set
 * @retval None
 */
void GUI_SetValue(ui_pages_t page, uint8_t element_idx, float value);

/**
 * @brief  Get value from a specific UI element
 * @param  page: Page identifier
 * @param  element_idx: Element index within page
 * @retval Current element value as float
 */
float GUI_GetValue(ui_pages_t page, uint8_t element_idx);

/**
 * @brief  Force redraw of a specific page
 * @param  page: Page identifier to redraw
 * @retval None
 */
void GUI_DrawPage(ui_pages_t page);

#endif /* INC_GUI_BACKEND_H_ */
