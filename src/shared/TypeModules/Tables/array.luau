--!strict
local Package = script.Parent.Parent.Parent
local Serializer = require(Package.Serializer)

export type TypeObject<T> = Serializer.TypeObject<{T}> & {len: number, type: Serializer.TypeObject<T>}

local name = "array"

Serializer:_registerType(name, function<T>(self: TypeObject<T>, buf: buffer, offset: number): ({T}, number)
    local ret = {}
    for i = 1, self.len do
        ret[i], offset = Serializer:Read(self.type, buf, offset)
    end
    return ret, offset
end, function<T>(self: TypeObject<T>, buf: buffer, offset: number, val: {T}): number
    for i = 1, self.len do
        offset = Serializer:Write(self.type, val[i], buf, offset)
    end
    return offset
end, function<T>(self: TypeObject<T>, val: {T}): number
    local ret = 0
    for i = 1, self.len do
        ret += Serializer:Length(self.type, val[i])
    end
    return ret
end, function<T>(self: TypeObject<T>, val: {T}): boolean
    if typeof(val) ~= "table" then
        return false
    end

    for i, v in val do
        if typeof(i) ~= "number" or i % 1 ~= 0 or i < 1 or i > self.len then
            return false
        end

        if not Serializer:Validate(self.type, v) then
            return false
        end
    end

    if not Serializer:Validate(self.type, nil) and #val ~= self.len then
        return false
    end

    return true
end)

return function<T>(len: number, otherType: Serializer.TypeObject<T>)
    assert(typeof(len) == "number" and len % 1 == 0 and len >= 0, "Length of the array type must be a positive integer")
    assert(typeof(otherType) == "table" and otherType._name, "An type must be specified for an array")

    return setmetatable({
        _name = name,
        len = len,
        type = otherType
    }, {
        __tostring = function(obj: TypeObject<T>)
            return `{obj._name}({obj.len}, {obj.type})`
        end
    }) :: TypeObject<T>
end