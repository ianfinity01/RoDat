--!strict
local Package = script.Parent.Parent.Parent
local Serializer = require(Package.Serializer)
local udim = require(Package.TypeModules.Roblox.UDim)

local Type = {}

export type TypeObject = Serializer.TypeObject<UDim2>

Type._name = "UDim2"

Serializer:_registerType(Type._name, function(self, buf: buffer, offset: number)
    local x, offset = Serializer:Read(udim, buf, offset)
    local y, offset = Serializer:Read(udim, buf, offset)
    return UDim2.new(x, y), offset
end, function(self, buf: buffer, offset: number, val: UDim2)
    offset = Serializer:Write(udim, val.X, buf, offset)
    offset = Serializer:Write(udim, val.Y, buf, offset)
    return offset
end, function(self, val: UDim2)
    return 16
end, function(self, val: UDim2)
    return typeof(val) == "UDim2"
end)

setmetatable(Type, {
    __tostring = function(self)
        return self._name
    end
})

return function ()
    return Type :: TypeObject
end