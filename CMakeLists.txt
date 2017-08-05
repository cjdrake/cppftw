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
# limitations under the License.cmake_minimum_required(VERSION 3.8.2)

cmake_minimum_required(VERSION 3.2.2)

# C++ For the Win
project(cppftw)

# Project variables
set(VERSION 0.1)

# Project options
option(ENABLE_TESTING "Enable testing" OFF)

# Configure cppftw build
file(GLOB_RECURSE srcs "src/*.cc")
add_library(cppftw ${srcs})
target_include_directories(cppftw PUBLIC include)
# C++ compiler options:
#     -std=c++11    Use the 2011 ISO C++ standard
#     -Wall         Enable all warnings
#     -Werror       Make all warnings into errors (Clang & GCC)
if (${CMAKE_CXX_COMPILER_ID} STREQUAL Clang)
    target_compile_options(cppftw PUBLIC -std=c++11 -Wall -Werror)
elseif (${CMAKE_CXX_COMPILER_ID} STREQUAL GNU)
    target_compile_options(cppftw PUBLIC -std=c++11 -Wall -Werror)
elseif (${CMAKE_CXX_COMPILER_ID} STREQUAL MSVC)
    target_compile_options(cppftw PUBLIC /std:c++11 /Wall)
else ()
    message(FATAL_ERROR "Expected compiler to be Clang, GCC, or MS Visual Studio")
endif ()

if (ENABLE_TESTING)
    enable_testing()

    # Include Google Test (https://github.com/google/googletest),
    # a high quality, popular C++ unit test framework.
    add_subdirectory(third_party/googletest)
    # Customize Google Test compile/link options.
    # Without this, you will get link errors on Windows.
    config_compiler_and_linker()

    # Include cppftw unit tests
    add_subdirectory(test)
endif (ENABLE_TESTING)
