#include "ProgramMemory.hpp"
#include "catch2/catch_all.hpp"

TEST_CASE("ProgramMemory C++ library") {
    ::setenv("PROGRAM_MEMORY_FILE", "./test_assets/rv32mi-p-csr", 1);
    auto handle = program_memory_open();
    REQUIRE(handle != 0);

    address_t addr = 0x80000000;
    REQUIRE(program_memory_read_u32(handle, addr) == 0x04c0006f);

    addr += 4;
    REQUIRE(program_memory_read_u32(handle, addr) == 0x34202f73);

    addr = 0x8000004c;
    REQUIRE(program_memory_read_u32(handle, addr) == 0x00000093);

    addr = 0x800000c8;
    REQUIRE(program_memory_read_u32(handle, addr) == 0xf1402573);

    addr = 0x800000c8;
    REQUIRE(program_memory_read_u8(handle, addr) == 0x73);

    addr = 0x800000d0;
    program_memory_write_u32(handle, addr, addr);
    addr += 4;

    program_memory_write_u32(handle, addr, addr);
    addr += 4;

    program_memory_write_u32(handle, addr, addr);
    addr += 4;

    program_memory_write_u32(handle, addr, addr);
    addr += 4;

    addr = 0x800000d0;
    REQUIRE(program_memory_read_u32(handle, addr) == addr);
    addr += 4;

    REQUIRE(program_memory_read_u32(handle, addr) == addr);
    addr += 4;

    REQUIRE(program_memory_read_u32(handle, addr) == addr);
    addr += 4;

    REQUIRE(program_memory_read_u32(handle, addr) == addr);
    addr += 4;

    program_memory_close(handle);
}
