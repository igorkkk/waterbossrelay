M = {}
M.pin = 7
local setpin = function(pin)
    pin = pin or M.pin
    gpio.mode(pin, gpio.OUTPUT)
    gpio.write(pin, gpio.LOW)
end
M.t = tmr.create()
M.int = 500
M.sm = {1,0}
M.count = 1
M.d = 0
M.stop = false
M.work = function (t)
    if M.stop then
        gpio.write(M.pin, 0)
        t:stop() t:unregister() t = nil
        return
    end
    gpio.write(M.pin, M.sm[M.count])
    M.count = (M.count == #M.sm) and 1 or (M.count + 1)
end
M.exit = function ()
    
end
