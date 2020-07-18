function GM:InitPostEntity( )	
	if not game.SinglePlayer() then
      timer.Create("CheckAFK", 5, 0, CheckAFK)
   end
end

-- CHECK AFK
local afkinfo = {ang = nil, pos = nil, mx = 0, my = 0, t = 0}
function CheckAFK()
   	if not IsValid(LocalPlayer()) then return end
   	if not afkinfo.ang or not afkinfo.pos then
      	afkinfo.ang = LocalPlayer():GetAngles()
      	afkinfo.pos = LocalPlayer():GetPos()
      	afkinfo.mx = gui.MouseX()
      	afkinfo.my = gui.MouseY()
      	afkinfo.t = CurTime()
      	return
   	end

   	if not GAMEMODE.IsWaiting and LocalPlayer():Team() != TEAM_SPECTATOR then
   		afk_timer = 60
      	if afk_timer <= 0 then afk_timer = 60 end 

      	if LocalPlayer():GetAngles() != afkinfo.ang then
         -- Normal players will move their viewing angles all the time
        	afkinfo.ang = LocalPlayer():GetAngles()
        	afkinfo.t = CurTime()
      	elseif gui.MouseX() != afkinfo.mx or gui.MouseY() != afkinfo.my then
         -- Players in eg. the Help will move their mouse occasionally
         	afkinfo.mx = gui.MouseX()
         	afkinfo.my = gui.MouseY()
         	afkinfo.t = CurTime()
      	elseif LocalPlayer():GetPos():Distance(afkinfo.pos) > 10 then
         -- Even if players don't move their mouse, they might still walk
         	afkinfo.pos = LocalPlayer():GetPos()
         	afkinfo.t = CurTime()
      	elseif CurTime() > (afkinfo.t + afk_timer) then
      		RunConsoleCommand("say", "[Dodgeball] Player was moved to spectator because the player was AFK.")
        	timer.Simple(0.3, function()
				RunConsoleCommand("changeteam", 3)
        	end)
      	elseif CurTime() > (afkinfo.t + (afk_timer / 2)) then
      	end
   	end
end