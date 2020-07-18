GAME = {} -- Yell at me as you please, i'm keeping ALL of the game management functions inside of here!
GAME.Scores = {}
GAME.Scores.Red = 0
GAME.Scores.Blue = 0
GAME.Sounds = {}
GAME.RoundTimeString = "???"
GAME.RoundTimeNumber = 0
GAME.TeamWins = {}
GAME.TeamWins.Red = 0
GAME.TeamWins.Blue = 0
function GAME.ReceiveNetStream()

	local command = net.ReadString()
	local data = net.ReadTable()
	print(command .. " --> " .. string.gsub(tostring(data),"table: ",""))
	if command == "SCORE_UPDATE" then
		GAME.Scores.Red = data.RED
		GAME.Scores.Blue = data.BLUE
	end
	if command == "WINS_UPDATE" then
		GAME.TeamWins.Red = data.RED
		GAME.TeamWins.Blue = data.BLUE
	end
	if command == "SIMPLE_SOUND" then
		if type(data[1])=="table" then 
			PrintTable(data[1])
		end
		surface.PlaySound(data[1])
	end
	if command == "CHAT_WRITE" then
		chat.AddText(unpack(data))
		--print("Adding text")
		--PrintTable(data)
	end
	if command == "COMPLEX_SOUND_START" then
		if type(data[1])=="string" then
			if data[1]=="stop" then
				if GAME.Sounds[data[2]] then
					GAME.Sounds[data[2]]:Stop()
					GAME.Sounds[data[2]] = nil 
					return 
				end
			end
		end
		if !data[1] or data[1]==nil then
			print("[SOUND]: Unable to locate entity, not playing sound.")
			return
		end
		if !data[2] or data[2]==nil then
			print("[SOUND]: No name defined, not playing sound.")
			return
		end
		if !data[3] or data[3]==nil then
			print("[SOUND]: Sound not defined, not playing sound.")
			return
		end
		GAME.Sounds[data[2]] = CreateSound(data[1],data[3])
		GAME.Sounds[data[2]]:Play()
	end
	if command == "TIME_UPDATE" then
		GAME.RoundTimeString = 	string.ToMinutesSeconds( data[1] )
		GAME.RoundTimeNumber = data[1]

	end

end
net.Receive("GAMECOM",GAME.ReceiveNetStream)

