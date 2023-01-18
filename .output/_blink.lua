local e={}
e.pin=1
e.lt=0
e.setpin=function(t)
e.pin=t or e.pin
gpio.mode(e.pin,gpio.OUTPUT)
gpio.write(e.pin,gpio.LOW)
end
e.kill=function()
if e.tmr then
e.tmr:stop()
e.tmr:unregister()
e.tmr=nil
end
end
e.on=function(t)
e.kill()
t=t or 1
t=t==0 and 1 or 0
gpio.write(e.pin,t)
end
e.flash=function(t)
t=t or false
if t then
if not e.tmr then
e.tmr=tmr.create()
e.tmr:alarm(t*100,1,function()
e.lt=e.lt==0 and 1 or 0
gpio.write(e.pin,e.lt)
end)
else
e.tmr:interval(t*100)
end
else
e.kill()
end
end
return e
