
HasTf2 = false

if HasTf2 then 
TFMENU = {}

local PANEL = {}

function PANEL:LayoutEntity( Entity )
 
	if ( self.bAnimated ) then -- Make it animate normally
		self:RunAnimation()
	end
 
end
 
vgui.Register("DModelPanelNR",PANEL,"DModelPanel")


HasTf2 = file.Exists("models/vgui/ui_team01.mdl","GAME")

if HasTf2 then 
TFMENU = {}

function TFMENU:RemoveMe()
	timer.Destroy("TFMENU.UpdateTeams")
	for k,v in pairs(TFMENU) do
		if type(v)=="Panel" then 
			if IsValid(v.Button) then v.Button:Remove() end
			if IsValid(v.Count) then v.Count:Remove() end
			v:Remove() 
		end

	end
	gui.EnableScreenClicker(false)
end


TFMENU.Memory = {}
TFMENU.Memory.RedDoor = true
TFMENU.Memory.BlueDoor = true

 TFMENU.Teams = {}
 TFMENU.Teams.Red = 0
 TFMENU.Teams.Blue = 0

surface.CreateFont( "TF2FONT2", {
 font = "tf2",
 size = ((ScrW() + ScrH()) / 60) ,
 weight = 500,
 blursize = 0,
 scanlines = 0,
 antialias = true,
 underline = false,
 italic = false,
 strikeout = false,
 symbol = false,
 rotary = false,
 shadow = false,
 additive = false,
 outline = false
} )



function GM:ShowTeam()
if TFMENU then TFMENU:RemoveMe() end
gui.EnableScreenClicker(true)
TFMENU.Background = vgui.Create("DModelPanelNR")
TFMENU.Background:SetModel("models/vgui/ui_team01.mdl")
TFMENU.Background:SetSize(ScrW() - 0.1,ScrH() - 0.1)
print(TFMENU.Background:GetLookAt())
TFMENU.Background:SetLookAt(Vector(0,0,35))
TFMENU.Background:GetEntity():SetAngles(Angle(-10,45,0))
TFMENU.Background:SetFOV(90)
TFMENU.Background:GetEntity():SetSequence(1)
TFMENU.Background.Entity = TFMENU.Background:GetEntity()



TFMENU.BlueDoor = vgui.Create("DModelPanelNR")
TFMENU.BlueDoor:SetModel("models/vgui/ui_team01_blue.mdl")
TFMENU.BlueDoor:SetSize(ScrW() - 0.1,ScrH() - 0.1)
print(TFMENU.BlueDoor:GetLookAt())
TFMENU.BlueDoor:SetLookAt(Vector(0,0,35))
TFMENU.BlueDoor:GetEntity():SetAngles(Angle(-10,45,0))
TFMENU.BlueDoor:SetFOV(90)
TFMENU.BlueDoor:GetEntity():SetSequence(1)
TFMENU.BlueDoor.Entity = TFMENU.BlueDoor:GetEntity()


TFMENU.RedDoor = vgui.Create("DModelPanelNR")
TFMENU.RedDoor:SetModel("models/vgui/ui_team01_Red.mdl")
TFMENU.RedDoor:SetSize(ScrW() - 0.1,ScrH() - 0.1)
print(TFMENU.RedDoor:GetLookAt())
TFMENU.RedDoor:SetLookAt(Vector(0,0,35))
TFMENU.RedDoor:GetEntity():SetAngles(Angle(-10,45,0))
TFMENU.RedDoor:SetFOV(90)
TFMENU.RedDoor:GetEntity():SetSequence(1)
TFMENU.RedDoor.Entity = TFMENU.RedDoor:GetEntity()

TFMENU.RandomDoor = vgui.Create("DModelPanelNR")
TFMENU.RandomDoor:SetModel("models/vgui/ui_team01_Random.mdl")
TFMENU.RandomDoor:SetSize(ScrW() - 0.1,ScrH() - 0.1)
print(TFMENU.RandomDoor:GetLookAt())
TFMENU.RandomDoor:SetLookAt(Vector(0,0,35))
TFMENU.RandomDoor:GetEntity():SetAngles(Angle(-10,45,0))
TFMENU.RandomDoor:SetFOV(90)
TFMENU.RandomDoor:GetEntity():SetSequence(1)
TFMENU.RandomDoor.Entity = TFMENU.RandomDoor:GetEntity()


-- BUTTONS



 TFMENU.RandomDoor.Button = vgui.Create( "DButton" )
 TFMENU.RandomDoor.Button:SetPos( ScrW() * 0.20, ScrH() * 0.25 )
 TFMENU.RandomDoor.Button:SetSize(  ScrW() * 0.15 , ScrH() * 0.55)
 TFMENU.RandomDoor.Button:SetText( "" )
 TFMENU.RandomDoor.Button.DoClick = function(self)
  print("Yeah " .. type(self))
 end --
 TFMENU.RandomDoor.Button.OnCursorEntered = function(self)

  TFMENU.RandomDoor.Entity:SetSequence(2)
   surface.PlaySound("doors/generic_door_open.wav")
 end 

 TFMENU.RandomDoor.Button.OnCursorExited = function(self)
  TFMENU.RandomDoor.Entity:SetSequence(3)

   surface.PlaySound("doors/generic_door_close.wav")
 end 





 TFMENU.RedDoor.Button = vgui.Create( "DButton" )
 TFMENU.RedDoor.Button:SetPos( ScrW() * 0.63, ScrH() * 0.25 )
 TFMENU.RedDoor.Button:SetSize(  ScrW() * 0.15 , ScrH() * 0.55)
 TFMENU.RedDoor.Button:SetText( "" )
 TFMENU.RedDoor.Button.DoClick = function(self)
  print("Yeah " .. type(self))
 end --
 TFMENU.RedDoor.Button.OnCursorEntered = function(self)
  if (not TFMENU.Memory.RedDoor) then
  TFMENU.RedDoor.Entity:SetSequence(4)
   surface.PlaySound("doors/generic_door_open.wav")
  end
 end 

 TFMENU.RedDoor.Button.OnCursorExited = function(self)
  if (not TFMENU.Memory.RedDoor) then
  TFMENU.RedDoor.Entity:SetSequence(3)
  surface.PlaySound("doors/generic_door_close.wav")
  end

 end 
--



 TFMENU.BlueDoor.Button = vgui.Create( "DButton" )
 TFMENU.BlueDoor.Button:SetPos( ScrW() * 0.45, ScrH() * 0.25 )
 TFMENU.BlueDoor.Button:SetSize(  ScrW() * 0.15 , ScrH() * 0.55)
 TFMENU.BlueDoor.Button:SetText( "" )
 TFMENU.BlueDoor.Button.DoClick = function(self)
  print("Yeah " .. type(self))
 end --
 TFMENU.BlueDoor.Button.OnCursorEntered = function(self)
   if (not TFMENU.Memory.BlueDoor) then
 print("CESELF")
  TFMENU.BlueDoor.Entity:SetSequence(4)
   surface.PlaySound("doors/generic_door_open.wav")
   end

 end 

 TFMENU.BlueDoor.Button.OnCursorExited = function(self)
  if (not TFMENU.Memory.BlueDoor) then
  TFMENU.BlueDoor.Entity:SetSequence(3)
  surface.PlaySound("doors/generic_door_close.wav")
end
 end 


TFMENU.BlueDoor.Count = vgui.Create("DLabel")
TFMENU.BlueDoor.Count:SetPos(ScrW()*0.54,ScrH()*0.18)
TFMENU.BlueDoor.Count:SetFont("TF2FONT2")
TFMENU.BlueDoor.Count:SetText(TFMENU.Teams.Blue)
TFMENU.BlueDoor.Count:SetColor(Color(50,50,50,255))
TFMENU.BlueDoor.Count:SizeToContents()


TFMENU.RedDoor.Count = vgui.Create("DLabel")
TFMENU.RedDoor.Count:SetPos(ScrW()*0.72,ScrH()*0.18)
TFMENU.RedDoor.Count:SetFont("TF2FONT2")
TFMENU.RedDoor.Count:SetText(TFMENU.Teams.Red)
TFMENU.RedDoor.Count:SetColor(Color(50,50,50,255))
TFMENU.RedDoor.Count:SizeToContents()

TFMENU.RandomDoor.Count = vgui.Create("DLabel")
TFMENU.RandomDoor.Count:SetPos(ScrW()*0.222,ScrH()*0.18)
TFMENU.RandomDoor.Count:SetFont("TF2FONT2")
TFMENU.RandomDoor.Count:SetText("RANDOM")
TFMENU.RandomDoor.Count:SetColor(Color(50,50,50,255))
TFMENU.RandomDoor.Count:SizeToContents()





TFMENU.RedDoor.Button.DoClick= function(self)
  if (not TFMENU.Memory.RedDoor) then
  	RunConsoleCommand("changeteam","2")
  	TFMENU:RemoveMe()
  end
 end 

TFMENU.BlueDoor.Button.DoClick= function(self)
  if (not TFMENU.Memory.BlueDoor) then
  	RunConsoleCommand("changeteam","1")
  	TFMENU:RemoveMe()
  end
 end 

 TFMENU.RandomDoor.Button.DoClick= function(self)
  if (not TFMENU.Memory.RandomDoor) then
  	RunConsoleCommand("autoteam")
  	TFMENU:RemoveMe()
  end
 end 







timer.Create("TFMENU.UpdateTeams",0.05,0,function()
TFMENU.RedDoor.Count:SetText("" .. TFMENU.Teams.Red)
TFMENU.BlueDoor.Count:SetText("" .. TFMENU.Teams.Blue)

local COR_RED = TFMENU.Teams.Red > TFMENU.Teams.Blue
local COR_BLUE = TFMENU.Teams.Red < TFMENU.Teams.Blue

TFMENU.BlueDoor.Button:SetEnabled((not COR_BLUE) )
TFMENU.RedDoor.Button:SetEnabled((not COR_RED) )

if COR_RED then TFMENU.RedDoor.Entity:SetSequence(2) end
if COR_BLUE then TFMENU.BlueDoor.Entity:SetSequence(2) end

if COR_RED~=TFMENU.Memory.RedDoor then TFMENU.RedDoor.Entity:SetSequence(3)  end
if COR_BLUE~=TFMENU.Memory.BlueDoor then TFMENU.BlueDoor.Entity:SetSequence(3)  end

TFMENU.Memory.RedDoor = COR_RED
TFMENU.Memory.BlueDoor = COR_BLUE

TFMENU.Teams.Blue =  #team.GetPlayers(TEAM_BLUE)

TFMENU.Teams.Red = #team.GetPlayers(TEAM_RED)


	end)
end
function GM:HideTeam()
	TFMENU:RemoveMe()
end

	else 

function GM:ShowTeam()

	if ( IsValid(self.TeamSelectFrame) ) then return end
	
	-- Simple team selection box
	self.TeamSelectFrame = vgui.Create( "DFrame" )
	self.TeamSelectFrame:SetTitle( "Pick Team" )
	
	local AllTeams = team.GetAllTeams()
	local y = 30
	for ID, TeamInfo in pairs ( AllTeams ) do
	
		if ( ID != TEAM_CONNECTING && ID != TEAM_UNASSIGNED ) then
	
			local Team = vgui.Create( "DButton", self.TeamSelectFrame )
				function Team.DoClick() self:HideTeam() RunConsoleCommand( "changeteam", ID ) end
				Team:SetPos( 10, y )
				Team:SetSize( 130, 20 )
				Team:SetText( TeamInfo.Name )
				
			if (  IsValid( LocalPlayer() ) && LocalPlayer():Team() == ID ) then
				Team:SetDisabled( true )
			end
				
				y = y + 30
		
		end
		
	end

	if ( GAMEMODE.AllowAutoTeam ) then
	
		local Team = vgui.Create( "DButton", self.TeamSelectFrame )
		function Team.DoClick() self:HideTeam() RunConsoleCommand( "autoteam" ) end
		Team:SetPos( 10, y )
		Team:SetSize( 130, 20 )
		Team:SetText( "Auto" )
		y = y + 30
				
	end
	
	self.TeamSelectFrame:SetSize( 150, y )
	self.TeamSelectFrame:Center()
	self.TeamSelectFrame:MakePopup()
	self.TeamSelectFrame:SetKeyboardInputEnabled( false )

end

--[[---------------------------------------------------------
   Name: gamemode:HideTeam( )
   Desc: 
-----------------------------------------------------------]]
function GM:HideTeam()

	if ( IsValid(self.TeamSelectFrame) ) then
		self.TeamSelectFrame:Remove()
		self.TeamSelectFrame = nil
	end

end







end



	else 

--[[---------------------------------------------------------
   Name: gamemode:ShowTeam( )
   Desc: 
-----------------------------------------------------------]]
function GM:ShowTeam()

	if ( IsValid(self.TeamSelectFrame) ) then return end
	
	-- Simple team selection box
	self.TeamSelectFrame = vgui.Create( "DFrame" )
	self.TeamSelectFrame:SetTitle( "Pick Team" )
	
	local AllTeams = team.GetAllTeams()
	local y = 30
	for ID, TeamInfo in pairs ( AllTeams ) do
	
		if ( ID != TEAM_CONNECTING && ID != TEAM_UNASSIGNED ) then
	
			local Team = vgui.Create( "DButton", self.TeamSelectFrame )
				function Team.DoClick() self:HideTeam() RunConsoleCommand( "changeteam", ID ) end
				Team:SetPos( 10, y )
				Team:SetSize( 130, 20 )
				Team:SetText( TeamInfo.Name )
				
			if (  IsValid( LocalPlayer() ) && LocalPlayer():Team() == ID ) then
				Team:SetDisabled( true )
			end
				
				y = y + 30
		
		end
		
	end

	if ( GAMEMODE.AllowAutoTeam ) then
	
		local Team = vgui.Create( "DButton", self.TeamSelectFrame )
		function Team.DoClick() self:HideTeam() RunConsoleCommand( "autoteam" ) end
		Team:SetPos( 10, y )
		Team:SetSize( 130, 20 )
		Team:SetText( "Auto" )
		y = y + 30
				
	end
	
	self.TeamSelectFrame:SetSize( 150, y )
	self.TeamSelectFrame:Center()
	self.TeamSelectFrame:MakePopup()
	self.TeamSelectFrame:SetKeyboardInputEnabled( false )

end

--[[---------------------------------------------------------
   Name: gamemode:HideTeam( )
   Desc: 
-----------------------------------------------------------]]
function GM:HideTeam()

	if ( IsValid(self.TeamSelectFrame) ) then
		self.TeamSelectFrame:Remove()
		self.TeamSelectFrame = nil
	end

end

	--LocalPlayer():ChatPrint("Oh noeeesss: It appears you don't have tf2 installed, using default team menu instead.")

end




