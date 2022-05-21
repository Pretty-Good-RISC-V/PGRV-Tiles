import GetPut::*;
import ClientServer::*;

/*
    TileLink Operation Categories
        Accesses (A)  - read and/or write the data at the specified address
        Hints (H)     - are informational only and have no direct effects
        Transfers (T) - move permissions or cached copies of data through the network.

    TileLine Operations

    Operation       Type        TL-UL   TL-UH   TL-C    Purpose
    -----------------------------------------------------------
    Get             A           Y       Y       Y       Read from and address range
    Put             A           Y       Y       Y       Write to an address range
    Atomic          A                   Y       Y       Read-modify-write an address range
    Intent          H                   Y       Y       Advance notification of likely future operations
    Acquire         T                           Y       Cache a copy of an address range or increase permissions of that copy
    Release         T                           Y       Write-back a cached copy of an address range or relinquish permissions to a cached copy
*/

// ChannelAOpcodes - Requests (responses on Channel D)
typedef Bit#(3) ChannelAOpcode;
ChannelAOpcode a_PUT_FULL_DATA     = 3'h0; // Put      - Response: D_ACCESS_ACK
ChannelAOpcode a_PUT_PARTIAL_DATA  = 3'h1; // Put      - Response: D_ACCESS_ACK
ChannelAOpcode a_ARITHMETIC_DATA   = 3'h2; // Atomic   - Response: D_ACCESS_ACK_DATA
ChannelAOpcode a_LOGICAL_DATA      = 3'h3; // Atomic   - Response: D_ACCESS_ACK_DATA
ChannelAOpcode a_GET               = 3'h4; // Get      - Response: D_ACCESS_ACK_DATA
ChannelAOpcode a_INTENT            = 3'h5; // Intent   - Response: D_HINT_ACK
ChannelAOpcode a_ACQUIRE_BLOCK     = 3'h6; // Acquire  - Response: D_GRANT, D_GRANT_DATA
ChannelAOpcode a_ACQUIRE_PERM      = 3'h7; // Acquire  - Response: D_GRANT

// ChannelDOpcodes - Responses (requests on Channel A)
typedef Bit#(3) ChannelDOpcode;
ChannelDOpcode d_ACCESS_ACK        = 3'h0; // Put
ChannelDOpcode d_ACCESS_ACK_DATA   = 3'h1; // Get or Atomic
ChannelDOpcode d_HINT_ACK          = 3'h2; // Intent
ChannelDOpcode d_GRANT             = 3'h4; // Acquire
ChannelDOpcode d_GRANT_DATA        = 3'h5; // Acquire
ChannelDOpcode d_RELEASE_ACK       = 3'h6; // Release

typedef struct {
    ChannelAOpcode a_opcode;
    Bit#(3) a_param;
    Bit#(z) a_size;             // z = log2 number of bits required for transfer size
    Bit#(o) a_source;           // o = number of bits to identify source
    Bit#(a) a_address;          // a = number of address bits
    Bit#(w) a_mask;             // w = number of bytes in the mask
    Bit#(TMul#(w, 8)) a_data;
    Bool a_corrupt;             // The data in this beat is corrupt.

    // The below are part of the TileLink spec but are automatically provided by BlueSpec.
    // Bit#(1) a_valid
    // Bit#(1) a_ready
} TileLinkChannelARequest#(numeric type z, numeric type o, numeric type a, numeric type w) deriving(Bits, Eq, FShow);

typedef struct {
    ChannelDOpcode d_opcode;
    Bit#(2) d_param;
    Bit#(z) d_size;             // z = log2 number of bits required for transfer size
    Bit#(o) d_source;           // o = number of bits to identify source
    Bit#(i) d_sink;             // i = number of bits to identify sink
    Bool d_denied;
    Bit#(TMul#(w, 8)) d_data;
    Bool d_corrupt;

    // The below are part of the TileLink spec but are automatically provided by BlueSpec.
    // Bit#(1) d_valid
    // Bit#(1) d_ready
} TileLinkChannelDResponse#(numeric type z, numeric type o, numeric type i, numeric type w) deriving(Bits, Eq, FShow);

//
// Requests/Responses
//
typedef TileLinkChannelARequest#(TLog#(TDiv#(word_bit_size, 8)), source_bit_size, word_bit_size, TDiv#(word_bit_size, 8)) TileLinkLiteWordRequest#(numeric type source_bit_size, numeric type word_bit_size);
typedef TileLinkChannelDResponse#(TLog#(TDiv#(word_bit_size, 8)), source_bit_size, sink_bit_size, TDiv#(word_bit_size, 8)) TileLinkLiteWordResponse#(numeric type source_bit_size, numeric type sink_bit_size, numeric type word_bit_size);

//
// Client/Server
//
typedef Client#(TileLinkLiteWordRequest#(source_bit_size, word_bit_size), TileLinkLiteWordResponse#(source_bit_size, sink_bit_size, word_bit_size)) TileLinkLiteWordClient#(numeric type source_bit_size, numeric type sink_bit_size, numeric type word_bit_size);
typedef Server#(TileLinkLiteWordRequest#(source_bit_size, word_bit_size), TileLinkLiteWordResponse#(source_bit_size, sink_bit_size, word_bit_size)) TileLinkLiteWordServer#(numeric type source_bit_size, numeric type sink_bit_size, numeric type word_bit_size);
