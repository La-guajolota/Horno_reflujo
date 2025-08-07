#include <sensors/digital_filter.h>

/************************
 * Moving average filter
 ************************/
/**
 * @brief Initialize moving average filter
 *
 * @param filter Pointer to filter structure
 * @param buffer Pre-allocated buffer storage
 * @param size Window size (must be > 0)
 */
void moving_average_init(MovingAverage *filter, float *buffer, uint8_t size) {
    filter->buffer = buffer;
    filter->size = size;
    filter->index = 0;
    filter->sum = 0.0f;
    filter->count = 0;

    // Clear buffer
    for(uint16_t i = 0; i < size; i++) {
        filter->buffer[i] = 0.0f;
    }
}

/**
 * @brief Add new sample and get filtered output
 *
 * @param filter Pointer to filter structure
 * @param input New sample value
 * @return float Filtered output (average)
 */
float moving_average_update(MovingAverage *filter, float input) {
    // Subtract oldest sample from sum
    if(filter->count >= filter->size) {
        filter->sum -= filter->buffer[filter->index];
    }

    // Add new sample to buffer
    filter->buffer[filter->index] = input;
    filter->sum += input;

    // Update index (circular buffer)
    filter->index = (filter->index + 1) % filter->size;

    // Update sample count
    if(filter->count < filter->size) {
        filter->count++;
    }

    // Calculate average
    return filter->sum / filter->count;
}

/************
 * EMA filter
 ************/
/**
 * @brief Initialize an EMA filter instance. Sets up the filter with a user-defined
 * 		  smoothing factor (alpha). Internally clamps alpha to ensure numerical stability
 * 		  and avoid invalid behavior.
 *
 * @param[in,out] filter Pointer to the EMAFilter instance to initialize.
 * @param[in] alpha      Smoothing factor (0 < alpha <= 1). Closer to 1 gives faster response.
 */
void ema_init(EMAFilter* filter, float alpha) {
    // Clamp alpha to valid and safe range (avoid zero or NaN behavior)
    filter->alpha = (alpha > 1.0f) ? 1.0f : (alpha < 1e-6f) ? 1e-6f : alpha;
    filter->beta = 1.0f - filter->alpha;

    // Reset internal state
    filter->prev_output = 0.0f;
}

/**
 * @brief Process a single input sample through the EMA filter. Applies the exponential
 * 		  smoothing formula to generate a filtered output.
 *
 * @param[in,out] filter Pointer to an initialized EMAFilter instance.
 * @param[in] input      New input sample to be filtered.
 * @return Filtered output value.
 */
float ema_process(EMAFilter* filter, float input) {
    // Apply EMA formula: y[n] = α * x[n] + β * y[n-1]
    float output = filter->alpha * input + filter->beta * filter->prev_output;

    // Update internal state for next sample
    filter->prev_output = output;
    return output;
}
