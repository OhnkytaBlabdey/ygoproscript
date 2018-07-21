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
	local ct=0
	-- local sp=' , '
	local tb={}
	while(line_str) do
		_,ct = line_str:gsub("Debug.AddCard","_")
		if(ct==1)then
			-- _aaa,_b,code,pl,owner,locstr,seq,posstr = line_str:gmatch("([^,]+)")
			
			print(line_str)
			i=0
			for word in line_str:gmatch("[%w_]+") do
			i=i+1
			tb[i]=word
			end
			_aaa,_b,code,pl,owner,locstr,seq,posstr = table.unpack(tb)
			print(_aaa,_b,code,pl,owner,locstr,seq,posstr)
		end
		line_str=pz_file:read()
	end
	pz_file:close()
end


main()