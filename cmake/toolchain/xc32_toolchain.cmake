# xc32_toolchain.cmake

set(CMAKE_SYSTEM_NAME FreeRTOS)
set(CMAKE_SYSTEM_PROCESSOR cortex-m7)
set(FPRIME_PLATFORM "FreeRTOS")
# Specify that a thread package should be searched in the toolchain directory

# Specify the cross compiler
set(XC32_DIR /opt/microchip/xc32/v4.40)
set(CMAKE_C_COMPILER ${XC32_DIR}/bin/xc32-gcc)
set(CMAKE_CXX_COMPILER ${XC32_DIR}/bin/xc32-g++)

# Include the platform configuration
# include("${CMAKE_CURRENT_LIST_DIR}/sam_e70_xult.cmake")

# Path to root of toolchain package
set(CMAKE_FIND_ROOT_PATH /opt/microchip/xc32/v4.40)

# DO NOT EDIT
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)

set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)

# Toolchain Specific
set(BUILD_FW_DP OFF CACHE BOOL "Build Fw/Dp components")

# Set the compiler flags
set(CMAKE_C_FLAGS_INIT "-mprocessor=ATSAME70Q21B -D__SAME70Q21B__ -isystem ${XC32_DIR}/include -isystem /opt/microchip/mplabx/v6.20/packs/Microchip/SAME70_DFP/4.10.248/same70b/xc32/include -isystem /opt/microchip/mplabx/v6.20/packs/Microchip/SAME70_DFP/4.10.248/same70b/include_mcc -isystem /opt/microchip/mplabx/v6.20/packs/Microchip/SAME70_DFP/4.10.248/same70b/include")
set(CMAKE_EXE_LINKER_FLAGS_INIT "-specs=/opt/microchip/mplabx/v6.20/packs/Microchip/SAME70_DFP/4.10.248/same70b/xc32/ATSAME70Q21B/specs-ATSAME70Q21B -Wl,--defsym,_min_heap_size=0x2000") # heap size can be reset, this is a placeholder

# Prevent CMake from adding its own -mcpu and -mthumb flags which conflict with the specific flags required for the ATSAME70Q21B processor
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS_INIT}" CACHE STRING "Initial C FLAGS" FORCE)
set(CMAKE_CXX_FLAGS "${CMAKE_C_FLAGS_INIT}" CACHE STRING "Initial CXX FLAGS" FORCE)
set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS_INIT}" CACHE STRING "Initial EXE LINKER FLAGS" FORCE)

# Remove POSIX
set(FPRIME_USE_POSIX OFF)
