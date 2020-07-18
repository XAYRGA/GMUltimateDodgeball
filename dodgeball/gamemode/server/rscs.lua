function AddDir(dir) // Recursively adds everything in a directory to be downloaded by client
	local f,d = file.Find(dir.."/*", "GAME")
	for _, fdir in pairs(d) do
		if fdir != ".svn" then
			AddDir(dir.."/"..fdir)
		end
	end
	for k,v in pairs(f) do
		resource.AddFile(dir.."/"..v)
	end
end


resource.AddFile( "models/weapons/w_dodgeball.dx80.vtx" )
resource.AddFile( "models/weapons/w_dodgeball.dx90.vtx" )
resource.AddFile( "models/weapons/w_dodgeball.mdl" )
resource.AddFile( "models/weapons/w_dodgeball.phy" )
resource.AddFile( "models/weapons/w_dodgeball.sw.vtx" )
resource.AddFile( "models/weapons/w_dodgeball.vvd" )

------------------------

resource.AddFile( "models/dodgeball/dodgeball.dx80.vtx" )
resource.AddFile( "models/dodgeball/dodgeball.dx90.vtx" )
resource.AddFile( "models/dodgeball/dodgeball.mdl" )
resource.AddFile( "models/dodgeball/dodgeball.phy" )
resource.AddFile( "models/dodgeball/dodgeball.sw.vtx" )
resource.AddFile( "models/dodgeball/dodgeball.vvd" )
resource.AddFile( "models/dodgeball/dodgeball.xbox.vtx" )

resource.AddFile( "materials/models/dodgeball/dodgeball_textured.vtf" )
resource.AddFile( "materials/models/dodgeball/dodgeball_textured.vmt" )
resource.AddFile("sound/dodgeball/ball_impact1.wav")
resource.AddFile("resource/fonts/Kill Em All.ttf")
resource.AddFile("sound/dodgeball/ball_impact2.wav")

resource.AddFile("sound/dodgeball/car.wav")
AddDir("sound/dodgeball/music")
AddDir("sound/dodgeball")
AddDir("sound/dodgeball/announcer")
