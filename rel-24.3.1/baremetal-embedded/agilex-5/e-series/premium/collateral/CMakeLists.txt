cmake_minimum_required(VERSION 3.5...3.28)

# disable building tests
set(BUILD_TESTS OFF)

# library dir
get_filename_component(LIBRARY_DIR "../baremetal-drivers" ABSOLUTE)

# library project
add_subdirectory(${LIBRARY_DIR} alterametal)

# linker script
set(ALTERAMETAL_LINKER_SCRIPT "${LIBRARY_DIR}/build/aarch64/core0.ld")

# project
project(bm_hello_world C CXX ASM)

# target
add_executable(hello_world.elf)

# sources
target_sources(hello_world.elf
    PRIVATE
        hello_world.c
)

# link to the baremetal library
target_link_libraries(hello_world.elf PRIVATE
    alterametal
)

# specify linker script
target_link_options(hello_world.elf PRIVATE
    -T${ALTERAMETAL_LINKER_SCRIPT}
)