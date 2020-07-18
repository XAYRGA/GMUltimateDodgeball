GAME = {} -- Yell at me as you please, i'm keeping ALL of the game management functions inside of here!
GAME.Scores = {}
GAME.Scores.Red = 0
GAME.Scores.Blue = 0
GAME.InProgress = false
GAME.RoundTime = 120
GAME.RoundsElapsed = 0
GAME.SuddenDeath = false
GAME.TeamWins = {}
GAME.TeamWins.Red = 0
GAME.TeamWins.Blue = 0
META = FindMetaTable("Player")
util.AddNetworkString("GAMECOM")

function GAME:PrepNewRound()
	print("[GAME]: PREP for new round")
	game.CleanUpMap()
	print("[GAME]: Cleaned map!")
	for k,v in pairs(player.GetAll()) do 
		v:Spawn()
		v:Freeze(true)
		v:SetFrags(0)
	end
	print("[GAME]: Respawned all players")
	timer.Simple(5,GAME.PostRoundStart)
end
function GAME.PostRoundStart()
	GAME.Scores.Red = 0
	GAME.Scores.Blue = 0
	GAME.RoundTime = 180
	GAME.SendScoreUpdate()
	local time = 6
	timer.Create("GAME_RoundCountdown",1,5,function()
		time = time - 1

		GAME.SendGlobalSound("dodgeball/announcer/e_" .. time .. ".wav")
		if time==1 then 
			GAME.RoundStart()
		end

	end)
end

function GAME.RoundStart()
	--
	local A = file.Find("sound/dodgeball/music/*.mp3","GAME")


	for k,v in pairs(player.GetAll()) do 
		v:Freeze(false)
		v:SendAdvancedSound(v,"roundmusic","dodgeball/music/" .. A[math.random(1,#A)])
	end
	timer.Create("GAME_RoundTick",1,0,GAME.RoundTick)
	GAME.InProgress = true
end

function GAME.RoundTick() -- Called every 1 second.

	if GAME.SuddenDeath==true then
	    local redal = 0
	    local blual = 0
	   for k,v in pairs(team.GetPlayers(TEAM_BLUE)) do
	   	if v:Alive() then
	   		blual = blual + 1
	   	end
	   end
	   for k,v in pairs(team.GetPlayers(TEAM_RED)) do
	   	if v:Alive() then 
	   	redal = redal + 1
	    end
	   end
	   if redal == 0 then
	   	GAME.TeamWins.Blue = GAME.TeamWins.Blue + 1
	   	GAME.InProgress = false
	   		for k,v in pairs(team.GetPlayers(TEAM_BLUE)) do
			v:SendSound("dodgeball/announcer/win.wav")
		end
		for k,v in pairs(team.GetPlayers(TEAM_RED)) do
			v:SendSound("dodgeball/announcer/lost.wav")
		end
		timer.Simple(3,function()
			GAME.SendGlobalSound("dodgeball/announcer/ding.wav") 
			GAME.SendWinsUpdate()
			
		end)
		timer.Destroy("GAME_RoundTick")
		GAME.EndRound()
	   end
	   if blual == 0 then
	   	GAME.TeamWins.Red = GAME.TeamWins.Red + 1
	   	GAME.InProgress = false
	   	for k,v in pairs(team.GetPlayers(TEAM_RED)) do
			v:SendSound("dodgeball/announcer/win.wav")
		end
		for k,v in pairs(team.GetPlayers(TEAM_BLUE)) do
			v:SendSound("dodgeball/announcer/lost.wav")
		end
		timer.Simple(3,function()
			GAME.SendGlobalSound("dodgeball/announcer/ding.wav") 
			GAME.SendWinsUpdate()
			
		end)
		timer.Destroy("GAME_RoundTick")
		GAME.EndRound()
	   end
	   return
	end
	GAME.RoundTime = GAME.RoundTime - 1
	GAME.SendTimeUpdate(GAME.RoundTime )
	if GAME.RoundTime == 60 then GAME.SendGlobalSound("dodgeball/announcer/time_warning_60.wav") end
	if GAME.RoundTime == 30 then GAME.SendGlobalSound("dodgeball/announcer/time_warning_30.wav") end
	if GAME.RoundTime == 10 then GAME.SendGlobalSound("dodgeball/announcer/time_warning_10.wav") end

	if GAME.RoundTime < 6 and GAME.RoundTime > 0 then 
		GAME.SendGlobalSound("dodgeball/announcer/e_" .. GAME.RoundTime .. ".wav")
	end
	if GAME.RoundTime == 0 then
		timer.Destroy("GAME_RoundTick")
		GAME.EndRound()
	end

end

function GAME.ReawrdFunc(plr)
	--TODO
end

local function TABLE_REMOVE_DATA(tab,data)
	for k,v in pairs(tab) do
		if v==data then table.remove(tab,k) end
	end
	return tab
end


function GAME.GetHighestScorePlayers()
	local EllimTab = team.Getplayers(TEAM_RED)
	for k,v in pairs(team.Getplayers(TEAM_RED)) do
		for i,p in pairs(team.Getplayers(TEAM_RED)) do
			if (v:Frags() < p:Frags()) == true then TABLE_REMOVE_DATA(EllimTab,v) end
		end
	end

	local red_scores = EllimTab
	local EllimTab = team.Getplayers(TEAM_BLUE)
	for k,v in pairs(team.Getplayers(TEAM_BLUE)) do
		for i,p in pairs(team.Getplayers(TEAM_BLUE)) do
			if (v:Frags() < p:Frags()) == true then TABLE_REMOVE_DATA(EllimTab,v) end
		end
	end
	local blue_scores = EllimTab

	return red_scores,blue_scores

end

function GAME.EndRound()
	if GAME.SuddenDeath==true then
	    GAME.SuddenDeath = false
		for k,v in pairs(player.GetAll()) do
			v:SendAdvancedSound("stop","roundmusic")
		end
			GAME.RoundsElapsed = GAME.RoundsElapsed + 1
			timer.Simple(7,function()
				GAME:PrepNewRound()
			end)

		return
	end

	GAME.InProgress = false
	for k,v in pairs(player.GetAll()) do
		v:SendAdvancedSound("stop","roundmusic")
	end
	GAME.RoundsElapsed = GAME.RoundsElapsed + 1
	if GAME.Scores.Red > GAME.Scores.Blue then 
		for k,v in pairs(team.GetPlayers(TEAM_RED)) do
			v:SendSound("dodgeball/announcer/win.wav")
		end
		for k,v in pairs(team.GetPlayers(TEAM_BLUE)) do
			v:SendSound("dodgeball/announcer/lost.wav")
		end
		GAME.TeamWins.Red = GAME.TeamWins.Red  + 1
		timer.Simple(3,function()
			GAME.SendGlobalSound("dodgeball/announcer/ding.wav") 
			GAME.SendWinsUpdate()
		end)
		
	end
	if GAME.Scores.Blue > GAME.Scores.Red then 
		for k,v in pairs(team.GetPlayers(TEAM_BLUE)) do
			v:SendSound("dodgeball/announcer/win.wav")
		end
		for k,v in pairs(team.GetPlayers(TEAM_RED)) do
			v:SendSound("dodgeball/announcer/lost.wav")
		end
		GAME.TeamWins.Blue = GAME.TeamWins.Blue + 1
		timer.Simple(3,function()
			GAME.SendGlobalSound("dodgeball/announcer/ding.wav") 
			GAME.SendWinsUpdate()
		end)
	end
	if GAME.Scores.Blue == GAME.Scores.Red then 
		if #team.GetPlayers(TEAM_RED) > 0 and #team.GetPlayers(TEAM_BLUE) > 0 then
			GAME.NextRoundSuddenDeath()
			GAME.SendGlobalSound("dodgeball/announcer/sdeath.wav")
		else
			GAME:SendGlobalMessage({Color(255,0,0),"[",Color(255,255,255),"Dodgeball",Color(255,0,0),"]: ",Color(255,255,255),"Sudden death round was canceled due to lack of players!"})

			GAME.SendGlobalSound("dodgeball/announcer/lost.wav")
		end
	end
	if GAME.RoundsElapsed > 11 then 
		GAME.StartMapVote()
		return 
	end
	timer.Simple(7,function()
				GAME:PrepNewRound()
	end)
end

function GAME.NextRoundSuddenDeath()
	GAME.SuddenDeath = true


end

function GAME.PlayerShouldTakeDamage(vic,pl)

	if vic:IsPlayer() and IsValid(pl) and pl:IsPlayer() and vic:Team()==pl:Team() then return false end
	if GAME.InProgress==false then return false end
	
end
function GAME.StartMapVote()
	MapVote.Start(60, false, 50, {"ud_","ub_"})
end
--TODO, Make all of these usermessages because garry's net library is slow, apparantly
function GAME.SendScoreUpdate()
	net.Start("GAMECOM")
		net.WriteString("SCORE_UPDATE")
		net.WriteTable({RED = GAME.Scores.Red,BLUE = GAME.Scores.Blue})
	net.Send(player.GetAll())
end
function GAME.SendWinsUpdate()
	net.Start("GAMECOM")
		net.WriteString("WINS_UPDATE")
		net.WriteTable({RED = GAME.TeamWins.Red,BLUE = GAME.TeamWins.Blue})
	net.Send(player.GetAll())
end
function GAME.SendTimeUpdate(time)
	net.Start("GAMECOM")
		net.WriteString("TIME_UPDATE")
		net.WriteTable({time})
	net.Send(player.GetAll())
end
function GAME.SendGlobalSound(sou)
	net.Start("GAMECOM")
		net.WriteString("SIMPLE_SOUND")
		net.WriteTable({sou})
	net.Send(player.GetAll())
end
function META:SendMessage(tab)
	net.Start("GAMECOM")
		net.WriteString("CHAT_WRITE")
		net.WriteTable({tab})
	net.Send(self)
end
function META:SendSound(sou)
	net.Start("GAMECOM")
		net.WriteString("SIMPLE_SOUND")
		net.WriteTable({sou})
	net.Send(self)
end
function META:SendAdvancedSound(ent,nam,sou)
	net.Start("GAMECOM")
		net.WriteString("COMPLEX_SOUND_START" )
		net.WriteTable({ent,nam,sou})
	net.Send(self)
end

function GAME:SendGlobalMessage(tab)
	net.Start("GAMECOM")
		net.WriteString("CHAT_WRITE")
		net.WriteTable(tab)
	net.Send(player.GetAll())
end
function GAME.PlayerDeath(vic,inf,ply)
	if (#team.GetPlayers(TEAM_RED) - #team.GetPlayers(TEAM_BLUE)) >= 2 then
		if vic:Team()~=TEAM_BLUE then 
			GAME:SendGlobalMessage({Color(255,0,0),"[",Color(255,255,255),"Dodgeball",Color(255,0,0),"]: ",vic,Color(255,255,255)," was changed to blue for team balance!"})
			vic:SetTeam(TEAM_BLUE)
		end
	end
	if (#team.GetPlayers(TEAM_BLUE) - #team.GetPlayers(TEAM_RED)) >= 2 then
		if vic:Team()~=TEAM_RED then 
			GAME:SendGlobalMessage({Color(255,0,0),"[",Color(255,255,255),"Dodgeball",Color(255,0,0),"]: ",vic,Color(255,255,255)," was changed to red for team balance!"})
			vic:SetTeam(TEAM_RED)
		end
	end
	if vic:IsPlayer() then
		if ply:IsPlayer() then
			if ply:Team()~=vic:Team() then
				if ply:Team()==TEAM_RED then
					GAME.Scores.Red = GAME.Scores.Red + 1
					GAME.SendScoreUpdate()
					ply:AddFrags(1)
				end
				if ply:Team()==TEAM_BLUE then
					GAME.Scores.Blue = GAME.Scores.Blue + 1
					GAME.SendScoreUpdate()
					ply:AddFrags(1)
				end
			end
		end

	end
end
function GAME.PlayerDeathThink(plr)
	if GAME.SuddenDeath == true then return true end
end
function GAME.PlacePowerups()
	local rpawns = ents.FindByClass( "info_player_rebel" )
	local bpawns = ents.FindByClass( "info_player_combine" )


	local pwrpntr = rpawns[math.random(1,#rpawns)] 
	local pwrpntb = bpawns[math.random(1,#bpawns)] 
	local prstrigns = {}
	local i = 0
	for k,v in pairs(BALLMGR.BallTypes) do
		if k~="default" then
			i = i + 1
			prstrings[i] = k
		end
	end
	local rpwru = prstrings[math.random(1,#prstrings)]
	local bpwru = prstrings[math.random(1,#prstrings)]
end
function GAME.PlayerInitialSpawn() 
	GAME.SendScoreUpdate()
	GAME.SendWinsUpdate()
	GAME.SendTimeUpdate(GAME.RoundTime)
end
hook.Add( "PlayerInitialSpawm", "GAME_ControlISpawn", GAME.PlayerInitialSpawn )
hook.Add( "PlayerDeath", "GAME_ControlDeath", GAME.PlayerDeath )
hook.Add( "PlayerDeathThink", "GAME_ControlDeath", GAME.PlayerDeathThink );
hook.Add("PlayerShouldTakeDamage","GAME_ControlDamage",GAME.PlayerShouldTakeDamage)
hook.Add("InitPostEntity","GAME_LogicEntryPoint",function()
	print("[GAME]: Starting entry point...")
	print("Once upon a time...")
	local rslt,err = pcall(GAME.PrepNewRound)
	if rslt then 
		print("GAAAAAAAAAAAAH")
	else
		print("There was an error")
		print(err)
	end
	print("the end.")
end)

