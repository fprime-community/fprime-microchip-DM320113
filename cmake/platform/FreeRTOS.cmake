# Specify the OS type include directive
add_definitions(-DTGT_OS_TYPE_FREERTOS)

# Specify that a thread package should be searched in the toolchain directory
if (NOT DEFINED FPRIME_USE_FREERTOS_SCHEDULER)
    set(FPRIME_USE_FREERTOS_SCHEDULER ON)
    # message(STATUS "Requiring thread library")
    # FIND_PACKAGE ( Threads REQUIRED )
endif()

# Specify a directory containing the "PlatformTypes.hpp" headers, as well as other system headers
set(FREERTOS_INCLUDE_DIR "${CMAKE_CURRENT_LIST_DIR}/FreeRTOS/Source/include")
if(NOT EXISTS "${FREERTOS_INCLUDE_DIR}")
    message(FATAL_ERROR "FreeRTOS include directory not found at ${FREERTOS_INCLUDE_DIR}.")
endif()

# Disable Text Logging
# set(FW_ENABLE_TEXT_LOGGING 0 CACHE BOOL "Disable text logging")

include_directories(SYSTEM "${FREERTOS_INCLUDE_DIR}")

# Test
include_directories(SYSTEM "${CMAKE_CURRENT_LIST_DIR}/../../Os/freeRTOS")
include_directories(SYSTEM "${CMAKE_CURRENT_LIST_DIR}/FreeRTOS/Source/portable/GCC/SAM/CM7")
include_directories(SYSTEM "${CMAKE_CURRENT_LIST_DIR}/FreeRTOS/Source/portable/MemMang")

# Add any additional platform-specific settings or libraries as needed
link_directories(${CMAKE_CURRENT_LIST_DIR}/FreeRTOS/lib)

# Add PlatformTypes.h
include_directories(SYSTEM "${CMAKE_CURRENT_LIST_DIR}/types")
add_subdirectory("${CMAKE_CURRENT_LIST_DIR}/FreeRTOS/Source")

