--!strict
local Package = script.Parent.Parent.Parent
local Serializer = require(Package.Serializer)

export type TypeObject = Serializer.TypeObject<buffer>

local name = "buffer"

Serializer:_registerType(name, function(self: TypeObject, buf: buffer, offset: number)
    local len = self.len
    local ret = buffer.create(len)
    buffer.copy(ret, 0, buf, offset, len)
    return ret, offset + len
end, function(self: TypeObject, buf: buffer, offset: number, val: buffer)
    local len = self.len
    buffer.copy(buf, offset, val, 0, len)
    return offset + len
end, function(self: TypeObject, val: buffer)
    return self.len
end, function(self, val: buffer)
    return typeof(val) == "buffer" and buffer.len(val) == self.len
end)

return function(len: number)
    assert(typeof(len) == "number" and len % 1 == 0 and len >= 0, "Length of the buffer type must be a positive integer")

    return setmetatable({
        _name = name,
        len = len
    }, {
        __tostring = function(obj: TypeObject)
            return `{obj._name}({obj.len})`
        end
    }) :: TypeObject
end