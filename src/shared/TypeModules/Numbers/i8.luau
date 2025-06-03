--!strict
local Package = script.Parent.Parent.Parent
local Serializer = require(Package.Serializer)

local Type = {}

export type TypeModule = typeof(Type) & Serializer.TypeObject

Type.name = "i8"

Serializer:_registerType(Type.name, function(self, buf: buffer, offset: number)
    return buffer.readi8(buf, offset), offset + 1
end, function(self, buf: buffer, offset: number, val: number)
    buffer.writei8(buf, offset, val)
    return offset + 1
end, function(self, val: number)
    return 1
end, function(self, val: number)
    return typeof(val) == "number" and val < 128 and val >= -128 and val % 1 == 0
end)

setmetatable(Type, {
    __call = function(self)
        return self
    end,
    __tostring = function(self)
        return self.name
    end
})

return Type :: TypeModule