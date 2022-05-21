include(FetchContent)

set(CATCH_BUILD_STATIC_LIBRARY ON)

FetchContent_Declare(
    Catch2
    GIT_REPOSITORY https://github.com/catchorg/Catch2.git
    GIT_TAG        "v2.13.9"
)

message("Ensuring Catch2 is available")
FetchContent_MakeAvailable(Catch2)
message("Ensuring Catch2 is available...complete")

list(APPEND CMAKE_MODULE_PATH "${catch2_SOURCE_DIR}/contrib") # so include(Catch) works
