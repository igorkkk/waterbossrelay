if not killtop then return end
local restartnow
restartnow =  function()
	rtcmem.write32(0, 501)
	m:publish(dat.clnt..'/ip', (wifi.sta.getip()), 0, 1)
	tmr.create():alarm(5500, 0, function() node.restart() end)
end

local com = table.remove(killtop)
local top = com[1]
local dt = com[2]
if top and dt ~= "" then
	if top == "switch" then
		if dt == "ON" then dat.man = true; switch(1) 
		else dat.man = false; switch(0) end
	elseif top == "ide" then
		if dt == "ON" then
			print("Restart Now")
			restartnow()
		end
	elseif top == "auto" then
		if dt == "On" then
			wth.auto = 'On'
		elseif dt == "Off" then
			wth.auto = 'Off'
		end
		dofile("mqttpub.lua")(wth)
	elseif top == "relay" and wth.auto == 'Off' then
		if dt == "On" then
			switch(1)
		elseif dt == "Off" then
			switch(0)
		end
		dofile("mqttpub.lua")(wth)
	elseif top == "ajaxsecure" and wth.auto == 'On'  then
		if dt == "On" and wth.secure == "Off" then
			wth.secure = "On"
			print("Start Switch OFF Waterboss")
		elseif dt == "Off" and wth.secure == "On" then
			wth.secure = "Off"
			print("Start Switch ON Waterboss")
		end
		whattodo()
	else
		return
	end
else
	com,top,dt,killtop = nil,nil,nil,nil
end
