################################################################################
# Automatically-generated file. Do not edit!
# Toolchain: GNU Tools for STM32 (13.3.rel1)
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../Drivers/lvgl/src/widgets/table/lv_table.c 

OBJS += \
./Drivers/lvgl/src/widgets/table/lv_table.o 

C_DEPS += \
./Drivers/lvgl/src/widgets/table/lv_table.d 


# Each subdirectory must supply rules for building sources it contributes
Drivers/lvgl/src/widgets/table/%.o Drivers/lvgl/src/widgets/table/%.su Drivers/lvgl/src/widgets/table/%.cyclo: ../Drivers/lvgl/src/widgets/table/%.c Drivers/lvgl/src/widgets/table/subdir.mk
	arm-none-eabi-gcc "$<" -mcpu=cortex-m4 -std=gnu11 -g3 -DDEBUG -DUSE_HAL_DRIVER -DSTM32F411xE -c -I../Core/Inc -I"/media/adrian/usb_a/Chambas/Inbiodroid/Horno_d_reflujo/Firmware/stm32f411/reflow_oven/Drivers/lvgl" -I../Drivers/STM32F4xx_HAL_Driver/Inc -I../Drivers/STM32F4xx_HAL_Driver/Inc/Legacy -I../Drivers/CMSIS/Device/ST/STM32F4xx/Include -I../Drivers/CMSIS/Include -I"/media/adrian/usb_a/Chambas/Inbiodroid/Horno_d_reflujo/Firmware/stm32f411/reflow_oven/Drivers/ui" -O0 -ffunction-sections -fdata-sections -Wall -fstack-usage -fcyclomatic-complexity -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" --specs=nano.specs -mfpu=fpv4-sp-d16 -mfloat-abi=hard -mthumb -o "$@"

clean: clean-Drivers-2f-lvgl-2f-src-2f-widgets-2f-table

clean-Drivers-2f-lvgl-2f-src-2f-widgets-2f-table:
	-$(RM) ./Drivers/lvgl/src/widgets/table/lv_table.cyclo ./Drivers/lvgl/src/widgets/table/lv_table.d ./Drivers/lvgl/src/widgets/table/lv_table.o ./Drivers/lvgl/src/widgets/table/lv_table.su

.PHONY: clean-Drivers-2f-lvgl-2f-src-2f-widgets-2f-table

