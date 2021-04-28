-- Sample:
-- dofile('_test_blink.lua')(20, {1,0,1,0,0,0,0}):start()
-- stop = true

local pin = 7
local schm = {1,0}
stop = false
local count = 1

gpio.mode(pin, gpio.OUTPUT)
gpio.write(pin, gpio.LOW)

return function(int, sm)
    int = int or 5
    sm = sm or schm
    local count = 1
    local tm = tmr.create()
    local d = 0
    tm:register(200, tmr.ALARM_AUTO, function (t)
        if stop then
            gpio.write(pin, 0)
            t:stop(); t:unregister()
            pin, schm, stop, count, t, int, no, count, tm, d = nil
            print('Blink Stopped')
            return
        end
        d = sm[count]
        gpio.write(pin, d)
        count = (count == #sm) and 1 or (count + 1)
    end)
    return tm
end