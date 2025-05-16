################################################################################
# Automatically-generated file. Do not edit!
# Toolchain: GNU Tools for STM32 (13.3.rel1)
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../Drivers/lvgl/src/stdlib/clib/lv_mem_core_clib.c \
../Drivers/lvgl/src/stdlib/clib/lv_sprintf_clib.c \
../Drivers/lvgl/src/stdlib/clib/lv_string_clib.c 

OBJS += \
./Drivers/lvgl/src/stdlib/clib/lv_mem_core_clib.o \
./Drivers/lvgl/src/stdlib/clib/lv_sprintf_clib.o \
./Drivers/lvgl/src/stdlib/clib/lv_string_clib.o 

C_DEPS += \
./Drivers/lvgl/src/stdlib/clib/lv_mem_core_clib.d \
./Drivers/lvgl/src/stdlib/clib/lv_sprintf_clib.d \
./Drivers/lvgl/src/stdlib/clib/lv_string_clib.d 


# Each subdirectory must supply rules for building sources it contributes
Drivers/lvgl/src/stdlib/clib/%.o Drivers/lvgl/src/stdlib/clib/%.su Drivers/lvgl/src/stdlib/clib/%.cyclo: ../Drivers/lvgl/src/stdlib/clib/%.c Drivers/lvgl/src/stdlib/clib/subdir.mk
	arm-none-eabi-gcc "$<" -mcpu=cortex-m4 -std=gnu11 -g3 -DDEBUG -DUSE_HAL_DRIVER -DSTM32F411xE -c -I../Core/Inc -I"/media/adrian/usb_a/Chambas/Inbiodroid/Horno_d_reflujo/Firmware/stm32f411/reflow_oven/Drivers/lvgl" -I../Drivers/STM32F4xx_HAL_Driver/Inc -I../Drivers/STM32F4xx_HAL_Driver/Inc/Legacy -I../Drivers/CMSIS/Device/ST/STM32F4xx/Include -I../Drivers/CMSIS/Include -I"/media/adrian/usb_a/Chambas/Inbiodroid/Horno_d_reflujo/Firmware/stm32f411/reflow_oven/Drivers/ui" -O0 -ffunction-sections -fdata-sections -Wall -fstack-usage -fcyclomatic-complexity -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" --specs=nano.specs -mfpu=fpv4-sp-d16 -mfloat-abi=hard -mthumb -o "$@"

clean: clean-Drivers-2f-lvgl-2f-src-2f-stdlib-2f-clib

clean-Drivers-2f-lvgl-2f-src-2f-stdlib-2f-clib:
	-$(RM) ./Drivers/lvgl/src/stdlib/clib/lv_mem_core_clib.cyclo ./Drivers/lvgl/src/stdlib/clib/lv_mem_core_clib.d ./Drivers/lvgl/src/stdlib/clib/lv_mem_core_clib.o ./Drivers/lvgl/src/stdlib/clib/lv_mem_core_clib.su ./Drivers/lvgl/src/stdlib/clib/lv_sprintf_clib.cyclo ./Drivers/lvgl/src/stdlib/clib/lv_sprintf_clib.d ./Drivers/lvgl/src/stdlib/clib/lv_sprintf_clib.o ./Drivers/lvgl/src/stdlib/clib/lv_sprintf_clib.su ./Drivers/lvgl/src/stdlib/clib/lv_string_clib.cyclo ./Drivers/lvgl/src/stdlib/clib/lv_string_clib.d ./Drivers/lvgl/src/stdlib/clib/lv_string_clib.o ./Drivers/lvgl/src/stdlib/clib/lv_string_clib.su

.PHONY: clean-Drivers-2f-lvgl-2f-src-2f-stdlib-2f-clib

