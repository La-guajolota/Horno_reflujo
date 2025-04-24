/*
 * gui_backend.c
 *
 * Implementation of a multi-page GUI system for reflow oven controller
 * using a state machine approach and rotary encoder interface.
 *
 * Created on: Apr 21, 2025
 * Author: Adrián Silva Palafox
 */

#include "gui_backend.h"

/******************************************************************************
 * PAGE STRUCTURE DEFINITIONS
 *****************************************************************************/
/* UI page structures for the three main screens */
ui_page_t main_page_ui;
ui_page_t oven_settings_page_ui;
ui_page_t pid_settings_page_ui;
ui_page_t ui_pages_arr[3];

/******************************************************************************
 * ELEMENT DEFINITIONS FOR MAIN PAGE
 *****************************************************************************/
ui_element_t ui_main_page_elements_arr[NUM_MAIN_PAGE_BTN] = {
    [START_BTN] = {
        .x          =  0,            /* Horizontal position */
        .y          =  0,            /* Vertical position */
        .width      = 20,            /* Element width */
        .height     =  5,            /* Element height */
        .selectable = true,          /* Can be selected */
        .selected   = false,         /* Initially not selected */
        .editable   = false,         /* Not editable (action button) */
        .value_ptr  = NULL,          /* No associated value */
        .value_min  =  0,            /* Minimum value (N/A) */
        .value_max  =  0,            /* Maximum value (N/A) */
        .value_step =  0.0f,         /* Step value (N/A) */
        .label      = "START",       /* Button label */
        //.draw_func  = draw_button   /* Drawing callback function */
    },
    [STOP_BTN] = {
        .x          = 21,
        .y          =  0,
        .width      = 20,
        .height     =  5,
        .selectable = true,
        .selected   = false,
        .editable   = false,
        .value_ptr  = NULL,
        .value_min  =  0,
        .value_max  =  0,
        .value_step =  0.0f,
        .label      = "STOP",
        //.draw_func  = draw_button
    },
    [OVEN_SETTINGS_BTN] = {
        .x          =  0,
        .y          =  6,
        .width      = 20,
        .height     =  5,
        .selectable = true,
        .selected   = false,
        .editable   = false,
        .value_ptr  = NULL,
        .value_min  =  0,
        .value_max  =  0,
        .value_step =  0.0f,
        .label      = "OVEN SETTINGS",
        //.draw_func  = draw_button
    },
    [PID_SETTINGS_BTN] = {
        .x          = 21,
        .y          =  6,
        .width      = 20,
        .height     =  5,
        .selectable = true,
        .selected   = false,
        .editable   = false,
        .value_ptr  = NULL,
        .value_min  =  0,
        .value_max  =  0,
        .value_step =  0.0f,
        .label      = "PID SETTINGS",
        //.draw_func  = draw_button
    }
};

/******************************************************************************
 * ELEMENT DEFINITIONS FOR OVEN SETTINGS PAGE
 *****************************************************************************/
ui_element_t ui_oven_settings_page_elements_arr[NUM_OVEN_BOXES] = {
    [PREHEAT_RISE_TIME_BOX] = {
        .x          =  0,            /* Horizontal position */
        .y          =  0,            /* Vertical position */
        .width      = 20,            /* Element width */
        .height     =  5,            /* Element height */
        .selectable = true,          /* Can be selected/focused */
        .selected   = false,         /* Initially not selected */
        .editable   = true,          /* Value can be modified */
        //.value_ptr  = &preheat_rise_value,  /* Pointer to actual data */
        .value_min  =  0,            /* Minimum 0°C/s */
        .value_max  = 10,            /* Maximum 10°C/s */
        .value_step =  0.5f,         /* Increment by 0.5 */
        .label      = "PREHEAT RISE", /* Display text */
        //.draw_func  = draw_value_box /* Drawing callback function */
    },
    [SOAK_TIME_BOX] = {
        .x          =  0,
        .y          =  6,
        .width      = 20,
        .height     =  5,
        .selectable = true,
        .editable   = true,
        //.value_ptr  = &soak_time_value,
        .value_min  =  0,            /* 0 seconds */
        .value_max  = 120,           /* 120 seconds (2 minutes) */
        .value_step =  1.0f,         /* 1 second steps */
        .label      = "SOAK TIME",
        //.draw_func  = draw_value_box
    },
    [SOAK_TEMP_BOX] = {
        .x          = 21,
        .y          =  0,
        .width      = 20,
        .height     =  5,
        .selectable = true,
        .editable   = true,
        //.value_ptr  = &soak_temp_value,
        .value_min  = 20,            /* 20°C */
        .value_max  = 200,           /* 200°C */
        .value_step =  1.0f,         /* 1°C steps */
        .label      = "SOAK TEMP",
        //.draw_func  = draw_value_box
    },
    [REFLOW_RISE_TIME_BOX] = {
        .x          = 21,
        .y          =  6,
        .width      = 20,
        .height     =  5,
        .selectable = true,
        .editable   = true,
        //.value_ptr  = &reflow_rise_value,
        .value_min  =  0,            /* 0°C/s */
        .value_max  = 10,            /* 10°C/s */
        .value_step =  0.5f,         /* 0.5°C/s steps */
        .label      = "REFLOW RISE",
        //.draw_func  = draw_value_box
    },
    [REFLOW_TEMP_BOX] = {
        .x          =  0,
        .y          = 12,
        .width      = 20,
        .height     =  5,
        .selectable = true,
        .editable   = true,
        //.value_ptr  = &reflow_temp_value,
        .value_min  = 50,            /* 50°C */
        .value_max  = 260,           /* 260°C - peak reflow temperature */
        .value_step =  1.0f,         /* 1°C steps */
        .label      = "REFLOW TEMP",
        //.draw_func  = draw_value_box
    },
    [COOL_TIME_BOX] = {
        .x          = 21,
        .y          = 12,
        .width      = 20,
        .height     =  5,
        .selectable = true,
        .editable   = true,
        //.value_ptr  = &cool_time_value,
        .value_min  =  0,            /* 0 seconds */
        .value_max  = 120,           /* 120 seconds (2 minutes) */
        .value_step =  1.0f,         /* 1 second steps */
        .label      = "COOL TIME",
        //.draw_func  = draw_value_box
    },
    [COOL_TEMP_BOX] = {
        .x          =  0,
        .y          = 18,
        .width      = 20,
        .height     =  5,
        .selectable = true,
        .editable   = true,
        //.value_ptr  = &cool_temp_value,
        .value_min  = 20,            /* 20°C */
        .value_max  = 150,           /* 150°C */
        .value_step =  1.0f,         /* 1°C steps */
        .label      = "COOL TEMP",
        //.draw_func  = draw_value_box
    },
    [OVEN_RETURN_BTN] = {
        .x          = 21,
        .y          = 18,
        .width      = 20,
        .height     =  5,
        .selectable = true,
        .editable   = false,         /* Not editable (navigation button) */
        .label      = "RETURN TO MAIN",
        //.draw_func  = draw_button
    }
};

/******************************************************************************
 * ELEMENT DEFINITIONS FOR PID SETTINGS PAGE
 *****************************************************************************/
ui_element_t ui_pid_settings_page_elements_arr[NUM_PID_BOXES] = {
    [PID_KP_BOX] = {
        .x          =  0,
        .y          =  1,
        .width      =  2,
        .height     =  3,
        .selectable = true,
        .selected   = false,
        .editable   = true,
        .value_ptr  = &PID.Kp,       /* Pointer to Proportional gain */
        .value_min  =   0,           /* Minimum value */
        .value_max  = 100,           /* Maximum value */
        .value_step = 0.5f,          /* Adjustment steps */
        .label      = "KP",          /* Proportional gain label */
        //.draw_func  = draw_value_box,
    },
    [PID_KI_BOX] = {
        .x          =  4,
        .y          =  5,
        .width      =  6,
        .height     =  7,
        .selectable = true,
        .selected   = false,
        .editable   = true,
        .value_ptr  = &PID.Ki,       /* Pointer to Integral gain */
        .value_min  =   0,
        .value_max  =  30,
        .value_step = 0.5f,
        .label      = "KI",          /* Integral gain label */
        //.draw_func  = draw_value_box,
    },
    [PID_KD_BOX] = {
        .x          =  8,
        .y          =  9,
        .width      = 10,
        .height     = 11,
        .selectable = true,
        .selected   = false,
        .editable   = true,
        .value_ptr  = &PID.Kd,       /* Pointer to Derivative gain */
        .value_min  =   0,
        .value_max  =  30,
        .value_step = 0.5f,
        .label      = "KD",          /* Derivative gain label */
        //.draw_func  = draw_value_box,
    },
    [PID_RETURN_BTN] = {
        .x          = 12,
        .y          = 13,
        .width      = 14,
        .height     = 15,
        .selectable = true,
        .selected   = false,
        .editable   = true,
        //.value_ptr  = &PID.Kd,      /* Not needed for button */
        .value_min  =   0,
        .value_max  =  30,
        .value_step = 0.5f,
        .label      = "RETURN TO MAIN",
        //.draw_func  = draw_value_box,
    },
};

/******************************************************************************
 * STATE MACHINE & GLOBAL VARIABLES
 *****************************************************************************/
state_machine_t gui_sm;         /* GUI state machine instance */
uint8_t rotateMode = 1;         /* 1=navigate elements, 0=edit values */
float* param;                   /* Pointer to the currently selected parameter being edited */
float param_max_val;            /* Maximum allowable value for the current parameter */
float param_min_val;            /* Minimum allowable value for the current parameter */
float step_val;                 /* Incremental step size for parameter value changes */

/******************************************************************************
 * HELPER FUNCTIONS
 *****************************************************************************/

/**
 * @brief  Rotate the current index with wrap-around or adjust parameter value
 * @param  sm: Pointer to state machine
 * @param  delta: Amount to change (+1/-1)
 * @param  rotateMode: 1=navigate elements, 0=edit value
 * @retval None
 */
static void rotate_action(state_machine_t *sm, int8_t delta, uint8_t rotateMode) {
    if (rotateMode) {
        /* Navigate between elements */
        uint8_t max = ui_pages_arr[sm->current_page].num_elements;
        sm->current_element_idx = (sm->current_element_idx + delta + max) % max;
    } else {
    	/* Increment or decrement parameter value */
		*param += (delta * step_val);
        /*Value boundary checking should be added here */
        if (*param > param_max_val) *param = param_max_val;
        else if (*param < param_min_val) *param = param_min_val;
    }
}

/**
 * @brief  Update parameter value or toggle edit mode
 * @param  sm: Pointer to state machine
 * @param  ev: Encoder event type
 * @retval None
 */
static void update_value(state_machine_t* sm, encoder_event_t ev) {
    /* Get the pointed variable to manipulate */
    param = (float *)(sm->page_array[sm->current_page].elements[sm->current_element_idx].value_ptr);
	param_max_val= sm->page_array[sm->current_page].elements[sm->current_element_idx].value_max;
	param_min_val = sm->page_array[sm->current_page].elements[sm->current_element_idx].value_min;
	step_val = (sm->page_array[sm->current_page].elements[sm->current_element_idx].value_step);

    if (ev == PULSE_BUTTON_EVENT) {
        rotateMode ^= 1; /* Toggle between navigation and edit modes */
    }
}

/******************************************************************************
 * MAIN PAGE HANDLERS
 *****************************************************************************/

/**
 * @brief  Handle element selection on main page
 * @param  sm: Pointer to state machine
 * @retval None
 */
static void selectElement_mainPage(state_machine_t *sm) {
    sm->previous_page = sm->current_page;
    switch (sm->current_element_idx) {
        case START_BTN:
            sm->is_process_running = true;
            break;
        case STOP_BTN:
            sm->is_process_running = false;
            break;
        case OVEN_SETTINGS_BTN:
            sm->current_page = OVEN_SETTINGS_PAGE;
            sm->current_element_idx = PREHEAT_RISE_TIME_BOX;
            break;
        case PID_SETTINGS_BTN:
            sm->current_page = PID_SETTINGS_PAGE;
            sm->current_element_idx = PID_KP_BOX;
            break;
        default:
            break;
    }
}

/**
 * @brief  Main page event handler
 * @param  sm: Pointer to state machine
 * @param  ev: Encoder event type
 * @retval None
 */
void main_page_handler(state_machine_t *sm, encoder_event_t ev) {
    switch (ev) {
        case IDLE_EVENT:
            break;
        case CLOCK_WISE_EVENT:
            rotate_action(sm, +1, rotateMode);
            break;
        case ANTI_CLCOK_WISE_EVENT:
            rotate_action(sm, -1, rotateMode);
            break;
        case PULSE_BUTTON_EVENT:
            selectElement_mainPage(sm);
            break;
        default:
            /* Unknown event: ignore */
            break;
    }
}

/******************************************************************************
 * OVEN SETTINGS PAGE HANDLERS
 *****************************************************************************/

/**
 * @brief  Handle element selection on oven settings page
 * @param  sm: Pointer to state machine
 * @retval None
 */
static void selectElement_ovenSettingsPage(state_machine_t *sm) {
    sm->previous_page = sm->current_page;
    switch (sm->current_element_idx) {
        case PREHEAT_RISE_TIME_BOX:
            /* Enter edit mode for this parameter */
            break;
        case SOAK_TIME_BOX:
            /* Enter edit mode for this parameter */
            break;
        case SOAK_TEMP_BOX:
            /* Enter edit mode for this parameter */
            break;
        case REFLOW_RISE_TIME_BOX:
            /* Enter edit mode for this parameter */
            break;
        case REFLOW_TEMP_BOX:
            /* Enter edit mode for this parameter */
            break;
        case COOL_TIME_BOX:
            /* Enter edit mode for this parameter */
            break;
        case COOL_TEMP_BOX:
            /* Enter edit mode for this parameter */
            break;
        case OVEN_RETURN_BTN:
            sm->current_page = MAIN_PAGE;
            sm->current_element_idx = START_BTN;
            break;
        default:
            /* No extra action */
            break;
    }
}

/**
 * @brief  Oven settings page event handler
 * @param  sm: Pointer to state machine
 * @param  ev: Encoder event type
 * @retval None
 */
void oven_settings_page_handler(state_machine_t *sm, encoder_event_t ev) {
    switch (ev) {
        case IDLE_EVENT:
            break;
        case CLOCK_WISE_EVENT:
            rotate_action(sm, +1, rotateMode);
            break;
        case ANTI_CLCOK_WISE_EVENT:
            rotate_action(sm, -1, rotateMode);
            break;
        case PULSE_BUTTON_EVENT:
            selectElement_ovenSettingsPage(sm);
            break;
        default:
            /* Unknown event: ignore */
            break;
    }
}

/******************************************************************************
 * PID SETTINGS PAGE HANDLERS
 *****************************************************************************/

/**
 * @brief  Handle element selection or editing on PID settings page
 * @param  sm: Pointer to state machine
 * @param  ev: Encoder event type
 * @retval None
 */
static void selectElement_pidSettingsPage(state_machine_t *sm, encoder_event_t ev) {
    sm->previous_page = sm->current_page;
    switch (sm->current_element_idx) {
        case PID_KP_BOX:
            update_value(sm, ev);  /* Update Kp or toggle edit mode */
            break;
        case PID_KI_BOX:
            update_value(sm, ev);  /* Update Ki or toggle edit mode */
            break;
        case PID_KD_BOX:
            update_value(sm, ev);  /* Update Kd or toggle edit mode */
            break;
        case PID_RETURN_BTN:
            sm->current_page = MAIN_PAGE;
            sm->current_element_idx = START_BTN;
            break;
        default:
            /* No extra action */
            break;
    }
}

/**
 * @brief  PID settings page event handler
 * @param  sm: Pointer to state machine
 * @param  ev: Encoder event type
 * @retval None
 */
void pid_settings_page_handler(state_machine_t *sm, encoder_event_t ev) {
    switch (ev) {
        case IDLE_EVENT:
            break;
        case CLOCK_WISE_EVENT:
            rotate_action(sm, +1, rotateMode);  /* Navigate or edit based on mode */
            break;
        case ANTI_CLCOK_WISE_EVENT:
            rotate_action(sm, -1, rotateMode);  /* Navigate or edit based on mode */
            break;
        case PULSE_BUTTON_EVENT:
            selectElement_pidSettingsPage(sm, ev);
            break;
        default:
            /* Unknown event: ignore */
            break;
    }
}

/******************************************************************************
 * ENCODER INTERFACE FUNCTIONS
 *****************************************************************************/

/**
 * @brief  Update encoder state and determine event type
 * @param  encoder: Pointer to encoder structure
 * @retval None
 */
void ENCODER_EVENT_UPDATE(encoder_t* encoder) {
    /* Get current counter value and direction from Timer */
    encoder->current_cnt = __HAL_TIM_GET_COUNTER(&htim2);
    encoder->current_dir = READ_BIT(TIM2->CR1, TIM_CR1_DIR) ? 1 : 0;

    /* Determine event type based on encoder state */
    if (encoder->isr_reg & 1) {
        /* Button press detected in ISR */
        encoder->isr_reg &= ~1;  /* Clear flag */
        encoder->ev = PULSE_BUTTON_EVENT;
    } else if (encoder->current_dir == encoder->prev_dir &&
               encoder->current_cnt == encoder->prev_cnt) {
        /* No change detected */
        encoder->ev = IDLE_EVENT;
    } else if (encoder->current_dir) {
        /* Clockwise rotation detected */
        encoder->ev = CLOCK_WISE_EVENT;
    } else {
        /* Anti-clockwise rotation detected */
        encoder->ev = ANTI_CLCOK_WISE_EVENT;
    }

    /* Save current state for next comparison */
    encoder->prev_cnt = encoder->current_cnt;
    encoder->prev_dir = encoder->current_dir;
}

/******************************************************************************
 * INITIALIZATION FUNCTION
 *****************************************************************************/

/**
 * @brief  Initialize GUI system including pages and state machine
 * @param  None
 * @retval None
 */
void GUI_Init(void) {
    /************
     * MAIN PAGE
     ************/
    /* Main page configuration */
    main_page_ui.id = MAIN_PAGE;
    main_page_ui.num_elements = NUM_MAIN_PAGE_BTN;
    main_page_ui.elements = ui_main_page_elements_arr;
    main_page_ui.current_element = START_BTN;

    /******************
     * OVEN SETTINGS
     ******************/
    /* Oven settings page configuration */
    oven_settings_page_ui.id = OVEN_SETTINGS_PAGE;
    oven_settings_page_ui.num_elements = NUM_OVEN_BOXES;
    oven_settings_page_ui.elements = ui_oven_settings_page_elements_arr;
    oven_settings_page_ui.current_element = PREHEAT_RISE_TIME_BOX;

    /****************
     * PID SETTINGS
     ****************/
    /* PID settings page configuration */
    pid_settings_page_ui.id = PID_SETTINGS_PAGE;
    pid_settings_page_ui.num_elements = NUM_PID_BOXES;
    pid_settings_page_ui.elements = ui_pid_settings_page_elements_arr;
    pid_settings_page_ui.current_element = PID_KP_BOX;

    /* Build page array for state machine */
    ui_pages_arr[MAIN_PAGE] = main_page_ui;
    ui_pages_arr[OVEN_SETTINGS_PAGE] = oven_settings_page_ui;
    ui_pages_arr[PID_SETTINGS_PAGE] = pid_settings_page_ui;

    /* Initialize state machine */
    gui_sm.current_page = MAIN_PAGE;
    gui_sm.previous_page = MAIN_PAGE;
    gui_sm.page_array = ui_pages_arr;
    gui_sm.current_element_idx = START_BTN;
    gui_sm.needs_redraw = true;
    gui_sm.is_editing = false;
    gui_sm.is_process_running = false;
}
