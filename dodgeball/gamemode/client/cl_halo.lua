hook.Add( "PreDrawHalos", "AddHalos", function()
	halo.Add( ents.FindByClass( "sent_powerup" ), Color( 255, 0, 0 ), 5, 5, 2 )
end )