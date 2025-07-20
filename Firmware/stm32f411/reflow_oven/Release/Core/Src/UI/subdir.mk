################################################################################
# Automatically-generated file. Do not edit!
# Toolchain: GNU Tools for STM32 (13.3.rel1)
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../Core/Src/UI/gui_backend.c 

OBJS += \
./Core/Src/UI/gui_backend.o 

C_DEPS += \
./Core/Src/UI/gui_backend.d 


# Each subdirectory must supply rules for building sources it contributes
Core/Src/UI/%.o Core/Src/UI/%.su Core/Src/UI/%.cyclo: ../Core/Src/UI/%.c Core/Src/UI/subdir.mk
	arm-none-eabi-gcc "$<" -mcpu=cortex-m4 -std=gnu11 -DUSE_HAL_DRIVER -DSTM32F411xE -c -I../Core/Inc -I../Drivers/STM32F4xx_HAL_Driver/Inc -I../Drivers/STM32F4xx_HAL_Driver/Inc/Legacy -I../Drivers/CMSIS/Device/ST/STM32F4xx/Include -I../Drivers/CMSIS/Include -Os -ffunction-sections -fdata-sections -Wall -fstack-usage -fcyclomatic-complexity -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" --specs=nano.specs -mfpu=fpv4-sp-d16 -mfloat-abi=hard -mthumb -o "$@"

clean: clean-Core-2f-Src-2f-UI

clean-Core-2f-Src-2f-UI:
	-$(RM) ./Core/Src/UI/gui_backend.cyclo ./Core/Src/UI/gui_backend.d ./Core/Src/UI/gui_backend.o ./Core/Src/UI/gui_backend.su

.PHONY: clean-Core-2f-Src-2f-UI

