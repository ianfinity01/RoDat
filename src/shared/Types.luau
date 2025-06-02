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

    char = require(TypesF.Strings.char)
}


return types