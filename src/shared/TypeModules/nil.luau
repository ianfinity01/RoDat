--!strict
local Package = script.Parent.Parent
local Serializer = require(Package.Serializer)

local Type = {}

export type TypeObject = Serializer.TypeObject<nil>

Type._name = "nil"

Serializer:_registerType(Type._name, function(self, buf: buffer, offset: number)
    return nil, offset
end, function(self, buf: buffer, offset: number, val: nil)
    return offset
end, function(self, val: nil)
    return 0
end, function(self, val: nil)
    return val == nil
end)

setmetatable(Type, {
    __tostring = function(self)
        return self._name
    end
})

return function()
    return Type :: TypeObject
end