--!strict
local Package = script.Parent.Parent.Parent
local Serializer = require(Package.Serializer)

local Type = {}

export type TypeModule = typeof(Type) & Serializer.TypeObject

Type.name = "boolean"

Serializer:_registerType(Type.name, function(self, buf: buffer, offset: number)
    return buffer.readi8(buf, offset) == 1, offset + 1
end, function(self, buf: buffer, offset: number, val: boolean)
    buffer.writei8(buf, offset, if val then 1 else 0)
    return offset + 1
end, function(self, val: boolean)
    return 1
end, function(self, val: boolean)
    return typeof(val) == "boolean"
end)

setmetatable(Type, {
    __call = function(self)
        return self
    end
})

return Type :: TypeModule