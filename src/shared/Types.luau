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
    
    buffer = require(TypesF.Buffers.buffer),
    dynamicBuffer = require(TypesF.Buffers.dynamicBuffer),

    BrickColor = require(TypesF.Roblox.BrickColor),
    Vector2 = require(TypesF.Roblox.Vector2),
    Vector3 = require(TypesF.Roblox.Vector3),
    Color3 = require(TypesF.Roblox.Color3),
    lossyColor3 = require(TypesF.Roblox.lossyColor3),
    UDim = require(TypesF.Roblox.UDim),
    UDim2 = require(TypesF.Roblox.UDim2),
    CFrame = require(TypesF.Roblox.CFrame),
    lossyCFrame = require(TypesF.Roblox.lossyCFrame),
    robloxEnum = require(TypesF.Roblox.robloxEnum),

    boolean = require(TypesF.Booleans.boolean),
    bool = require(TypesF.Booleans.boolean),
    bitField = require(TypesF.Booleans.bitField),
    boolField = require(TypesF.Booleans.bitField)
}


return types