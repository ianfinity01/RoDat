--!strict
local Package = script.Parent.Parent
local Serializer = require(Package.Serializer)

local Type = {}
local name = "optional"

export type TypeModule = typeof(Type)
export type TypeObject = Serializer.TypeObject & {type: Serializer.TypeObject}

Serializer:_registerType(name, function(self: TypeObject, buf: buffer, offset: number)
    if buffer.readu8(buf, offset) == 1 then
        return nil, offset + 1
    end
    return Serializer:Read(self.type, buf, offset + 1)
end, function(self: TypeObject, buf: buffer, offset: number, val: any?)
    if val == nil then
        buffer.writeu8(buf, offset, 1)
        return offset + 1
    end
    buffer.writeu8(buf, offset, 0)
    return Serializer:Write(self.type, val, buf, offset + 1)
end, function(self: TypeObject, val: any?)
    if val == nil then
        return 1
    end
    return 1 + Serializer:Length(self.type, val)
end, function(self: TypeObject, val: any?)
    return val == nil or Serializer:Validate(self.type, val)
end)

setmetatable(Type, {
    __call = function(self, otherType: Serializer.TypeObject)
        assert(typeof(otherType) == "table" and otherType.name, "An type must be specified for the optional")
        return setmetatable({
            name = name,
            type = otherType
        }, {
            __tostring = function(obj: TypeObject)
                return `{name}({obj.type})`
            end
        })
    end
})

return Type :: TypeModule