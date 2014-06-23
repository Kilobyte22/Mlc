local rbobject = Mlc.global.Class._make('Object')
Mlc.global.Class._super = rbobject
Mlc.global.Object = rbobject

function rbobject._imethods:initialize()
    -- this is the implicit for all classes default constructor
end

function rbobject._imethods:method_missing(block, name)
    error('Undefined method #'..name..' for '..self._class._name)
end

