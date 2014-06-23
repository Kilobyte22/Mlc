local Object = {}
Object.__index = Object
Mlc.classes.Object = Object

function Object._new(class)
    local self = setmetatable({}, Object)
    self._class = class
    return self
end

function Object:_resolve_method(name)
    local m = self._class._imethods[name] or  -- search the instance methods
        self._class._cmethods[name] -- search class methods
    -- todo: search parent class
    return m
end

function Object:_mkmissing(name)
    return function(...)
        return self:mmethod_missing(nil, Mlc.helpers.wrap(name), ...)
    end
end

local objmt = {}
setmetatable(Object, objmt)

function objmt:__index(key, value)
    local type = key:sub(1, 1)
    local name = key:sub(2)
    if type == 'm' then
        -- method
        return self:_resolve_method(name) or self:_mkmissing(name)
    end
end
