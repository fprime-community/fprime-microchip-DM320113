# xc32_toolchain.cmake

set(CMAKE_SYSTEM_NAME "stm32")
set(CMAKE_SYSTEM_PROCESSOR cortex-m7)
# Specify that a thread package should be searched in the toolchain directory
set(FPRIME_USE_BAREMETAL_SCHEDULER ON)

# Specify the cross compiler
set(XC32_DIR /opt/microchip/xc32/v4.40)
set(CMAKE_C_COMPILER ${XC32_DIR}/bin/xc32-gcc)
set(CMAKE_CXX_COMPILER ${XC32_DIR}/bin/xc32-g++)

# Include the platform configuration
include("${CMAKE_CURRENT_LIST_DIR}/../platform/sam_e70_xult.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/xc32_custom.cmake")

# Path to root of toolchain package
set(CMAKE_FIND_ROOT_PATH /opt/microchip/xc32/v4.40)

# DO NOT EDIT
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)

set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)

# Toolchain Specific
set(BUILD_FW_DP OFF CACHE BOOL "Build Fw/Dp components")
