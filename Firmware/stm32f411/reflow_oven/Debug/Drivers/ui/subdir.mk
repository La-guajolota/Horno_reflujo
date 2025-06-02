################################################################################
# Automatically-generated file. Do not edit!
# Toolchain: GNU Tools for STM32 (13.3.rel1)
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../Drivers/ui/images.c \
../Drivers/ui/screens.c \
../Drivers/ui/styles.c \
../Drivers/ui/ui.c \
../Drivers/ui/ui_image_cube_test.c \
../Drivers/ui/ui_image_lins.c \
../Drivers/ui/ui_image_pic_test.c 

OBJS += \
./Drivers/ui/images.o \
./Drivers/ui/screens.o \
./Drivers/ui/styles.o \
./Drivers/ui/ui.o \
./Drivers/ui/ui_image_cube_test.o \
./Drivers/ui/ui_image_lins.o \
./Drivers/ui/ui_image_pic_test.o 

C_DEPS += \
./Drivers/ui/images.d \
./Drivers/ui/screens.d \
./Drivers/ui/styles.d \
./Drivers/ui/ui.d \
./Drivers/ui/ui_image_cube_test.d \
./Drivers/ui/ui_image_lins.d \
./Drivers/ui/ui_image_pic_test.d 


# Each subdirectory must supply rules for building sources it contributes
Drivers/ui/%.o Drivers/ui/%.su Drivers/ui/%.cyclo: ../Drivers/ui/%.c Drivers/ui/subdir.mk
	arm-none-eabi-gcc "$<" -mcpu=cortex-m4 -std=gnu11 -g3 -DDEBUG -DUSE_HAL_DRIVER -DSTM32F411xE -c -I../Core/Inc -I"/media/adrian/usb_a/Chambas/Inbiodroid/Horno_d_reflujo/Firmware/stm32f411/reflow_oven/Drivers/lvgl" -I../Drivers/STM32F4xx_HAL_Driver/Inc -I../Drivers/STM32F4xx_HAL_Driver/Inc/Legacy -I../Drivers/CMSIS/Device/ST/STM32F4xx/Include -I../Drivers/CMSIS/Include -I"/media/adrian/usb_a/Chambas/Inbiodroid/Horno_d_reflujo/Firmware/stm32f411/reflow_oven/Drivers/ui" -O0 -ffunction-sections -fdata-sections -Wall -fstack-usage -fcyclomatic-complexity -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" --specs=nano.specs -mfpu=fpv4-sp-d16 -mfloat-abi=hard -mthumb -o "$@"

clean: clean-Drivers-2f-ui

clean-Drivers-2f-ui:
	-$(RM) ./Drivers/ui/images.cyclo ./Drivers/ui/images.d ./Drivers/ui/images.o ./Drivers/ui/images.su ./Drivers/ui/screens.cyclo ./Drivers/ui/screens.d ./Drivers/ui/screens.o ./Drivers/ui/screens.su ./Drivers/ui/styles.cyclo ./Drivers/ui/styles.d ./Drivers/ui/styles.o ./Drivers/ui/styles.su ./Drivers/ui/ui.cyclo ./Drivers/ui/ui.d ./Drivers/ui/ui.o ./Drivers/ui/ui.su ./Drivers/ui/ui_image_cube_test.cyclo ./Drivers/ui/ui_image_cube_test.d ./Drivers/ui/ui_image_cube_test.o ./Drivers/ui/ui_image_cube_test.su ./Drivers/ui/ui_image_lins.cyclo ./Drivers/ui/ui_image_lins.d ./Drivers/ui/ui_image_lins.o ./Drivers/ui/ui_image_lins.su ./Drivers/ui/ui_image_pic_test.cyclo ./Drivers/ui/ui_image_pic_test.d ./Drivers/ui/ui_image_pic_test.o ./Drivers/ui/ui_image_pic_test.su

.PHONY: clean-Drivers-2f-ui

