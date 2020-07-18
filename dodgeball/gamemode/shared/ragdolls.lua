CreateConVar( "mp_keepragdolls", 1, { FCVAR_ARCHIVE, FCVAR_NOTIFY, FCVAR_REPLICATED } )

/*---------------------------------------------------------
   GetConVarBoolean
---------------------------------------------------------*/
function GetConVarBoolean( command )

	return tobool( GetConVarNumber( command ) )

end

function GetConVarBool( command )

	return tobool( GetConVarNumber( command ) )

end
