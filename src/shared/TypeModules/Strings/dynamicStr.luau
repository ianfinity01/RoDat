--!strict
local Package = script.Parent.Parent.Parent
local Serializer = require(Package.Serializer)
local smartUInt = require(Package.TypeModules.Numbers.smartUInt)

local Type = {}

export type TypeObject = Serializer.TypeObject<string>

Type._name = "dynamicStr"

Serializer:_registerType(Type._name, function(self, buf: buffer, offset: number)
    local len, offset = Serializer:Read(smartUInt, buf, offset)
    return buffer.readstring(buf, offset, len), offset + len
end, function(self, buf: buffer, offset: number, val: string)
    local len = val:len()
    offset = Serializer:Write(smartUInt, len, buf, offset)
    buffer.writestring(buf, offset, val, len)
    return offset + len
end, function(self, val: string)
    return Serializer:Length(smartUInt, val:len()) + val:len()
end, function(self, val: string)
    return typeof(val) == "string"
end)

setmetatable(Type, {
    __call = function(self)
        return self
    end,
    __tostring = function(self)
        return self._name
    end
})

return function ()
    return Type :: TypeObject
end