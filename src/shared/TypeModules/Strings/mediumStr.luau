--!strict
local Package = script.Parent.Parent.Parent
local Serializer = require(Package.Serializer)

local Type = {}

export type TypeObject = Serializer.TypeObject<string>

Type._name = "mediumStr"

Serializer:_registerType(Type._name, function(self, buf: buffer, offset: number)
    local len = buffer.readu16(buf, offset)
    return buffer.readstring(buf, offset + 2, len), offset + 2 + len
end, function(self, buf: buffer, offset: number, val: string)
    local len = val:len()
    buffer.writeu16(buf, offset, len)
    buffer.writestring(buf, offset + 2, val)
    return offset + 2 + len
end, function(self, val: string)
    return 2 + val:len()
end, function(self, val: string)
    return typeof(val) == "string" and val:len() < 65536
end)

setmetatable(Type, {
    __tostring = function(self)
        return self._name
    end
})

return function ()
    return Type :: TypeObject
end