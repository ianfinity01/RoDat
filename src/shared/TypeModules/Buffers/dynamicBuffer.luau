--!strict
local Package = script.Parent.Parent.Parent
local Serializer = require(Package.Serializer)
local smartUInt = require(Package.TypeModules.Numbers.smartUInt)

local Type = {}

export type TypeObject = Serializer.TypeObject<buffer>

Type._name = "dynamicBuffer"

Serializer:_registerType(Type._name, function(self, buf: buffer, offset: number)
    local len, offset = Serializer:Read(smartUInt, buf, offset)
    local ret = buffer.create(len)
    buffer.copy(ret, 0, buf, offset, len)
    return ret, offset + len
end, function(self, buf: buffer, offset: number, val: buffer)
    local len = buffer.len(val)
    offset = Serializer:Write(smartUInt, len, buf, offset)
    buffer.copy(buf, offset, val, 0, len)
    return offset + len
end, function(self, val: buffer)
    local len = buffer.len(val)
    return Serializer:Length(smartUInt, len) + len
end, function(self, val: buffer)
    return typeof(val) == "buffer"
end)

setmetatable(Type, {
    __tostring = function(self)
        return self._name
    end
})

return function()
    return Type :: TypeObject
end