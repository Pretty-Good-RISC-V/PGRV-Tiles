cmake_minimum_required(VERSION 3.22)

project(PGRV_Tiles)

#
# CMAKE_MODULE_PATH
#
list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake")

add_subdirectory(src)
