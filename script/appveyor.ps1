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

# Execute test suite on AppVeyor

# Print environment variables (for debug)
Get-ChildItem Env:

# Generate build files
mkdir build
cd build
cmake -DCMAKE_BUILD_TYPE=Debug -DENABLE_TESTING=ON ..

# Build all targets
cmake --build .

# Execute unit tests
ctest
