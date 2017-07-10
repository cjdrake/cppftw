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

cmake_minimum_required(VERSION 3.9)

project(cppftw)

set(VERSION 0.1)

enable_testing()

file(GLOB_RECURSE srcs "src/*.cc")

add_library(cppftw ${srcs})
target_include_directories(cppftw PUBLIC include)
target_compile_options(cppftw PUBLIC -std=c++11 -Wall)

add_subdirectory(third_party/googletest)
add_subdirectory(test)
