################################################################################
# Automatically-generated file. Do not edit!
# Toolchain: GNU Tools for STM32 (13.3.rel1)
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../Drivers/lvgl/src/draw/nxp/vglite/lv_draw_buf_vglite.c \
../Drivers/lvgl/src/draw/nxp/vglite/lv_draw_vglite.c \
../Drivers/lvgl/src/draw/nxp/vglite/lv_draw_vglite_arc.c \
../Drivers/lvgl/src/draw/nxp/vglite/lv_draw_vglite_border.c \
../Drivers/lvgl/src/draw/nxp/vglite/lv_draw_vglite_fill.c \
../Drivers/lvgl/src/draw/nxp/vglite/lv_draw_vglite_img.c \
../Drivers/lvgl/src/draw/nxp/vglite/lv_draw_vglite_label.c \
../Drivers/lvgl/src/draw/nxp/vglite/lv_draw_vglite_layer.c \
../Drivers/lvgl/src/draw/nxp/vglite/lv_draw_vglite_line.c \
../Drivers/lvgl/src/draw/nxp/vglite/lv_draw_vglite_triangle.c \
../Drivers/lvgl/src/draw/nxp/vglite/lv_vglite_buf.c \
../Drivers/lvgl/src/draw/nxp/vglite/lv_vglite_matrix.c \
../Drivers/lvgl/src/draw/nxp/vglite/lv_vglite_path.c \
../Drivers/lvgl/src/draw/nxp/vglite/lv_vglite_utils.c 

OBJS += \
./Drivers/lvgl/src/draw/nxp/vglite/lv_draw_buf_vglite.o \
./Drivers/lvgl/src/draw/nxp/vglite/lv_draw_vglite.o \
./Drivers/lvgl/src/draw/nxp/vglite/lv_draw_vglite_arc.o \
./Drivers/lvgl/src/draw/nxp/vglite/lv_draw_vglite_border.o \
./Drivers/lvgl/src/draw/nxp/vglite/lv_draw_vglite_fill.o \
./Drivers/lvgl/src/draw/nxp/vglite/lv_draw_vglite_img.o \
./Drivers/lvgl/src/draw/nxp/vglite/lv_draw_vglite_label.o \
./Drivers/lvgl/src/draw/nxp/vglite/lv_draw_vglite_layer.o \
./Drivers/lvgl/src/draw/nxp/vglite/lv_draw_vglite_line.o \
./Drivers/lvgl/src/draw/nxp/vglite/lv_draw_vglite_triangle.o \
./Drivers/lvgl/src/draw/nxp/vglite/lv_vglite_buf.o \
./Drivers/lvgl/src/draw/nxp/vglite/lv_vglite_matrix.o \
./Drivers/lvgl/src/draw/nxp/vglite/lv_vglite_path.o \
./Drivers/lvgl/src/draw/nxp/vglite/lv_vglite_utils.o 

C_DEPS += \
./Drivers/lvgl/src/draw/nxp/vglite/lv_draw_buf_vglite.d \
./Drivers/lvgl/src/draw/nxp/vglite/lv_draw_vglite.d \
./Drivers/lvgl/src/draw/nxp/vglite/lv_draw_vglite_arc.d \
./Drivers/lvgl/src/draw/nxp/vglite/lv_draw_vglite_border.d \
./Drivers/lvgl/src/draw/nxp/vglite/lv_draw_vglite_fill.d \
./Drivers/lvgl/src/draw/nxp/vglite/lv_draw_vglite_img.d \
./Drivers/lvgl/src/draw/nxp/vglite/lv_draw_vglite_label.d \
./Drivers/lvgl/src/draw/nxp/vglite/lv_draw_vglite_layer.d \
./Drivers/lvgl/src/draw/nxp/vglite/lv_draw_vglite_line.d \
./Drivers/lvgl/src/draw/nxp/vglite/lv_draw_vglite_triangle.d \
./Drivers/lvgl/src/draw/nxp/vglite/lv_vglite_buf.d \
./Drivers/lvgl/src/draw/nxp/vglite/lv_vglite_matrix.d \
./Drivers/lvgl/src/draw/nxp/vglite/lv_vglite_path.d \
./Drivers/lvgl/src/draw/nxp/vglite/lv_vglite_utils.d 


# Each subdirectory must supply rules for building sources it contributes
Drivers/lvgl/src/draw/nxp/vglite/%.o Drivers/lvgl/src/draw/nxp/vglite/%.su Drivers/lvgl/src/draw/nxp/vglite/%.cyclo: ../Drivers/lvgl/src/draw/nxp/vglite/%.c Drivers/lvgl/src/draw/nxp/vglite/subdir.mk
	arm-none-eabi-gcc "$<" -mcpu=cortex-m4 -std=gnu11 -g3 -DDEBUG -DUSE_HAL_DRIVER -DSTM32F411xE -c -I../Core/Inc -I"/media/adrian/usb_a/Chambas/Inbiodroid/Horno_d_reflujo/Firmware/reflow_oven/Drivers/lvgl" -I../Drivers/STM32F4xx_HAL_Driver/Inc -I../Drivers/STM32F4xx_HAL_Driver/Inc/Legacy -I../Drivers/CMSIS/Device/ST/STM32F4xx/Include -I../Drivers/CMSIS/Include -I"/media/adrian/usb_a/Chambas/Inbiodroid/Horno_d_reflujo/Firmware/reflow_oven/Drivers/ui" -O0 -ffunction-sections -fdata-sections -Wall -fstack-usage -fcyclomatic-complexity -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" --specs=nano.specs -mfpu=fpv4-sp-d16 -mfloat-abi=hard -mthumb -o "$@"

clean: clean-Drivers-2f-lvgl-2f-src-2f-draw-2f-nxp-2f-vglite

clean-Drivers-2f-lvgl-2f-src-2f-draw-2f-nxp-2f-vglite:
	-$(RM) ./Drivers/lvgl/src/draw/nxp/vglite/lv_draw_buf_vglite.cyclo ./Drivers/lvgl/src/draw/nxp/vglite/lv_draw_buf_vglite.d ./Drivers/lvgl/src/draw/nxp/vglite/lv_draw_buf_vglite.o ./Drivers/lvgl/src/draw/nxp/vglite/lv_draw_buf_vglite.su ./Drivers/lvgl/src/draw/nxp/vglite/lv_draw_vglite.cyclo ./Drivers/lvgl/src/draw/nxp/vglite/lv_draw_vglite.d ./Drivers/lvgl/src/draw/nxp/vglite/lv_draw_vglite.o ./Drivers/lvgl/src/draw/nxp/vglite/lv_draw_vglite.su ./Drivers/lvgl/src/draw/nxp/vglite/lv_draw_vglite_arc.cyclo ./Drivers/lvgl/src/draw/nxp/vglite/lv_draw_vglite_arc.d ./Drivers/lvgl/src/draw/nxp/vglite/lv_draw_vglite_arc.o ./Drivers/lvgl/src/draw/nxp/vglite/lv_draw_vglite_arc.su ./Drivers/lvgl/src/draw/nxp/vglite/lv_draw_vglite_border.cyclo ./Drivers/lvgl/src/draw/nxp/vglite/lv_draw_vglite_border.d ./Drivers/lvgl/src/draw/nxp/vglite/lv_draw_vglite_border.o ./Drivers/lvgl/src/draw/nxp/vglite/lv_draw_vglite_border.su ./Drivers/lvgl/src/draw/nxp/vglite/lv_draw_vglite_fill.cyclo ./Drivers/lvgl/src/draw/nxp/vglite/lv_draw_vglite_fill.d ./Drivers/lvgl/src/draw/nxp/vglite/lv_draw_vglite_fill.o ./Drivers/lvgl/src/draw/nxp/vglite/lv_draw_vglite_fill.su ./Drivers/lvgl/src/draw/nxp/vglite/lv_draw_vglite_img.cyclo ./Drivers/lvgl/src/draw/nxp/vglite/lv_draw_vglite_img.d ./Drivers/lvgl/src/draw/nxp/vglite/lv_draw_vglite_img.o ./Drivers/lvgl/src/draw/nxp/vglite/lv_draw_vglite_img.su ./Drivers/lvgl/src/draw/nxp/vglite/lv_draw_vglite_label.cyclo ./Drivers/lvgl/src/draw/nxp/vglite/lv_draw_vglite_label.d ./Drivers/lvgl/src/draw/nxp/vglite/lv_draw_vglite_label.o ./Drivers/lvgl/src/draw/nxp/vglite/lv_draw_vglite_label.su ./Drivers/lvgl/src/draw/nxp/vglite/lv_draw_vglite_layer.cyclo ./Drivers/lvgl/src/draw/nxp/vglite/lv_draw_vglite_layer.d ./Drivers/lvgl/src/draw/nxp/vglite/lv_draw_vglite_layer.o ./Drivers/lvgl/src/draw/nxp/vglite/lv_draw_vglite_layer.su ./Drivers/lvgl/src/draw/nxp/vglite/lv_draw_vglite_line.cyclo ./Drivers/lvgl/src/draw/nxp/vglite/lv_draw_vglite_line.d ./Drivers/lvgl/src/draw/nxp/vglite/lv_draw_vglite_line.o ./Drivers/lvgl/src/draw/nxp/vglite/lv_draw_vglite_line.su ./Drivers/lvgl/src/draw/nxp/vglite/lv_draw_vglite_triangle.cyclo ./Drivers/lvgl/src/draw/nxp/vglite/lv_draw_vglite_triangle.d ./Drivers/lvgl/src/draw/nxp/vglite/lv_draw_vglite_triangle.o ./Drivers/lvgl/src/draw/nxp/vglite/lv_draw_vglite_triangle.su ./Drivers/lvgl/src/draw/nxp/vglite/lv_vglite_buf.cyclo ./Drivers/lvgl/src/draw/nxp/vglite/lv_vglite_buf.d ./Drivers/lvgl/src/draw/nxp/vglite/lv_vglite_buf.o ./Drivers/lvgl/src/draw/nxp/vglite/lv_vglite_buf.su ./Drivers/lvgl/src/draw/nxp/vglite/lv_vglite_matrix.cyclo ./Drivers/lvgl/src/draw/nxp/vglite/lv_vglite_matrix.d ./Drivers/lvgl/src/draw/nxp/vglite/lv_vglite_matrix.o ./Drivers/lvgl/src/draw/nxp/vglite/lv_vglite_matrix.su ./Drivers/lvgl/src/draw/nxp/vglite/lv_vglite_path.cyclo ./Drivers/lvgl/src/draw/nxp/vglite/lv_vglite_path.d ./Drivers/lvgl/src/draw/nxp/vglite/lv_vglite_path.o ./Drivers/lvgl/src/draw/nxp/vglite/lv_vglite_path.su ./Drivers/lvgl/src/draw/nxp/vglite/lv_vglite_utils.cyclo ./Drivers/lvgl/src/draw/nxp/vglite/lv_vglite_utils.d ./Drivers/lvgl/src/draw/nxp/vglite/lv_vglite_utils.o ./Drivers/lvgl/src/draw/nxp/vglite/lv_vglite_utils.su

.PHONY: clean-Drivers-2f-lvgl-2f-src-2f-draw-2f-nxp-2f-vglite

