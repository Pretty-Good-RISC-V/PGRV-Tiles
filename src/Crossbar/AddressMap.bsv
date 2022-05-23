import PGRV::*;

typedef Bit#(sz) TileId#(numeric type sz);
typedef Bit#(sz) FabricAddress#(numeric type sz);

interface AddressMap#(numeric type idBits, numeric type addrBits);
    (* always_ready *) method TileId#(idBits) crossbarId;

    (* always_ready *) method FabricAddress#(adddrBits) clintBase;
    (* always_ready *) method FabricAddress#(adddrBits) clintSize;
    (* always_ready *) method FabricAddress#(adddrBits) clintEnd;
    (* always_ready *) method TileId#(idBits) clintId;

    (* always_ready *) method FabricAddress#(adddrBits) uart0Base;
    (* always_ready *) method FabricAddress#(adddrBits) uart0Size;
    (* always_ready *) method FabricAddress#(adddrBits) uart0End;
    (* always_ready *) method TileId#(idBits) uart0Id;

    (* always_ready *) method FabricAddress#(adddrBits) rom0Base;
    (* always_ready *) method FabricAddress#(adddrBits) rom0Size;
    (* always_ready *) method FabricAddress#(adddrBits) rom0End;
    (* always_ready *) method TileId#(idBits) rom0Id;

    (* always_ready *) method FabricAddress#(adddrBits) ram0Base;
    (* always_ready *) method FabricAddress#(adddrBits) ram0Size;
    (* always_ready *) method FabricAddress#(adddrBits) ram0End;
    (* always_ready *) method TileId#(idBits) ram0Id;
endinterface
