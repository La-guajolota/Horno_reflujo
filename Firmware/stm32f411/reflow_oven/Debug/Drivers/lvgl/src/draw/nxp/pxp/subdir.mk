################################################################################
# Automatically-generated file. Do not edit!
# Toolchain: GNU Tools for STM32 (13.3.rel1)
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../Drivers/lvgl/src/draw/nxp/pxp/lv_draw_buf_pxp.c \
../Drivers/lvgl/src/draw/nxp/pxp/lv_draw_pxp.c \
../Drivers/lvgl/src/draw/nxp/pxp/lv_draw_pxp_fill.c \
../Drivers/lvgl/src/draw/nxp/pxp/lv_draw_pxp_img.c \
../Drivers/lvgl/src/draw/nxp/pxp/lv_draw_pxp_layer.c \
../Drivers/lvgl/src/draw/nxp/pxp/lv_pxp_cfg.c \
../Drivers/lvgl/src/draw/nxp/pxp/lv_pxp_osa.c \
../Drivers/lvgl/src/draw/nxp/pxp/lv_pxp_utils.c 

OBJS += \
./Drivers/lvgl/src/draw/nxp/pxp/lv_draw_buf_pxp.o \
./Drivers/lvgl/src/draw/nxp/pxp/lv_draw_pxp.o \
./Drivers/lvgl/src/draw/nxp/pxp/lv_draw_pxp_fill.o \
./Drivers/lvgl/src/draw/nxp/pxp/lv_draw_pxp_img.o \
./Drivers/lvgl/src/draw/nxp/pxp/lv_draw_pxp_layer.o \
./Drivers/lvgl/src/draw/nxp/pxp/lv_pxp_cfg.o \
./Drivers/lvgl/src/draw/nxp/pxp/lv_pxp_osa.o \
./Drivers/lvgl/src/draw/nxp/pxp/lv_pxp_utils.o 

C_DEPS += \
./Drivers/lvgl/src/draw/nxp/pxp/lv_draw_buf_pxp.d \
./Drivers/lvgl/src/draw/nxp/pxp/lv_draw_pxp.d \
./Drivers/lvgl/src/draw/nxp/pxp/lv_draw_pxp_fill.d \
./Drivers/lvgl/src/draw/nxp/pxp/lv_draw_pxp_img.d \
./Drivers/lvgl/src/draw/nxp/pxp/lv_draw_pxp_layer.d \
./Drivers/lvgl/src/draw/nxp/pxp/lv_pxp_cfg.d \
./Drivers/lvgl/src/draw/nxp/pxp/lv_pxp_osa.d \
./Drivers/lvgl/src/draw/nxp/pxp/lv_pxp_utils.d 


# Each subdirectory must supply rules for building sources it contributes
Drivers/lvgl/src/draw/nxp/pxp/%.o Drivers/lvgl/src/draw/nxp/pxp/%.su Drivers/lvgl/src/draw/nxp/pxp/%.cyclo: ../Drivers/lvgl/src/draw/nxp/pxp/%.c Drivers/lvgl/src/draw/nxp/pxp/subdir.mk
	arm-none-eabi-gcc "$<" -mcpu=cortex-m4 -std=gnu11 -g3 -DDEBUG -DUSE_HAL_DRIVER -DSTM32F411xE -c -I../Core/Inc -I"/media/adrian/usb_a/Chambas/Inbiodroid/Horno_d_reflujo/Firmware/stm32f411/reflow_oven/Drivers/lvgl" -I../Drivers/STM32F4xx_HAL_Driver/Inc -I../Drivers/STM32F4xx_HAL_Driver/Inc/Legacy -I../Drivers/CMSIS/Device/ST/STM32F4xx/Include -I../Drivers/CMSIS/Include -I"/media/adrian/usb_a/Chambas/Inbiodroid/Horno_d_reflujo/Firmware/stm32f411/reflow_oven/Drivers/ui" -O0 -ffunction-sections -fdata-sections -Wall -fstack-usage -fcyclomatic-complexity -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" --specs=nano.specs -mfpu=fpv4-sp-d16 -mfloat-abi=hard -mthumb -o "$@"

clean: clean-Drivers-2f-lvgl-2f-src-2f-draw-2f-nxp-2f-pxp

clean-Drivers-2f-lvgl-2f-src-2f-draw-2f-nxp-2f-pxp:
	-$(RM) ./Drivers/lvgl/src/draw/nxp/pxp/lv_draw_buf_pxp.cyclo ./Drivers/lvgl/src/draw/nxp/pxp/lv_draw_buf_pxp.d ./Drivers/lvgl/src/draw/nxp/pxp/lv_draw_buf_pxp.o ./Drivers/lvgl/src/draw/nxp/pxp/lv_draw_buf_pxp.su ./Drivers/lvgl/src/draw/nxp/pxp/lv_draw_pxp.cyclo ./Drivers/lvgl/src/draw/nxp/pxp/lv_draw_pxp.d ./Drivers/lvgl/src/draw/nxp/pxp/lv_draw_pxp.o ./Drivers/lvgl/src/draw/nxp/pxp/lv_draw_pxp.su ./Drivers/lvgl/src/draw/nxp/pxp/lv_draw_pxp_fill.cyclo ./Drivers/lvgl/src/draw/nxp/pxp/lv_draw_pxp_fill.d ./Drivers/lvgl/src/draw/nxp/pxp/lv_draw_pxp_fill.o ./Drivers/lvgl/src/draw/nxp/pxp/lv_draw_pxp_fill.su ./Drivers/lvgl/src/draw/nxp/pxp/lv_draw_pxp_img.cyclo ./Drivers/lvgl/src/draw/nxp/pxp/lv_draw_pxp_img.d ./Drivers/lvgl/src/draw/nxp/pxp/lv_draw_pxp_img.o ./Drivers/lvgl/src/draw/nxp/pxp/lv_draw_pxp_img.su ./Drivers/lvgl/src/draw/nxp/pxp/lv_draw_pxp_layer.cyclo ./Drivers/lvgl/src/draw/nxp/pxp/lv_draw_pxp_layer.d ./Drivers/lvgl/src/draw/nxp/pxp/lv_draw_pxp_layer.o ./Drivers/lvgl/src/draw/nxp/pxp/lv_draw_pxp_layer.su ./Drivers/lvgl/src/draw/nxp/pxp/lv_pxp_cfg.cyclo ./Drivers/lvgl/src/draw/nxp/pxp/lv_pxp_cfg.d ./Drivers/lvgl/src/draw/nxp/pxp/lv_pxp_cfg.o ./Drivers/lvgl/src/draw/nxp/pxp/lv_pxp_cfg.su ./Drivers/lvgl/src/draw/nxp/pxp/lv_pxp_osa.cyclo ./Drivers/lvgl/src/draw/nxp/pxp/lv_pxp_osa.d ./Drivers/lvgl/src/draw/nxp/pxp/lv_pxp_osa.o ./Drivers/lvgl/src/draw/nxp/pxp/lv_pxp_osa.su ./Drivers/lvgl/src/draw/nxp/pxp/lv_pxp_utils.cyclo ./Drivers/lvgl/src/draw/nxp/pxp/lv_pxp_utils.d ./Drivers/lvgl/src/draw/nxp/pxp/lv_pxp_utils.o ./Drivers/lvgl/src/draw/nxp/pxp/lv_pxp_utils.su

.PHONY: clean-Drivers-2f-lvgl-2f-src-2f-draw-2f-nxp-2f-pxp

