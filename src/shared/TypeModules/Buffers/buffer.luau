--!strict
local Package = script.Parent.Parent.Parent
local Serializer = require(Package.Serializer)

local Type = {}

export type TypeModule = typeof(Type)
export type TypeObject = Serializer.TypeObject & {len: number}

Type.name = "buffer"

Serializer:_registerType(Type.name, function(self, buf: buffer, offset: number)
    local len = (self :: TypeObject).len
    local ret = buffer.create(len)
    buffer.copy(ret, 0, buf, offset, len)
    return ret, offset + len
end, function(self, buf: buffer, offset: number, val: buffer)
    local len = (self :: TypeObject).len
    buffer.copy(buf, offset, val, 0, len)
    return offset + len
end, function(self, val: buffer)
    return (self :: TypeObject).len
end, function(self, val: buffer)
    return typeof(val) == "buffer" and buffer.len(val) == (self :: TypeObject).len
end)

setmetatable(Type, {
    __call = function(self, len: number)
        assert(typeof(len) == "number" and len % 1 == 0 and len >= 0, "Length of the buffer type must be a positive integer")

        return {
            name = self.name,
            len = len
        }
    end
})

return Type :: TypeModule