--!strict
local TypesF = script.Parent.TypeModules

local types = {
    i8 = require(TypesF.Numbers.i8),
    u8 = require(TypesF.Numbers.u8),
    i16 = require(TypesF.Numbers.i16),
    u16 = require(TypesF.Numbers.u16),
    i32 = require(TypesF.Numbers.i32),
    u32 = require(TypesF.Numbers.u32),
    f32 = require(TypesF.Numbers.f32),
    float = require(TypesF.Numbers.f32),
    f64 = require(TypesF.Numbers.f64),
    number = require(TypesF.Numbers.f64),
    double = require(TypesF.Numbers.f64),
    byte = require(TypesF.Numbers.i8),
    short = require(TypesF.Numbers.i16),
    int = require(TypesF.Numbers.i32),

    smartInt = require(TypesF.Numbers.smartInt),
    smartUInt = require(TypesF.Numbers.smartUInt),
    smartUnsignedInt = require(TypesF.Numbers.smartUInt),

    char = require(TypesF.Strings.char),
    shortStr = require(TypesF.Strings.shortStr),
    mediumStr = require(TypesF.Strings.mediumStr),
    
    buffer = require(TypesF.Buffers.buffer)
}


return types