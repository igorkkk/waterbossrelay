pin = 7
shem = {}
shem[1] =	{1,0,1,0,1,0,0,0,0}
shem[2] =	{1,0,1,0,0,0,0}
count = 1

gpio.mode(pin, gpio.OUTPUT)
gpio.write(pin, gpio.LOW)

tcr = function(int, no)
    int = int or 5
    no = no or 2
    local count = 1
    local tm = tmr.create()
    local d = 0
    tm:register(200, tmr.ALARM_AUTO, function (t)
        d = shem[no][count]
        print(d)
        gpio.write(pin, d)
        count = (count == #shem[no]) and 1 or (count + 1)
    end)
    return tm
end
return tcr()