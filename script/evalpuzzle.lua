function main()
	if not io then
	io=require("io")
	end
	if not os then
	os=require("os")
	end
	--[read xx.lua as puzzle file]
	local pz_file = io.open("xx.lua","r")
	if not pz_file then 
	return 
	end

	local line_str=pz_file:read()
	while(line_str) do
		if(line_str:match("Debug.AddCard"))then
			-- _aaa,_b,code,pl,owner,locstr,seq,posstr = line_str:gmatch("([^,]+)")
			local tb={}
			i=0
			for word in line_str:gmatch("[%w_]+") do
			i=i+1
			tb[i]=word
			end
			_aaa,_b,code,pl,owner,locstr,seq,posstr = table.unpack(tb)
			print(_aaa,_b,code,pl,owner,locstr,seq,posstr)
		elseif line_str:match("Debug.SetPlayerInfo") then
			local tb={}
			i=0
			for word in line_str:gmatch("[%w]+") do
			i=i+1
			tb[i]=word
			end
			_,__,pl,lp,hand,draw=table.unpack(tb)
			print(_,__,pl,lp,hand,draw)
		else
			print('[not matched]\t',line_str)
		end
		line_str=pz_file:read()
	end
	pz_file:close()
end


main()