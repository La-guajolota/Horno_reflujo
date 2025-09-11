/**
 * @file      digital_filter.h
 * @author    Adrian Silva Palafox
 * @github    https://github.com/La-guajolota
 * @brief     Ready made digital filters
 * @version   0.1
 * @date      Agust 2025
 *
 * @details   This library provides multiple types of digital filters such as:
 * 			  1.- Moving average
 * 			  2.- Exponential moving average
 *
 * @note 	  This is implemented for foat data type, so CPUs having FPU will be
 * 			  more efficient naturally
 */

#ifndef INC_SENSORS_DIGITAL_FILTER_H_
#define INC_SENSORS_DIGITAL_FILTER_H_

#include <math.h>
#include <stdint.h>

// Moving Average Filter Structure
typedef struct {
    float *buffer;     // Circular buffer for samples
    uint8_t size;      // Window size (number of samples)
    uint8_t index;     // Current write position
    float sum;         // Running sum of samples
    uint8_t count;     // Current number of samples in buffer
} MovingAverage;

void moving_average_init(MovingAverage *filter, float *buffer, uint8_t size);
float moving_average_update(MovingAverage *filter, float input);

// Exponential Average Filter Structure
typedef struct {
    float alpha;        // Smoothing factor (0 < alpha < 1)
    float beta;         // 1 - alpha (precomputed for efficiency)
    float prev_output;  // Previous filter output
} EMAFilter;

void ema_init(EMAFilter* filter, float alpha);
float ema_process(EMAFilter* filter, float input);

#endif /* INC_SENSORS_DIGITAL_FILTER_H_ */
