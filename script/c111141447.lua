--残局制作-大师三版
function c111141447.initial_effect(c)
local e1=Effect.CreateEffect(c)
e1:SetType(EFFECT_TYPE_ACTIVATE)
e1:SetCode(EVENT_FREE_CHAIN)
e1:SetOperation(c111141447.op)
c:RegisterEffect(e1)

end
function c111141447.op(e,tp,eg,ep,ev,re,r,rp)
local str=""
str=str.."Debug.SetAIName("..'"'.."bot"..'"'..")".."\n".."Debug.ReloadFieldBegin(DUEL_ATTACK_FIRST_TURN+DUEL_SIMPLE_AI)".."\n".."Debug.SetPlayerInfo(0,100,0,0)".."\n".."Debug.SetPlayerInfo(1,8000,0,0)".."\n"

local c=e:GetHandler()
Duel.SendtoDeck(c,nil,-2,0x400)
local g0=Group.CreateGroup()
local g1=Group.CreateGroup()
local g2=Group.CreateGroup()
local g3=Group.CreateGroup()
local g4=Group.CreateGroup()
local ci=1
for ci=111021901,111021907 do
local c0=AddCard(1,ci,0x40,0,0x01)
Group.AddCard(g0,c0)
c0=nil
end
for ci=111021910,111021913 do
local c0=AddCard(1,ci,0x40,0,0x01)
Group.AddCard(g1,c0)
c0=nil
end
for ci=111021908,111021909 do
local c0=AddCard(1,ci,0x40,0,0x01)
Group.AddCard(g2,c0)
c0=nil
end
for ci=111021920,111021924 do
local c0=AddCard(1,ci,0x40,0,0x01)
Group.AddCard(g3,c0)
c0=nil
end

for ci=101131644,101131645 do
local c0=AddCard(1,ci,0x40,0,0x01)
Group.AddCard(g4,c0)
c0=nil
end

--Debug.ShowHint("要添加卡片吗？")
 while((Group.Select(g4,0,1,1,nil)):GetFirst():GetOriginalCode()-101131644 ~= 0 ) do 
  --AddCard(tp,announcecard(),announceloc(),announceseq(),announcepos())
  local cd=Duel.AnnounceCard(tp)
  local seq=0
  local pos=0x01
  local loc=ancloc(g0)
  local pl=0
  local tm=nil
  --Debug.ShowHint("select a player ".."\n".."0 for self ".."\n".."1 for opponent")
  --pl,tm=Duel.AnnounceNumber(tp,0,1)
  --tm=nil
  local cr=(Group.Select(g2,0,1,1,nil)):GetFirst()
  pl=cr:GetOriginalCode()-111021908
  cr=nil
  if loc and (loc==LOCATION_DECK or loc==LOCATION_EXTRA or loc==LOCATION_GRAVE or loc==LOCATION_HAND or loc==LOCATION_REMOVED ) then
  else 
  seq=ancseq(g3)
  pos=ancpos(g1)
  end
  AddCard(pl,cd,loc,seq,pos)
  str=str.."\n".."Debug.AddCard("..cd..","..pl..","..pl..","..loc..","..seq..","..pos..")"
 end
 Debug.ShowHint("all cards finished!")
 str=str.."\n".."\n".."Debug.ReloadFieldEnd()".."\n".."aux.BeginPuzzle()".."\n"
io=require("io")
os=require("os")
local timestr=os.date()
timestr=timestr:gsub("/","_")
timestr=timestr:gsub(":","-")
		local f=io.open("./single/"..timestr.."_Puzzle.lua","w+")
		f:write(str)
		f:close()
	Debug.ShowHint("Puzzle Saved!")
os=nil
io=nil
Duel.SendtoDeck(g0,nil,-2,0x400)
Duel.SendtoDeck(g1,nil,-2,0x400)
Duel.SendtoDeck(g2,nil,-2,0x400)
Duel.SendtoDeck(g3,nil,-2,0x400)
Duel.SendtoDeck(g4,nil,-2,0x400)
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
elseif loc==LOCATION_REMOVED then
Duel.Remove(c_a,POS_FACEUP,0x400)
elseif loc==LOCATION_MZONE or loc==LOCATION_SZONE then
Duel.SendtoDeck(c_a,pl,0,REASON_RULE)
Duel.MoveToField(c_a,pl,pl,loc,pos,false)
end
--
Duel.MoveSequence(c_a,seq)
return c_a
end


function ancloc(g0)
--Debug.ShowHint("\n" .. "0:DECK" .. "  " .. "1:EXTRA" .. "\n" .. "2:GRAVE" .. "	" .. "3:HAND" .. "\n" .. "4:MZONE" .. " " .. "5:SZONE" .."\n".. "6:REMOVED" )
-- local num,xx=Duel.AnnounceNumber(tp,0,1,2,3,4,5,6)
local num=0

local cr=(Group.Select(g0,0,1,1,nil)):GetFirst()
num=cr:GetOriginalCode()-111021901
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

function ancseq(g3)
--Debug.ShowHint("Select Sequence")
-- local num,xx=Duel.AnnounceNumber(tp,0,1,2,3,4)
local num=1
local cr=(Group.Select(g3,0,1,1,nil)):GetFirst()
num=cr:GetOriginalCode()-111021920
 return num
end

function ancpos(g1)
-- local num,xx=1,1
--Debug.ShowHint("1 for POS_FACEUP_ATTACK".."\n".."2 for POS_FACEUP_DEFENCE".."\n".."3 for POS_FACEDOWN_DEFENCE".."\n".."4 for POS_FACEDOWN_ATTACK")
local pos=0x01
-- Debug.ShowHint(pos)
-- local num,xx=Duel.AnnounceNumber(tp,1,2,3,4)
-- Debug.ShowHint(num.."\n"..pos)
local num=1
local cr=(Group.Select(g1,0,1,1,nil)):GetFirst()
num=cr:GetOriginalCode()-111021909

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
