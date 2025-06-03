--!strict
local Package = script.Parent.Parent.Parent
local Serializer = require(Package.Serializer)

local Type = {}

export type TypeObject = Serializer.TypeObject<number>

Type._name = "i8"

Serializer:_registerType(Type._name, function(self, buf: buffer, offset: number)
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
    __tostring = function(self)
        return self._name
    end
})

return function()
    return Type :: TypeObject
end