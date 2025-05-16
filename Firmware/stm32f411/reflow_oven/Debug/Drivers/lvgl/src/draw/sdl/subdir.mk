################################################################################
# Automatically-generated file. Do not edit!
# Toolchain: GNU Tools for STM32 (13.3.rel1)
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../Drivers/lvgl/src/draw/sdl/lv_draw_sdl.c 

OBJS += \
./Drivers/lvgl/src/draw/sdl/lv_draw_sdl.o 

C_DEPS += \
./Drivers/lvgl/src/draw/sdl/lv_draw_sdl.d 


# Each subdirectory must supply rules for building sources it contributes
Drivers/lvgl/src/draw/sdl/%.o Drivers/lvgl/src/draw/sdl/%.su Drivers/lvgl/src/draw/sdl/%.cyclo: ../Drivers/lvgl/src/draw/sdl/%.c Drivers/lvgl/src/draw/sdl/subdir.mk
	arm-none-eabi-gcc "$<" -mcpu=cortex-m4 -std=gnu11 -g3 -DDEBUG -DUSE_HAL_DRIVER -DSTM32F411xE -c -I../Core/Inc -I"/media/adrian/usb_a/Chambas/Inbiodroid/Horno_d_reflujo/Firmware/stm32f411/reflow_oven/Drivers/lvgl" -I../Drivers/STM32F4xx_HAL_Driver/Inc -I../Drivers/STM32F4xx_HAL_Driver/Inc/Legacy -I../Drivers/CMSIS/Device/ST/STM32F4xx/Include -I../Drivers/CMSIS/Include -I"/media/adrian/usb_a/Chambas/Inbiodroid/Horno_d_reflujo/Firmware/stm32f411/reflow_oven/Drivers/ui" -O0 -ffunction-sections -fdata-sections -Wall -fstack-usage -fcyclomatic-complexity -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" --specs=nano.specs -mfpu=fpv4-sp-d16 -mfloat-abi=hard -mthumb -o "$@"

clean: clean-Drivers-2f-lvgl-2f-src-2f-draw-2f-sdl

clean-Drivers-2f-lvgl-2f-src-2f-draw-2f-sdl:
	-$(RM) ./Drivers/lvgl/src/draw/sdl/lv_draw_sdl.cyclo ./Drivers/lvgl/src/draw/sdl/lv_draw_sdl.d ./Drivers/lvgl/src/draw/sdl/lv_draw_sdl.o ./Drivers/lvgl/src/draw/sdl/lv_draw_sdl.su

.PHONY: clean-Drivers-2f-lvgl-2f-src-2f-draw-2f-sdl

