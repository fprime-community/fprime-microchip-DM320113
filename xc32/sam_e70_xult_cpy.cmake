# sam_e70_xult.cmake

# Define the target platform
set(FPRIME_PLATFORM "sam_e70_xult")

# Set the processor type
set(CMAKE_SYSTEM_PROCESSOR cortex-m7)

# Set the compiler flags
set(CMAKE_C_FLAGS_INIT "-mprocessor=ATSAME70Q21B -D__SAME70Q21B__ -isystem ${XC32_DIR}/include -isystem /opt/microchip/mplabx/v6.20/packs/Microchip/SAME70_DFP/4.10.248/same70b/xc32/include -isystem /opt/microchip/mplabx/v6.20/packs/Microchip/SAME70_DFP/4.10.248/same70b/include_mcc -isystem /opt/microchip/mplabx/v6.20/packs/Microchip/SAME70_DFP/4.10.248/same70b/include")
set(CMAKE_EXE_LINKER_FLAGS_INIT "-specs=/opt/microchip/mplabx/v6.20/packs/Microchip/SAME70_DFP/4.10.248/same70b/xc32/ATSAME70Q21B/specs-ATSAME70Q21B -Wl,--defsym,_min_heap_size=0x2000")

# Prevent CMake from adding its own -mcpu and -mthumb flags
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS_INIT}" CACHE STRING "Initial C FLAGS" FORCE)
set(CMAKE_CXX_FLAGS "${CMAKE_C_FLAGS_INIT}" CACHE STRING "Initial CXX FLAGS" FORCE)
set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS_INIT}" CACHE STRING "Initial EXE LINKER FLAGS" FORCE)

# Add PlatformTypes.h
include_directories(SYSTEM "${CMAKE_CURRENT_LIST_DIR}/types")

# Remove POSIX
set(FPRIME_USE_POSIX OFF)

# Define the operating system type for embedded platform
add_definitions(-DFW_BAREMETAL_SCHEDULER=1)

# Specify the OS type include directive
add_definitions(-DTGT_OS_TYPE_BAREMETAL)
