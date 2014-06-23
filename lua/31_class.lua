local rbclass = Mlc.classes.Object._new(nil)
Mlc.global.Class = rbclass

rbclass._imethods = {}
rbclass._cmethods = {}
rbclass._name = 'Class'
rbclass._class = rbclass

function rbclass._imethods:new(...)
    local ret = Mlc.classes.Object._new(self)
    ret:minitialize(...)
    return ret
end

function rbclass._make(name, super)
    local c = Mlc.classes.Object._new(rbclass)
    c._super = super or Mlc.global.Object
    c._name = name
    c._class = rbclass
    c._imethods = {}
    c._cmethods = {}
    Mlc.global[name] = c -- todo: handle modules
    return c
end
