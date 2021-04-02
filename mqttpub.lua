local pubnow
local lwth = {} 
local count = 0
pubnow = function(top, dt)
	top, dt = next(lwth, top)
	if top then prt('Send:', top, dt) end
	if top and dat.broker then
		m:publish(dat.clnt..'/'..top, dt, 2, 0, function() if pubnow then pubnow(top) end end)
	else
		if dat.boot then dofile('sendboot.lua') end
	end
end
return function(tb) 
	if not dat.broker or not m then print('Lost Broker') return end
	if tb then lwth = tb end
	for _ in pairs(debug.getregistry()) do  count = count + 1 end
	lwth.reg = count
	lwth.heap = node.heap()
	print("Heap:", lwth.heap, "Reg:", lwth.reg)
	pubnow() 
end