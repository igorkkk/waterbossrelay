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
		prt("Restart Now")
		restartnow()
	end

elseif comtb[1] == "auto" then
	if comtb[2] == "On" then
		wth.auto = 'On'
	end

	if wth.secure == "Off" then
		switch(1)
	else
		switch(0)
	end
	dofile("mqttpub.lua")(wth)
elseif comtb[1] == "relay" then
	wth.auto = 'Off'
	if comtb[2] == "On" then
		switch(1)
	elseif comtb[2] == "Off" then
		switch(0)
	end
	dofile("mqttpub.lua")(wth)
elseif comtb[1] == "relaytime" then
	if comtb[2] == "On" then
		wth.relaytime = 'On'
	elseif comtb[2] == "Off" then
		wth.relaytime = 'Off'
		switch(1)
		prt("Relay to ON")
	end
	dofile("mqttpub.lua")(wth)

elseif comtb[1] == "ajaxsecure" and wth.auto == 'On'  then
	if comtb[2] == "On" and wth.secure == "Off" then
		wth.secure = "On"
		prt("Relay to OFF")
		switch(0)
	elseif comtb[2] == "Off" and wth.secure == "On" then
		wth.secure = "Off"
		prt("Relay to ON")
		switch(1)
	end
end
comtb, killtop = nil,nil