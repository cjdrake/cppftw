# Copyright 2017 Chris Drake
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

file(GLOB srcs "*.cc")
add_executable(cppftw_test ${srcs})
target_link_libraries(cppftw_test cppftw gtest)

# Enable code coverage
if (ENABLE_COVERAGE)
    if (NOT ${CMAKE_BUILD_TYPE} STREQUAL Debug)
        message(FATAL_ERROR "Coverage can only be enabled in Debug configuration")
    endif ()

    if (NOT ${CMAKE_CXX_COMPILER_ID} STREQUAL GNU)
        message(FATAL_ERROR "Coverage currently only works with GNU GCC")
    endif ()

    find_program(lcov_path lcov)
    if (NOT lcov_path)
        message(FATAL_ERROR "Could not find program: lcov")
    endif()

    find_program(genhtml_path genhtml)
    if (NOT genhtml_path)
        message(FATAL_ERROR "Could not find program: genhtml")
    endif()

    target_compile_options(cppftw PUBLIC --coverage -fprofile-arcs -ftest-coverage)
    target_link_libraries(cppftw_test gcov)

    add_custom_target(
        cover

        # Reset coverage counters
        COMMAND ${lcov_path} --directory . --zerocounters

        # Run unit test suite
        COMMAND cppftw_test

        # Capture lcov counters
        COMMAND ${lcov_path} -o coverage.info --capture --directory .
        # Remove unwanted code from coverage database
        COMMAND ${lcov_path} -o coverage.info --remove coverage.info '/usr/*' 'test/*' 'third_party/*'
        # Generate HTML report
        COMMAND ${genhtml_path} -o html coverage.info

        COMMENT "Coverage Report: ${CMAKE_BINARY_DIR}/html/index.html"

        DEPENDS cppftw_test
        WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
    )
endif (ENABLE_COVERAGE)

add_test(cppftw_test cppftw_test)
