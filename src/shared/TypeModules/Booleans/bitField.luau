--!strict
local Package = script.Parent.Parent.Parent
local Serializer = require(Package.Serializer)

local Type = {}

export type TypeModule = typeof(Type)
export type TypeObject = Serializer.TypeObject<{boolean}> & {len: number}

local name = "bitField"

Serializer:_registerType(name, function(self, buf: buffer, offset: number)
    local len = self.len
    local ret = {}

    for i = 1, math.ceil(len/8) do
        local num = buffer.readu8(buf, offset + i-1)
        for j = 1, math.min(len - (i-1)*8, 8) do
            local ind = (i - 1) * 8 + j
            ret[ind] = num % 2 == 1
            num = math.floor(num/2)
        end
    end

    return ret, offset + math.ceil(len/8)
end, function(self: TypeObject, buf: buffer, offset: number, val: {boolean})
    local len = self.len
    
    for i = 1, math.ceil(len/8) do
        local num = 0
        for j = 1, math.min(len - (i-1)*8, 8) do
            local ind = (i - 1) * 8 + j
            if val[ind] then
                num += 2^(j-1)
            end
        end
        buffer.writeu8(buf, offset + i - 1, num)
    end

    return offset + math.ceil(len/8)
end, function(self: TypeObject, val: {boolean})
    return math.ceil((self :: TypeObject).len/8)
end, function(self: TypeObject, val: {boolean})
    if not (typeof(val) == "table" and #val == self.len) then
        return false
    end

    local l = 0
    for _, v in val do
        l += 1
        if typeof(v) ~= "boolean" then
            return false
        end
        if l > self.len then
            return false
        end
    end

    return true
end)

setmetatable(Type, {
    __call = function(self, len: number)
        assert(typeof(len) == "number" and len % 1 == 0 and len >= 0, "Length of the bitField type must be a positive integer")

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