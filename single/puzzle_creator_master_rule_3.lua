Debug.SetAIName("残局")
Debug.ReloadFieldBegin(DUEL_ATTACK_FIRST_TURN+DUEL_SIMPLE_AI)
Debug.SetPlayerInfo(0,100,0,0)
Debug.SetPlayerInfo(1,8000,0,0)
Debug.AddCard(111141447,0,0,LOCATION_HAND,3,POS_FACEUP_ATTACK) --setcard
Debug.ReloadFieldEnd()
aux.BeginPuzzle()
