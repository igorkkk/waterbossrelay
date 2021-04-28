-- Sample:
-- dofile('_test_blink.lua')(20, {1,0,1,0,0,0,0}):start()
-- stop = true
stop = false
local pin = 7
gpio.mode(pin, gpio.OUTPUT)
gpio.write(pin, gpio.LOW)

return function(int, sm)
    int = int or 500
    sm = sm or {1,0}
    local count = 1
    local tm = tmr.create()
    local d = 0
    tm:register(int, tmr.ALARM_AUTO, function (t)
        if stop then
            stop = nil
            gpio.write(pin, 0)
            t:stop() t:unregister() t = nil
            return
        end
        gpio.write(pin, sm[count])
        count = (count == #sm) and 1 or (count + 1)
    end)
    return tm
end