if not killtop then 
	dat.analiz = nil
	return
end

dat.analiz = true

local comtb = table.remove(killtop)
if not comtb[1] or not comtb[2] then
	comtb, killtop = nil,nil
	return
end

if comtb[1] == "ide" then
	if comtb[2] == "On" then
		prt("Restart Now")
		node.task.post(function() dofile('restart.lua') end)
		return
	end

elseif comtb[1] == "auto" then
	if comtb[2] == "On" then
		wth.auto = 'On'
	end

	if wth.secure == "Off" then
		switch(pins.relaySec, 1)
	else
		switch(pins.relaySec, 0)
	end

elseif comtb[1] == "relaySec" then
	wth.auto = 'Off'
	if comtb[2] == "On" then
		switch(pins.relaySec, 1)
		prt('Secure Manual Off ')
	elseif comtb[2] == "Off" then
		switch(pins.relaySec, 0)
		prt('Secure Manual On')
	end

-- Разрешение работы по времени	
elseif comtb[1] == "relaytime" then
	if comtb[2] == "On" then
		wth.relaytime = 'On'
		prt("Time Works Set On")
	elseif comtb[2] == "Off" then
		wth.relaytime = 'Off'
		prt("Time Works Set Off")
	end

elseif comtb[1] == "garageOpen" and wth.secure == "Off" then
	if comtb[2] == "On" then
		switch(pins.relayOpen, 1)
		prt("\nOpen Garage!")
	end	

-- elseif comtb[1] == "ajaxsecure" and wth.auto == 'On'  then
elseif comtb[1] == "ajaxsecure" then
	wth.auto = 'On'
	if comtb[2] == "On" and wth.secure == "Off" then
		wth.secure = "On"
		prt("Garage Secure To On")
		switch(pins.relaySec, 0)
	elseif comtb[2] == "Off" and wth.secure == "On" then
		wth.secure = "Off"
		prt("Garage Secure To Off")
		switch(pins.relaySec, 1)
	end
end

comtb = nil

if killtop and killtop[1] then 
	node.task.post(function() dofile('mqttanalize.lua') end)
else
	killtop = nil
	dat.analiz = nil
	node.task.post(function() dofile('mqttpub.lua')(wth) end)
end