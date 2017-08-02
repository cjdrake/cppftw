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
target_compile_options(cppftw PUBLIC -std=c++11 -Wall)

if (ENABLE_TESTING)
    enable_testing()

    add_subdirectory(third_party/googletest)
    # Customize Google Test compile/link options
    config_compiler_and_linker()

    add_subdirectory(test)
endif (ENABLE_TESTING)
