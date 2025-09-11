################################################################################
# Automatically-generated file. Do not edit!
# Toolchain: GNU Tools for STM32 (13.3.rel1)
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../Core/Src/logic_control/pid.c \
../Core/Src/logic_control/reflow_oven_process.c 

OBJS += \
./Core/Src/logic_control/pid.o \
./Core/Src/logic_control/reflow_oven_process.o 

C_DEPS += \
./Core/Src/logic_control/pid.d \
./Core/Src/logic_control/reflow_oven_process.d 


# Each subdirectory must supply rules for building sources it contributes
Core/Src/logic_control/%.o Core/Src/logic_control/%.su Core/Src/logic_control/%.cyclo: ../Core/Src/logic_control/%.c Core/Src/logic_control/subdir.mk
	arm-none-eabi-gcc "$<" -mcpu=cortex-m4 -std=gnu11 -DUSE_HAL_DRIVER -DSTM32F411xE -c -I../Core/Inc -I../Drivers/STM32F4xx_HAL_Driver/Inc -I../Drivers/STM32F4xx_HAL_Driver/Inc/Legacy -I../Drivers/CMSIS/Device/ST/STM32F4xx/Include -I../Drivers/CMSIS/Include -Os -ffunction-sections -fdata-sections -Wall -fstack-usage -fcyclomatic-complexity -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" --specs=nano.specs -mfpu=fpv4-sp-d16 -mfloat-abi=hard -mthumb -o "$@"

clean: clean-Core-2f-Src-2f-logic_control

clean-Core-2f-Src-2f-logic_control:
	-$(RM) ./Core/Src/logic_control/pid.cyclo ./Core/Src/logic_control/pid.d ./Core/Src/logic_control/pid.o ./Core/Src/logic_control/pid.su ./Core/Src/logic_control/reflow_oven_process.cyclo ./Core/Src/logic_control/reflow_oven_process.d ./Core/Src/logic_control/reflow_oven_process.o ./Core/Src/logic_control/reflow_oven_process.su

.PHONY: clean-Core-2f-Src-2f-logic_control

