################################################################################
# Automatically-generated file. Do not edit!
# Toolchain: GNU Tools for STM32 (13.3.rel1)
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../Drivers/lvgl/src/draw/sw/lv_draw_sw.c \
../Drivers/lvgl/src/draw/sw/lv_draw_sw_arc.c \
../Drivers/lvgl/src/draw/sw/lv_draw_sw_border.c \
../Drivers/lvgl/src/draw/sw/lv_draw_sw_box_shadow.c \
../Drivers/lvgl/src/draw/sw/lv_draw_sw_fill.c \
../Drivers/lvgl/src/draw/sw/lv_draw_sw_gradient.c \
../Drivers/lvgl/src/draw/sw/lv_draw_sw_img.c \
../Drivers/lvgl/src/draw/sw/lv_draw_sw_letter.c \
../Drivers/lvgl/src/draw/sw/lv_draw_sw_line.c \
../Drivers/lvgl/src/draw/sw/lv_draw_sw_mask.c \
../Drivers/lvgl/src/draw/sw/lv_draw_sw_mask_rect.c \
../Drivers/lvgl/src/draw/sw/lv_draw_sw_transform.c \
../Drivers/lvgl/src/draw/sw/lv_draw_sw_triangle.c \
../Drivers/lvgl/src/draw/sw/lv_draw_sw_vector.c 

OBJS += \
./Drivers/lvgl/src/draw/sw/lv_draw_sw.o \
./Drivers/lvgl/src/draw/sw/lv_draw_sw_arc.o \
./Drivers/lvgl/src/draw/sw/lv_draw_sw_border.o \
./Drivers/lvgl/src/draw/sw/lv_draw_sw_box_shadow.o \
./Drivers/lvgl/src/draw/sw/lv_draw_sw_fill.o \
./Drivers/lvgl/src/draw/sw/lv_draw_sw_gradient.o \
./Drivers/lvgl/src/draw/sw/lv_draw_sw_img.o \
./Drivers/lvgl/src/draw/sw/lv_draw_sw_letter.o \
./Drivers/lvgl/src/draw/sw/lv_draw_sw_line.o \
./Drivers/lvgl/src/draw/sw/lv_draw_sw_mask.o \
./Drivers/lvgl/src/draw/sw/lv_draw_sw_mask_rect.o \
./Drivers/lvgl/src/draw/sw/lv_draw_sw_transform.o \
./Drivers/lvgl/src/draw/sw/lv_draw_sw_triangle.o \
./Drivers/lvgl/src/draw/sw/lv_draw_sw_vector.o 

C_DEPS += \
./Drivers/lvgl/src/draw/sw/lv_draw_sw.d \
./Drivers/lvgl/src/draw/sw/lv_draw_sw_arc.d \
./Drivers/lvgl/src/draw/sw/lv_draw_sw_border.d \
./Drivers/lvgl/src/draw/sw/lv_draw_sw_box_shadow.d \
./Drivers/lvgl/src/draw/sw/lv_draw_sw_fill.d \
./Drivers/lvgl/src/draw/sw/lv_draw_sw_gradient.d \
./Drivers/lvgl/src/draw/sw/lv_draw_sw_img.d \
./Drivers/lvgl/src/draw/sw/lv_draw_sw_letter.d \
./Drivers/lvgl/src/draw/sw/lv_draw_sw_line.d \
./Drivers/lvgl/src/draw/sw/lv_draw_sw_mask.d \
./Drivers/lvgl/src/draw/sw/lv_draw_sw_mask_rect.d \
./Drivers/lvgl/src/draw/sw/lv_draw_sw_transform.d \
./Drivers/lvgl/src/draw/sw/lv_draw_sw_triangle.d \
./Drivers/lvgl/src/draw/sw/lv_draw_sw_vector.d 


# Each subdirectory must supply rules for building sources it contributes
Drivers/lvgl/src/draw/sw/%.o Drivers/lvgl/src/draw/sw/%.su Drivers/lvgl/src/draw/sw/%.cyclo: ../Drivers/lvgl/src/draw/sw/%.c Drivers/lvgl/src/draw/sw/subdir.mk
	arm-none-eabi-gcc "$<" -mcpu=cortex-m4 -std=gnu11 -g3 -DDEBUG -DUSE_HAL_DRIVER -DSTM32F411xE -c -I../Core/Inc -I"/media/adrian/usb_a/Chambas/Inbiodroid/Horno_d_reflujo/Firmware/stm32f411/reflow_oven/Drivers/lvgl" -I../Drivers/STM32F4xx_HAL_Driver/Inc -I../Drivers/STM32F4xx_HAL_Driver/Inc/Legacy -I../Drivers/CMSIS/Device/ST/STM32F4xx/Include -I../Drivers/CMSIS/Include -I"/media/adrian/usb_a/Chambas/Inbiodroid/Horno_d_reflujo/Firmware/stm32f411/reflow_oven/Drivers/ui" -O0 -ffunction-sections -fdata-sections -Wall -fstack-usage -fcyclomatic-complexity -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" --specs=nano.specs -mfpu=fpv4-sp-d16 -mfloat-abi=hard -mthumb -o "$@"

clean: clean-Drivers-2f-lvgl-2f-src-2f-draw-2f-sw

clean-Drivers-2f-lvgl-2f-src-2f-draw-2f-sw:
	-$(RM) ./Drivers/lvgl/src/draw/sw/lv_draw_sw.cyclo ./Drivers/lvgl/src/draw/sw/lv_draw_sw.d ./Drivers/lvgl/src/draw/sw/lv_draw_sw.o ./Drivers/lvgl/src/draw/sw/lv_draw_sw.su ./Drivers/lvgl/src/draw/sw/lv_draw_sw_arc.cyclo ./Drivers/lvgl/src/draw/sw/lv_draw_sw_arc.d ./Drivers/lvgl/src/draw/sw/lv_draw_sw_arc.o ./Drivers/lvgl/src/draw/sw/lv_draw_sw_arc.su ./Drivers/lvgl/src/draw/sw/lv_draw_sw_border.cyclo ./Drivers/lvgl/src/draw/sw/lv_draw_sw_border.d ./Drivers/lvgl/src/draw/sw/lv_draw_sw_border.o ./Drivers/lvgl/src/draw/sw/lv_draw_sw_border.su ./Drivers/lvgl/src/draw/sw/lv_draw_sw_box_shadow.cyclo ./Drivers/lvgl/src/draw/sw/lv_draw_sw_box_shadow.d ./Drivers/lvgl/src/draw/sw/lv_draw_sw_box_shadow.o ./Drivers/lvgl/src/draw/sw/lv_draw_sw_box_shadow.su ./Drivers/lvgl/src/draw/sw/lv_draw_sw_fill.cyclo ./Drivers/lvgl/src/draw/sw/lv_draw_sw_fill.d ./Drivers/lvgl/src/draw/sw/lv_draw_sw_fill.o ./Drivers/lvgl/src/draw/sw/lv_draw_sw_fill.su ./Drivers/lvgl/src/draw/sw/lv_draw_sw_gradient.cyclo ./Drivers/lvgl/src/draw/sw/lv_draw_sw_gradient.d ./Drivers/lvgl/src/draw/sw/lv_draw_sw_gradient.o ./Drivers/lvgl/src/draw/sw/lv_draw_sw_gradient.su ./Drivers/lvgl/src/draw/sw/lv_draw_sw_img.cyclo ./Drivers/lvgl/src/draw/sw/lv_draw_sw_img.d ./Drivers/lvgl/src/draw/sw/lv_draw_sw_img.o ./Drivers/lvgl/src/draw/sw/lv_draw_sw_img.su ./Drivers/lvgl/src/draw/sw/lv_draw_sw_letter.cyclo ./Drivers/lvgl/src/draw/sw/lv_draw_sw_letter.d ./Drivers/lvgl/src/draw/sw/lv_draw_sw_letter.o ./Drivers/lvgl/src/draw/sw/lv_draw_sw_letter.su ./Drivers/lvgl/src/draw/sw/lv_draw_sw_line.cyclo ./Drivers/lvgl/src/draw/sw/lv_draw_sw_line.d ./Drivers/lvgl/src/draw/sw/lv_draw_sw_line.o ./Drivers/lvgl/src/draw/sw/lv_draw_sw_line.su ./Drivers/lvgl/src/draw/sw/lv_draw_sw_mask.cyclo ./Drivers/lvgl/src/draw/sw/lv_draw_sw_mask.d ./Drivers/lvgl/src/draw/sw/lv_draw_sw_mask.o ./Drivers/lvgl/src/draw/sw/lv_draw_sw_mask.su ./Drivers/lvgl/src/draw/sw/lv_draw_sw_mask_rect.cyclo ./Drivers/lvgl/src/draw/sw/lv_draw_sw_mask_rect.d ./Drivers/lvgl/src/draw/sw/lv_draw_sw_mask_rect.o ./Drivers/lvgl/src/draw/sw/lv_draw_sw_mask_rect.su ./Drivers/lvgl/src/draw/sw/lv_draw_sw_transform.cyclo ./Drivers/lvgl/src/draw/sw/lv_draw_sw_transform.d ./Drivers/lvgl/src/draw/sw/lv_draw_sw_transform.o ./Drivers/lvgl/src/draw/sw/lv_draw_sw_transform.su ./Drivers/lvgl/src/draw/sw/lv_draw_sw_triangle.cyclo ./Drivers/lvgl/src/draw/sw/lv_draw_sw_triangle.d ./Drivers/lvgl/src/draw/sw/lv_draw_sw_triangle.o ./Drivers/lvgl/src/draw/sw/lv_draw_sw_triangle.su ./Drivers/lvgl/src/draw/sw/lv_draw_sw_vector.cyclo ./Drivers/lvgl/src/draw/sw/lv_draw_sw_vector.d ./Drivers/lvgl/src/draw/sw/lv_draw_sw_vector.o ./Drivers/lvgl/src/draw/sw/lv_draw_sw_vector.su

.PHONY: clean-Drivers-2f-lvgl-2f-src-2f-draw-2f-sw

