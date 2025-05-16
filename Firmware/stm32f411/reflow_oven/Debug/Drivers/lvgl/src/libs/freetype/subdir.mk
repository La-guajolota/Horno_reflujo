################################################################################
# Automatically-generated file. Do not edit!
# Toolchain: GNU Tools for STM32 (13.3.rel1)
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../Drivers/lvgl/src/libs/freetype/lv_freetype.c \
../Drivers/lvgl/src/libs/freetype/lv_freetype_glyph.c \
../Drivers/lvgl/src/libs/freetype/lv_freetype_image.c \
../Drivers/lvgl/src/libs/freetype/lv_freetype_outline.c \
../Drivers/lvgl/src/libs/freetype/lv_ftsystem.c 

OBJS += \
./Drivers/lvgl/src/libs/freetype/lv_freetype.o \
./Drivers/lvgl/src/libs/freetype/lv_freetype_glyph.o \
./Drivers/lvgl/src/libs/freetype/lv_freetype_image.o \
./Drivers/lvgl/src/libs/freetype/lv_freetype_outline.o \
./Drivers/lvgl/src/libs/freetype/lv_ftsystem.o 

C_DEPS += \
./Drivers/lvgl/src/libs/freetype/lv_freetype.d \
./Drivers/lvgl/src/libs/freetype/lv_freetype_glyph.d \
./Drivers/lvgl/src/libs/freetype/lv_freetype_image.d \
./Drivers/lvgl/src/libs/freetype/lv_freetype_outline.d \
./Drivers/lvgl/src/libs/freetype/lv_ftsystem.d 


# Each subdirectory must supply rules for building sources it contributes
Drivers/lvgl/src/libs/freetype/%.o Drivers/lvgl/src/libs/freetype/%.su Drivers/lvgl/src/libs/freetype/%.cyclo: ../Drivers/lvgl/src/libs/freetype/%.c Drivers/lvgl/src/libs/freetype/subdir.mk
	arm-none-eabi-gcc "$<" -mcpu=cortex-m4 -std=gnu11 -g3 -DDEBUG -DUSE_HAL_DRIVER -DSTM32F411xE -c -I../Core/Inc -I"/media/adrian/usb_a/Chambas/Inbiodroid/Horno_d_reflujo/Firmware/stm32f411/reflow_oven/Drivers/lvgl" -I../Drivers/STM32F4xx_HAL_Driver/Inc -I../Drivers/STM32F4xx_HAL_Driver/Inc/Legacy -I../Drivers/CMSIS/Device/ST/STM32F4xx/Include -I../Drivers/CMSIS/Include -I"/media/adrian/usb_a/Chambas/Inbiodroid/Horno_d_reflujo/Firmware/stm32f411/reflow_oven/Drivers/ui" -O0 -ffunction-sections -fdata-sections -Wall -fstack-usage -fcyclomatic-complexity -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" --specs=nano.specs -mfpu=fpv4-sp-d16 -mfloat-abi=hard -mthumb -o "$@"

clean: clean-Drivers-2f-lvgl-2f-src-2f-libs-2f-freetype

clean-Drivers-2f-lvgl-2f-src-2f-libs-2f-freetype:
	-$(RM) ./Drivers/lvgl/src/libs/freetype/lv_freetype.cyclo ./Drivers/lvgl/src/libs/freetype/lv_freetype.d ./Drivers/lvgl/src/libs/freetype/lv_freetype.o ./Drivers/lvgl/src/libs/freetype/lv_freetype.su ./Drivers/lvgl/src/libs/freetype/lv_freetype_glyph.cyclo ./Drivers/lvgl/src/libs/freetype/lv_freetype_glyph.d ./Drivers/lvgl/src/libs/freetype/lv_freetype_glyph.o ./Drivers/lvgl/src/libs/freetype/lv_freetype_glyph.su ./Drivers/lvgl/src/libs/freetype/lv_freetype_image.cyclo ./Drivers/lvgl/src/libs/freetype/lv_freetype_image.d ./Drivers/lvgl/src/libs/freetype/lv_freetype_image.o ./Drivers/lvgl/src/libs/freetype/lv_freetype_image.su ./Drivers/lvgl/src/libs/freetype/lv_freetype_outline.cyclo ./Drivers/lvgl/src/libs/freetype/lv_freetype_outline.d ./Drivers/lvgl/src/libs/freetype/lv_freetype_outline.o ./Drivers/lvgl/src/libs/freetype/lv_freetype_outline.su ./Drivers/lvgl/src/libs/freetype/lv_ftsystem.cyclo ./Drivers/lvgl/src/libs/freetype/lv_ftsystem.d ./Drivers/lvgl/src/libs/freetype/lv_ftsystem.o ./Drivers/lvgl/src/libs/freetype/lv_ftsystem.su

.PHONY: clean-Drivers-2f-lvgl-2f-src-2f-libs-2f-freetype

