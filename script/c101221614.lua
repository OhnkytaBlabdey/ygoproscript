--load puzzle
function c101221614.initial_effect(c)
	local e1 =Effect.GlobalEffect()
	
	e1:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e1:SetCode(EVENT_TURN_END)
	e1:SetCondition(function() return true end)
	-- e1:SetTarget()
	e1:SetRange(0,1)
	e1:SetOperation(c101221614.op)
	Duel.RegisterEffect(e1,1)
	
	-- player 1 is ready to crack and player 0 is the defender. 
	--init skip phase
	local e5=Effect.GlobalEffect()
	e5:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e5:SetCode(EVENT_PHASE_START+PHASE_DRAW)
	e5:SetOperation(c101221614.skip)
	Duel.RegisterEffect(e5,1)
end

c101221614.turn_limit=false
c101221614.info={{},{}}

function c101221614.clear()
local cards=Duel.GetFieldGroup(0,0xff,0xff)
Duel.Remove(cards,0xa,0x400)
end

function c101221614.skip(e,tp,eg,ep,ev,re,r,rp)
if Duel.GetTurnCount()==1 then
tp=0
--
local e1=Effect.GlobalEffect()
e1:SetType(EFFECT_TYPE_FIELD)
e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
e1:SetTargetRange(1,0)
e1:SetCode(EFFECT_SKIP_DP)
e1:SetReset(RESET_PHASE+PHASE_END)
Duel.RegisterEffect(e1,tp)
--
local e2=Effect.GlobalEffect()
e2:SetType(EFFECT_TYPE_FIELD)
e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
e2:SetTargetRange(1,0)
e2:SetCode(EFFECT_SKIP_SP)
e2:SetReset(RESET_PHASE+PHASE_END)
Duel.RegisterEffect(e2,tp)
--
local e3=Effect.GlobalEffect()
e3:SetType(EFFECT_TYPE_FIELD)
e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
e3:SetTargetRange(1,0)
e3:SetCode(EFFECT_SKIP_M1)
e3:SetReset(RESET_PHASE+PHASE_END)
Duel.RegisterEffect(e3,tp)
--
local e4=Effect.GlobalEffect()
e4:SetType(EFFECT_TYPE_FIELD)
e4:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
e4:SetTargetRange(1,0)
e4:SetCode(EFFECT_SKIP_BP)
e4:SetReset(RESET_PHASE+PHASE_END)
Duel.RegisterEffect(e4,tp)
--
local e6=Effect.GlobalEffect()
e6:SetType(EFFECT_TYPE_FIELD)
e6:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
e6:SetTargetRange(1,0)
e6:SetCode(EFFECT_CANNOT_BP)
e6:SetReset(RESET_PHASE+PHASE_END)
Duel.RegisterEffect(e6,tp)
--
local e5=Effect.GlobalEffect()
e5:SetType(EFFECT_TYPE_FIELD)
e5:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
e5:SetTargetRange(1,0)
e5:SetCode(EFFECT_SKIP_M2)
e5:SetReset(RESET_PHASE+PHASE_END)
Duel.RegisterEffect(e5,tp)
end
end

function c101221614.op(e,tp,eg,ep,ev,re,r,rp)
 --[先攻者是0，开始时是第1回合]
--[AI 先手，首次AI的回合，清场]
--[B是玩家，A是AI]
if Duel.GetTurnCount()==1 then

c101221614.clear()

if not io then
io=require("io")
end
if not os then
os=require("os")
end
	--[read xx.lua as puzzle file]
	local pz_file = io.open("single/xx.lua","r")
	if not pz_file then 
	return 
	end

	local line_str=pz_file:read()
	while(line_str) do
		if(line_str:match("Debug.AddCard"))then
			-- Debug.AddCard(102380,1,1,16,0,1)
			-- AddCard(pl,code,loc,seq,pos)
			-- showtable(para_table)
			
			local tb={}
			i=0
			for word in line_str:gmatch("[%w%s_=]+") do
			i=i+1
			tb[i]=word
			end
			_aaa,_b,code,pl,owner,locstr,seq,posstr = table.unpack(tb)
			pl=1-pl
			loc=_G[locstr]
			pos=_G[posstr]
		-- Debug.ShowHint(pl..code..loc..seq..pos)
		AddCard(pl,code,loc,seq,pos)
		elseif line_str:match("Debug.SetPlayerInfo") then
			local tb={}
			i=0
			for word in line_str:gmatch("[%w%s]+") do
			i=i+1
			if i>2 then
			num=tonumber(word)
			tb[i-2]=num
			end
			end
			pl,lp,hand,draw=table.unpack(tb)
			pl = 1 - pl
			tb[1]=1-tb[1]
			for j =1,4 do
				c101221614.info[pl+1][j]=tb[j]
			end
			-- SetPlayerInfo(pl,lp,hand,draw)
			-- print(pl,lp,hand,draw)
		elseif line_str == "aux.BeginPuzzle()" then
			c101221614.turn_limit=true
		end
		line_str=pz_file:read()
	end
	SetPlayerInfo(table.unpack(c101221614.info[1]))
	SetPlayerInfo(table.unpack(c101221614.info[2]))
	pz_file:close()
elseif Duel.GetTurnCount()==2 then
if c101221614.turn_limit ==true then
Duel.SetLP(1,0)
-- [turn limit]
end
end

end

-- function c101221614.con(e,tp,eg,ep,ev,re,r,rp)
-- return Duel.GetTurnCount()>2
-- end

function showtable(t)
if not t then 
Debug.ShowHint("this is nil value")
Duel.BreakEffect()
return 0
end

local ct = #t
if ct and ct>0 then
else
Debug.ShowHint(" table of nil")
Duel.BreakEffect()
return 0
end

local i=0
local str=""
for i=1,ct do
	if t[i] then
	str=str..i.."\t:"..t[i]..',,\t'
	end
end
	Debug.ShowHint(str)
	Duel.BreakEffect()
end

--
function AddCard(pl,code,loc,seq,pos)
if seq then
else
seq=0
end
local c_a=Duel.CreateToken(pl,code)
if loc==LOCATION_GRAVE then
Duel.SendtoGrave(c_a,REASON_RULE)
elseif loc==LOCATION_HAND then
Duel.SendtoHand(c_a,pl,REASON_RULE)
elseif loc==LOCATION_EXTRA then
Duel.SendtoDeck(c_a,pl,seq,REASON_RULE)
elseif loc==LOCATION_DECK then
Duel.SendtoDeck(c_a,pl,seq,REASON_RULE)
elseif loc==LOCATION_REMOVED then
Duel.Remove(c_a,POS_FACEUP,0x400)
elseif loc==LOCATION_MZONE or loc==LOCATION_SZONE or loc==LOCATION_FZONE then
Duel.SendtoDeck(c_a,pl,0,REASON_RULE)
Duel.MoveToField(c_a,pl,pl,loc,pos,false)
end
--
Duel.MoveSequence(c_a,seq)
return c_a
end

function SetPlayerInfo(pl,lp,hand,draw)
	Duel.SetLP(pl,lp)

if hand>0 then
	Duel.Draw(pl,hand,0x400)
end

if draw<1 then
	return
end

--
local e1=Effect.GlobalEffect()
e1:SetType(EFFECT_TYPE_FIELD)
e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
e1:SetTargetRange(1,0)
e1:SetCode(EFFECT_DRAW_COUNT)
e1:SetValue(draw)
e1:SetCondition(function()
return Duel.GetTurnCount()>2
end)
Duel.RegisterEffect(e1,pl)
end


