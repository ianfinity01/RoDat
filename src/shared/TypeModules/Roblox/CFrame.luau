--!strict
local Package = script.Parent.Parent.Parent
local Serializer = require(Package.Serializer)

local Type = {}

export type TypeModule = typeof(Type) & Serializer.TypeObject<CFrame>

Type._name = "CFrame"

Serializer:_registerType(Type._name, function(self, buf: buffer, offset: number)
    return CFrame.new(
        buffer.readf32(buf, offset),
        buffer.readf32(buf, offset+4),
        buffer.readf32(buf, offset+8),
        buffer.readf32(buf, offset+12),
        buffer.readf32(buf, offset+16),
        buffer.readf32(buf, offset+20),
        buffer.readf32(buf, offset+24),
        buffer.readf32(buf, offset+28),
        buffer.readf32(buf, offset+32),
        buffer.readf32(buf, offset+36),
        buffer.readf32(buf, offset+40),
        buffer.readf32(buf, offset+44)
    ), offset + 48
end, function(self, buf: buffer, offset: number, val: CFrame)
    local a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12 = val:GetComponents()
    buffer.writef32(buf, offset, a1)
    buffer.writef32(buf, offset+4, a2)
    buffer.writef32(buf, offset+8, a3)
    buffer.writef32(buf, offset+12, a4)
    buffer.writef32(buf, offset+16, a5)
    buffer.writef32(buf, offset+20, a6)
    buffer.writef32(buf, offset+24, a7)
    buffer.writef32(buf, offset+28, a8)
    buffer.writef32(buf, offset+32, a9)
    buffer.writef32(buf, offset+36, a10)
    buffer.writef32(buf, offset+40, a11)
    buffer.writef32(buf, offset+44, a12)
    return offset + 48
end, function(self, val: CFrame)
    return 48
end, function(self, val: CFrame)
    return typeof(val) == "CFrame"
end)

setmetatable(Type, {
    __call = function(self)
        return self
    end,
    __tostring = function(self)
        return self._name
    end
})

return Type