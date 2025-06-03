--!strict
local Package = script.Parent.Parent.Parent
local Serializer = require(Package.Serializer)

local Type = {}

export type TypeModule = typeof(Type)
export type TypeObject = Serializer.TypeObject<string> & {len: number}

local name = "fixedStr"

Serializer:_registerType(name, function(self: TypeObject, buf: buffer, offset: number)
    local len = self.len
    return buffer.readstring(buf, offset, len), offset + len
end, function(self: TypeObject, buf: buffer, offset: number, val: string)
    local len = self.len
    buffer.writestring(buf, offset, val, len)
    return offset + len
end, function(self: TypeObject, val: string)
    return self.len
end, function(self, val: string)
    return typeof(val) == "string" and val:len() == self.len
end)

setmetatable(Type, {
    __call = function(self, len: number)
        assert(typeof(len) == "number" and len % 1 == 0 and len >= 0, "Length of the fixedString type must be a positive integer")

        return setmetatable({
            _name = name,
            len = len
        }, {
            __tostring = function(obj: TypeObject)
                return `{obj._name}({obj.len})`
            end
        })
    end
})

return Type