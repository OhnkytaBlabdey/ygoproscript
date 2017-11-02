--残局制作
function c111021537.initial_effect(c)
local e1=Effect.CreateEffect(c)
e1:SetType(EFFECT_TYPE_ACTIVATE)
e1:SetCode(EVENT_FREE_CHAIN)
e1:SetOperation(c111021537.op)
c:RegisterEffect(e1)

end
function c111021537.op(e,tp,eg,ep,ev,re,r,rp)
local str=""
str=str.."Debug.SetAIName("..'"'.."bot"..'"'..")".."\n".."Debug.ReloadFieldBegin(DUEL_ATTACK_FIRST_TURN+DUEL_SIMPLE_AI)".."\n".."Debug.SetPlayerInfo(0,100,0,0)".."\n".."Debug.SetPlayerInfo(1,8000,0,0)".."\n"

local c=e:GetHandler()
Duel.SendtoDeck(c,nil,-1,0x400)
--Debug.ShowHint("要添加卡片吗？")
 while(Duel.SelectYesNo(tp,7)) do 
  --AddCard(tp,announcecard(),announceloc(),announceseq(),announcepos())
  local cd=Duel.AnnounceCard(tp)
  local seq=0
  local pos=0x01
  local loc=ancloc()
  local pl=0
  local tm=nil
  Debug.ShowHint("select a player ".."\n".."0 for self ".."\n".."1 for opponent")
  pl,tm=Duel.AnnounceNumber(tp,0,1)
  tm=nil
  if loc and (loc==LOCATION_DECK or loc==LOCATION_EXTRA or loc==LOCATION_GRAVE or loc==LOCATION_HAND or loc==LOCATION_REMOVED ) then
  else 
  seq=ancseq()
  pos=ancpos()
  end
  AddCard(pl,cd,loc,seq,pos)
  str=str.."\n".."Debug.AddCard("..cd..","..pl..","..pl..","..loc..","..seq..","..pos..")"
 end
 Debug.ShowHint("initializing field process has been finished")
 str=str.."\n".."\n".."Debug.ReloadFieldEnd()".."\n".."aux.BeginPuzzle()".."\n"
io=require("io")
		local f=io.open("./single/_Puzzle.lua","w+")
		f:write(str)
		f:close()
	Debug.ShowHint("Puzzle Saved!")
io=nil

end

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
elseif loc==LOCATION_MZONE or loc==LOCATION_SZONE then
Duel.SendtoDeck(c_a,pl,0,REASON_RULE)
Duel.MoveToField(c_a,pl,pl,loc,pos,false)
end
--
Duel.MoveSequence(c_a,seq)
return c_a
end

function ancloc()
Debug.ShowHint("\n" .. "0:DECK" .. "	" .. "1:EXTRA" .. "\n" .. "2:GRAVE" .. "	" .. "3:HAND" .. "\n" .. "4:MZONE" .. " " .. "5:SZONE" .."\n".. "6:REMOVED" )
local num,xx=Duel.AnnounceNumber(tp,0,1,2,3,4,5,6)
local loc=0x01
if num==0 then
 
elseif num== 1 then
 loc=0x40
elseif num== 2 then
 loc=0x10
elseif num== 3 then
 loc=0x02
elseif num== 4 then
 loc=0x04
elseif num== 5 then
 loc=0x08
elseif num== 6 then
 loc=0x20
end
return loc
end

function ancseq()
--Debug.ShowHint("Select Sequence")
local num,xx=Duel.AnnounceNumber(tp,0,1,2,3,4)
 return num
end

function ancpos()
-- local num,xx=1,1
--Debug.ShowHint("1 for POS_FACEUP_ATTACK".."\n".."2 for POS_FACEUP_DEFENCE".."\n".."3 for POS_FACEDOWN_DEFENCE".."\n".."4 for POS_FACEDOWN_ATTACK")
local pos=0x01
-- Debug.ShowHint(pos)
local num,xx=Duel.AnnounceNumber(tp,1,2,3,4)
-- Debug.ShowHint(num.."\n"..pos)
if num == 1 then
 
elseif num == 2 then
pos=0x04
 
elseif num == 3 then
pos=0x08
 
elseif num == 4 then
pos=0x02
 
end
return pos

end
