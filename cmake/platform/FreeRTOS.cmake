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
set(FW_ENABLE_TEXT_LOGGING 0 CACHE BOOL "Disable text logging")

include_directories(SYSTEM "${FREERTOS_INCLUDE_DIR}")

# Test
include_directories(SYSTEM "${CMAKE_CURRENT_LIST_DIR}/../../Os/freeRTOS")
include_directories(SYSTEM "${CMAKE_CURRENT_LIST_DIR}/FreeRTOS/Source/portable/GCC/SAM/CM7")
include_directories(SYSTEM "${CMAKE_CURRENT_LIST_DIR}/FreeRTOS/Source/portable/MemMang")

# Optionally, include other FreeRTOS configuration headers if required
# set(FREERTOS_CONFIG_DIR "${CMAKE_CURRENT_LIST_DIR}/FreeRTOSConfig")
# if(NOT EXISTS "${FREERTOS_CONFIG_DIR}")
#     message(FATAL_ERROR "FreeRTOS configuration directory not found at ${FREERTOS_CONFIG_DIR}.")
# endif()
# include_directories(SYSTEM "${FREERTOS_CONFIG_DIR}")

# Add any additional platform-specific settings or libraries as needed
# link_directories(${CMAKE_CURRENT_LIST_DIR}/FreeRTOS/lib)

# Add PlatformTypes.h
include_directories(SYSTEM "${CMAKE_CURRENT_LIST_DIR}/types")

# Choose FreeRTOS specific implementations for Os/File and Os/Task
# choose_fprime_implementation(Os/File Os/File/Stub)
choose_fprime_implementation(Os/Task Os/freeRTOS/Task)

# Remove default Queue.hpp and replace with FreeRTOS-specific Queue.hpp
if (FPRIME_USE_FREERTOS_SCHEDULER)
    foreach (ITER_ITEM IN LISTS SOURCE_FILES)
        if (ITER_ITEM MATCHES "(InterruptLock|Mutex|Queue|Task|TaskId)\\.cpp$")
            list(REMOVE_ITEM SOURCE_FILES "${ITER_ITEM}")
        endif()
        if (ITER_ITEM MATCHES "Queue\\.hpp$")
            list(REMOVE_ITEM SOURCE_FILES "${ITER_ITEM}")
        endif()
    endforeach()
endif()
