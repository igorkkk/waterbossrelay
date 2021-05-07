if not killtop then return end
local restartnow
restartnow =  function()
	rtcmem.write32(0, 501)
	m:publish(dat.clnt..'/ip', (wifi.sta.getip()), 0, 1)
	tmr.create():alarm(5500, 0, function() node.restart() end)
end

local comtb = table.remove(killtop)
if not comtb[1] or not comtb[2] then
	comtb, killtop = nil,nil
	return
end

if comtb[1] == "ide" then
	if comtb[2] == "On" then
		print("Restart Now")
		restartnow()
	end

elseif comtb[1] == "relay" then
	if comtb[2] == "On" then
		switch(1)
	elseif comtb[2] == "Off" then
		switch(0)
	end
	dofile("mqttpub.lua")(wth)
end
comtb, killtop = nil,nil