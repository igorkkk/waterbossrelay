if not dat.broker then return end
local list = {'isswitch'}
local count = 0
local pubnow, ddt
for _, v in ipairs(list) do
	ddt = dat[v] == 1 and 'On' or 'Off'
	wth[v] = ddt
	-- wth[v] = dat[v]
	--print(wth[v], ddt)
end 
wth.light = dat.light
for _ in ipairs(debug.getregistry()) do  count = count + 1 end
wth.reg = count
wth.heap = node.heap()

pubnow = function(top, dt)
	top, dt = next(wth, top)
	if top and dat.broker then
		m:publish(dat.clnt..'/'..top, dt, 2, 0, function() return pubnow(top) end)
	else
		-- print(wth.heap, wth.reg)
		ddt, list, top, dt, count = nil, nil, nil, nil, nil
		--wth = {}
		--wth.reg, wth.heap, wth.ver = nil, nil, nil 
		if dat.boot then return (function() dofile'sendboot.lua'end)() end
	end
end
return pubnow()