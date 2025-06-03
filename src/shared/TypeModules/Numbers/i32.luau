--!strict
local Package = script.Parent.Parent.Parent
local Serializer = require(Package.Serializer)

local Type = {}

export type TypeModule = typeof(Type) & Serializer.TypeObject

Type.name = "i32"

Serializer:_registerType(Type.name, function(self, buf: buffer, offset: number)
    return buffer.readi32(buf, offset), offset + 4
end, function(self, buf: buffer, offset: number, val: number)
    buffer.writei32(buf, offset, val)
    return offset + 4
end, function(self, val: number)
    return 4
end, function(self, val: number)
    return typeof(val) == "number" and val < 2147483648 and val >= -2147483648 and val % 1 == 0
end)

setmetatable(Type, {
    __call = function(self)
        return self
    end
})

return Type :: TypeModule