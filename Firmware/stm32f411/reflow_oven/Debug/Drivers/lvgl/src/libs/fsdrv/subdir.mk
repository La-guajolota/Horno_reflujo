################################################################################
# Automatically-generated file. Do not edit!
# Toolchain: GNU Tools for STM32 (13.3.rel1)
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../Drivers/lvgl/src/libs/fsdrv/lv_fs_cbfs.c \
../Drivers/lvgl/src/libs/fsdrv/lv_fs_fatfs.c \
../Drivers/lvgl/src/libs/fsdrv/lv_fs_littlefs.c \
../Drivers/lvgl/src/libs/fsdrv/lv_fs_memfs.c \
../Drivers/lvgl/src/libs/fsdrv/lv_fs_posix.c \
../Drivers/lvgl/src/libs/fsdrv/lv_fs_stdio.c \
../Drivers/lvgl/src/libs/fsdrv/lv_fs_win32.c 

OBJS += \
./Drivers/lvgl/src/libs/fsdrv/lv_fs_cbfs.o \
./Drivers/lvgl/src/libs/fsdrv/lv_fs_fatfs.o \
./Drivers/lvgl/src/libs/fsdrv/lv_fs_littlefs.o \
./Drivers/lvgl/src/libs/fsdrv/lv_fs_memfs.o \
./Drivers/lvgl/src/libs/fsdrv/lv_fs_posix.o \
./Drivers/lvgl/src/libs/fsdrv/lv_fs_stdio.o \
./Drivers/lvgl/src/libs/fsdrv/lv_fs_win32.o 

C_DEPS += \
./Drivers/lvgl/src/libs/fsdrv/lv_fs_cbfs.d \
./Drivers/lvgl/src/libs/fsdrv/lv_fs_fatfs.d \
./Drivers/lvgl/src/libs/fsdrv/lv_fs_littlefs.d \
./Drivers/lvgl/src/libs/fsdrv/lv_fs_memfs.d \
./Drivers/lvgl/src/libs/fsdrv/lv_fs_posix.d \
./Drivers/lvgl/src/libs/fsdrv/lv_fs_stdio.d \
./Drivers/lvgl/src/libs/fsdrv/lv_fs_win32.d 


# Each subdirectory must supply rules for building sources it contributes
Drivers/lvgl/src/libs/fsdrv/%.o Drivers/lvgl/src/libs/fsdrv/%.su Drivers/lvgl/src/libs/fsdrv/%.cyclo: ../Drivers/lvgl/src/libs/fsdrv/%.c Drivers/lvgl/src/libs/fsdrv/subdir.mk
	arm-none-eabi-gcc "$<" -mcpu=cortex-m4 -std=gnu11 -g3 -DDEBUG -DUSE_HAL_DRIVER -DSTM32F411xE -c -I../Core/Inc -I"/media/adrian/usb_a/Chambas/Inbiodroid/Horno_d_reflujo/Firmware/stm32f411/reflow_oven/Drivers/lvgl" -I../Drivers/STM32F4xx_HAL_Driver/Inc -I../Drivers/STM32F4xx_HAL_Driver/Inc/Legacy -I../Drivers/CMSIS/Device/ST/STM32F4xx/Include -I../Drivers/CMSIS/Include -I"/media/adrian/usb_a/Chambas/Inbiodroid/Horno_d_reflujo/Firmware/stm32f411/reflow_oven/Drivers/ui" -O0 -ffunction-sections -fdata-sections -Wall -fstack-usage -fcyclomatic-complexity -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" --specs=nano.specs -mfpu=fpv4-sp-d16 -mfloat-abi=hard -mthumb -o "$@"

clean: clean-Drivers-2f-lvgl-2f-src-2f-libs-2f-fsdrv

clean-Drivers-2f-lvgl-2f-src-2f-libs-2f-fsdrv:
	-$(RM) ./Drivers/lvgl/src/libs/fsdrv/lv_fs_cbfs.cyclo ./Drivers/lvgl/src/libs/fsdrv/lv_fs_cbfs.d ./Drivers/lvgl/src/libs/fsdrv/lv_fs_cbfs.o ./Drivers/lvgl/src/libs/fsdrv/lv_fs_cbfs.su ./Drivers/lvgl/src/libs/fsdrv/lv_fs_fatfs.cyclo ./Drivers/lvgl/src/libs/fsdrv/lv_fs_fatfs.d ./Drivers/lvgl/src/libs/fsdrv/lv_fs_fatfs.o ./Drivers/lvgl/src/libs/fsdrv/lv_fs_fatfs.su ./Drivers/lvgl/src/libs/fsdrv/lv_fs_littlefs.cyclo ./Drivers/lvgl/src/libs/fsdrv/lv_fs_littlefs.d ./Drivers/lvgl/src/libs/fsdrv/lv_fs_littlefs.o ./Drivers/lvgl/src/libs/fsdrv/lv_fs_littlefs.su ./Drivers/lvgl/src/libs/fsdrv/lv_fs_memfs.cyclo ./Drivers/lvgl/src/libs/fsdrv/lv_fs_memfs.d ./Drivers/lvgl/src/libs/fsdrv/lv_fs_memfs.o ./Drivers/lvgl/src/libs/fsdrv/lv_fs_memfs.su ./Drivers/lvgl/src/libs/fsdrv/lv_fs_posix.cyclo ./Drivers/lvgl/src/libs/fsdrv/lv_fs_posix.d ./Drivers/lvgl/src/libs/fsdrv/lv_fs_posix.o ./Drivers/lvgl/src/libs/fsdrv/lv_fs_posix.su ./Drivers/lvgl/src/libs/fsdrv/lv_fs_stdio.cyclo ./Drivers/lvgl/src/libs/fsdrv/lv_fs_stdio.d ./Drivers/lvgl/src/libs/fsdrv/lv_fs_stdio.o ./Drivers/lvgl/src/libs/fsdrv/lv_fs_stdio.su ./Drivers/lvgl/src/libs/fsdrv/lv_fs_win32.cyclo ./Drivers/lvgl/src/libs/fsdrv/lv_fs_win32.d ./Drivers/lvgl/src/libs/fsdrv/lv_fs_win32.o ./Drivers/lvgl/src/libs/fsdrv/lv_fs_win32.su

.PHONY: clean-Drivers-2f-lvgl-2f-src-2f-libs-2f-fsdrv

