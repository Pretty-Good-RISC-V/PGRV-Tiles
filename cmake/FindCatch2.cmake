include(FetchContent)

set(CATCH_BUILD_STATIC_LIBRARY CACHE INTERNAL "" ON)

set(CATCH_VERSION "3.0.1")
string(REPLACE "." "_" CATCH_VERSION_UNDERSCORES ${CATCH_VERSION})
set(CATCH_FETCH_PROJECT_NAME "Catch2_${CATCH_VERSION_UNDERSCORES}")

FetchContent_Declare(
    ${CATCH_FETCH_PROJECT_NAME}
    GIT_REPOSITORY https://github.com/catchorg/Catch2.git
    GIT_TAG        "v${CATCH_VERSION}"
)

message("Ensuring Catch2 (v${CATCH_VERSION}) is available")
FetchContent_MakeAvailable(${CATCH_FETCH_PROJECT_NAME})
message("Ensuring Catch2 (v${CATCH_VERSION}) is available...complete")

list(APPEND CMAKE_MODULE_PATH "${catch2_${CATCH_VERSION_UNDERSCORES}_SOURCE_DIR}/extras") # so include(Catch) works
