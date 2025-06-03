--!strict
local Package = script.Parent.Parent.Parent
local Serializer = require(Package.Serializer)

local Type = {}

export type TypeObject = Serializer.TypeObject<boolean>

Type._name = "boolean"

Serializer:_registerType(Type._name, function(self, buf: buffer, offset: number)
    return buffer.readu8(buf, offset) == 1, offset + 1
end, function(self, buf: buffer, offset: number, val: boolean)
    buffer.writeu8(buf, offset, if val then 1 else 0)
    return offset + 1
end, function(self, val: boolean)
    return 1
end, function(self, val: boolean)
    return typeof(val) == "boolean"
end)

setmetatable(Type, {
    __tostring = function(self)
        return self._name
    end
})

return function()
    return Type :: TypeObject
end