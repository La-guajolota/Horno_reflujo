/*
 * reflow_oven_process.h
 *
 * Created on: Apr 22, 2025
 * Author: adrian
 *
 * Description: Header file for reflow oven controller, providing definitions
 *              for state machine, parameters, and function prototypes.
 */

#ifndef INC_REFLOW_OVEN_PROCESS_H_
#define INC_REFLOW_OVEN_PROCESS_H_

/******************************************************************************
 * INCLUDES
 ******************************************************************************/
#include <stdint.h>
#include <stdbool.h>
#include "pid.h"

/******************************************************************************
 * EXTERNAL REFERENCES
 ******************************************************************************/
/* PID's data type instance */
extern PIDController PID;

/**
 * @brief Enum defining the various phases of the reflow process
 */
typedef enum {
    REFLOW_PREHEAT,  /* Preheat phase: Initial phase where the oven starts heating up to reach the soak temperature */
    REFLOW_SOAK,     /* Soak phase: Maintain a steady temperature to ensure uniform heating */
    REFLOW_HEATUP,   /* Second heat up phase: Rapidly increase temperature to reach reflow point */
    REFLOW_REFLOW,   /* Reflow phase: Peak temperature to melt solder and form joints */
    REFLOW_COOLDOWN, /* Cool down phase: Gradual cooling to solidify solder joints */
    REFLOW_IDLE,     /* Idle phase: Oven is not actively running a process */
} ReflowPhases_t;

/**
 * @brief Enum for parameter identifiers used in parameter modification function
 */
typedef enum {
    PARAM_Pre_HeatUpRate,    /* Preheat rise time (°C/s) */
    PARAM_SoakTempeture,     /* Soak temperature (°C) */
    PARAM_SoakTime,          /* Soak duration (seconds) */
    PARAM_HeatUpRate,        /* Second heat up rate (°C/s) */
    PARAM_ReflowTempeture,   /* Reflow temperature (°C) */
    PARAM_ReflowTime,        /* Reflow duration (seconds) */
    PARAM_CoolDownRate,      /* Cool down rate (°C/s) */
    PARAM_CoolDownTempeture, /* Cool down temperature (°C) */
} ReflowParameters_enum;

/**
 * @brief Structure containing all temperature and timing parameters for the reflow process
 */
typedef struct {
    float Pre_HeatUpRate;    /* Preheat rise time (°C/s) */
    float SoakTempeture;     /* Soak temperature (°C) */
    float SoakTime;          /* Soak duration (seconds) */
    float HeatUpRate;        /* Second heat up rate (°C/s) */
    float ReflowTempeture;   /* Reflow temperature (°C) */
    float ReflowTime;        /* Reflow duration (seconds) */
    float CoolDownRate;      /* Cool down rate (°C/s) */
    float CoolDownTempeture; /* Cool down temperature (°C) */
} ReflowOven_parameters_t;

/**
 * @brief Main reflow oven control structure containing parameters and state information
 */
typedef struct {
    ReflowOven_parameters_t ReflowParameters;
    ReflowPhases_t currentPhase;
    ReflowPhases_t NextPhase;
    uint32_t phaseStartTime;          /* Time when current phase started (ms) */
    float currentSetpoint;            /* Current temperature setpoint for PID */
    bool emergencyStop;               /* Emergency stop flag */
    float temperatureAtPhaseStart;    /* Temperature recorded at phase start */
} ReflowOven_t;

/******************************************************************************
 * EXTERNAL VARIABLES
 ******************************************************************************/
extern ReflowOven_t ReflowOven; // Reflow oven instance

/*************************
 *  Function Prototypes
 *************************/

/**
 * @brief Initialize reflow oven controller with default parameters
 *
 * Sets up initial temperature profiles, rates, and durations
 * for the various phases of the reflow process.
 */
void ReflowOven_Init(void);

/**
 * @brief Update a specific reflow parameter with a new value
 *
 * @param parameterUpdate Parameter identifier (from ReflowParameters_enum)
 * @param newParameterValue New value to set
 *
 * @return bool - True if parameter was updated successfully, false otherwise
 */
bool ReflowOven_modifyParameters(ReflowParameters_enum parameterUpdate, float newParameterValue);

/**
 * @brief Start the reflow process from idle state
 *
 * @return bool - True if process started successfully, false otherwise
 */
bool ReflowOven_startProcess(void);

/**
 * @brief Stop the reflow process and return to idle state
 */
void ReflowOven_stopProcess(void);

/**
 * @brief Execute one control cycle for the reflow oven
 *
 * Processes the current state of the reflow oven, updates PID controller
 * and manages state transitions based on temperature and timing conditions.
 *
 * @param PID Pointer to PID controller instance
 * @param currentTemperature Current measured temperature in degrees Celsius
 * @param currentTimeMs Current system time in milliseconds
 *
 * @return float - The PID controller output value
 */
float ReflowOven_operate(PIDController *PID, float currentTemperature, uint32_t currentTimeMs);

/**
 * @brief Get the current phase of the reflow process
 *
 * @return ReflowPhases_t - Current phase
 */
ReflowPhases_t ReflowOven_getCurrentPhase(void);

/**
 * @brief Calculate time elapsed in current phase
 *
 * @param currentTimeMs Current system time in milliseconds
 * @return uint32_t - Time elapsed in seconds
 */
uint32_t ReflowOven_getPhaseElapsedTime(uint32_t currentTimeMs);

#endif /* INC_REFLOW_OVEN_PROCESS_H_ */
