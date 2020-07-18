	

    -- Project Name: Ultimate Dodgeball HUD
    -- Programmer: Vincent Lakatos (Mythikos)
     
    surface.CreateFont("UD_Font_Normal", {
            font = "Kill Em All",
            size = 18,
            weight = 500,
            antialias = true
    })
     
    surface.CreateFont("UD_Font_Small", {
            font = "Kill Em All",
            size = 14,
            weight = 500,
            antialias = true
    })
     
    surface.CreateFont("UD_Font_Large", {
            font = "Kill Em All",
            size = 20,
            weight = 500,
            antialias = true
    })
     
    local function DrawHUD()
            local x = ScrW()
            local y = ScrH()
     
            local HudPos = {}
     
            HudPos["BottomLeft"] = {
                    x = x * 0.000,
                    y = y * 0.900
            }
     
            HudPos["BottomRight"] = {
                    x = x * 0.900,
                    y = y * 0.900
            }
     
            HudPos["TopMiddle"] = {
                    x = x * 0.500,
                    y = y * 0.004
            }
     
            -- Prep Work
            local ply = LocalPlayer()
            local health = ply:Health()
            local armor = ply:Armor()
            local maxhealth = 100
            local maxarmor = 255
           
            -- Getting health ratios
            if health > maxhealth then maxhealth = health end
            if armor > maxarmor then maxarmor = armor end
            local healthratio = math.Round(health * 10 / maxhealth) / 10
            local armorratio = math.Round(armor * 10 / maxarmor) / 10
     
            -- Error checking
            if GAME then
     
                    -- More Error Checking
                    if GAME.Scores then
                            if not GAME.Scores.Red or not GAME.Scores.Blue then
                                    print("GAME.Scores.Red or GAME.Scores.Blue table missing - Setting values to zero to prevent error")
                                    GAME.Scores = {
                                            Red = 0,
                                            Blue = 0
                                    }
                            end
                    else
                            print("GAME.Scores table missing - Creating table and setting scores to zero")
                            GAME.Scores = {
                                    Red = 0,
                                    Blue = 0
                            }
                    end
     
                    if GAME.TeamWins then
                            if not GAME.TeamWins.Red or not GAME.TeamWins.Blue then
                                    print("GAME.TeamWins.Red or GAME.TeamWins.Blue table missing - Setting values to zero to prevent error")
                                    GAME.TeamWins = {
                                            Red = 0,
                                            Blue = 0
                                    }
                            end
                    else
                            print("GAME.TeamWins table missing - Creating table and setting scores to zero")
                            GAME.TeamWins = {
                                    Red = 0,
                                    Blue = 0
                            }
                    end
     
                    if not GAME.RoundTimeString then
                            print("GAME.RoundTimeString is missing - Creating a trash time to prevent error")
                            GAME.RoundTimeString = os.time()
                    end
     
                    -- More prep work
                    --local ball = ply:GetActiveWeapon().BallType
                    --local ballicon = BallMGR.BallTypes[Ball].Icon
                    local ballicon = "materials/ball_default.png"
           
                    local total = GAME.Scores.Red + GAME.Scores.Blue
                    local red = math.Clamp(200 * (GAME.Scores.Red / tonumber(total)) + 10, 0, 200)
                    local blue = math.Clamp(200 * (GAME.Scores.Blue / tonumber(total)) + 10, 0, 200)
     
                    local time = "Time Left  "..GAME.RoundTimeString
                    local time_w, time_h = surface.GetTextSize(time)
     
                    -- Draw scores 
                    draw.RoundedBox(8, HudPos["TopMiddle"].x - 125, HudPos["TopMiddle"].y, 250, 100, Color(0,0,0,150))
                    draw.RoundedBox(6, HudPos["TopMiddle"].x - 100, HudPos["TopMiddle"].y + 20, 200, 15, Color(0,0,0,150))
                    draw.RoundedBox(6, HudPos["TopMiddle"].x - 100, HudPos["TopMiddle"].y + 20, red, 15, Color(255,0,0,255))                       
                           
                    draw.RoundedBox(6, HudPos["TopMiddle"].x - 100, HudPos["TopMiddle"].y + 50, 200, 15, Color(0,0,0,150))
                    draw.RoundedBox(6, HudPos["TopMiddle"].x - 100, HudPos["TopMiddle"].y + 50, blue, 15, Color(0,0,255,255))
     
                    draw.DrawText("Red Score", "UD_Font_Small", HudPos["TopMiddle"].x - 115, HudPos["TopMiddle"].y + 12, Color(255,255,255,255), TEXT_ALIGN_LEFT )
                    draw.DrawText("Blue Score", "UD_Font_Small", HudPos["TopMiddle"].x - 115, HudPos["TopMiddle"].y + 42, Color(255,255,255,255), TEXT_ALIGN_LEFT )
                    draw.DrawText(time, "UD_Font_Small", HudPos["TopMiddle"].x - 60 * ((time_w * 0.8) / 125), HudPos["TopMiddle"].y + 80, Color(255,255,255,255), TEXT_ALIGN_LEFT )
     
                    -- Draw score history
                    draw.RoundedBox(8, HudPos["TopMiddle"].x - 180, HudPos["TopMiddle"].y, 50, 40, Color(150,0,0,200))
                    draw.RoundedBox(8, HudPos["TopMiddle"].x + 130, HudPos["TopMiddle"].y, 50, 40, Color(0,0,150,200))
     
                    draw.DrawText(tostring(GAME.TeamWins.Red), "UD_Font_Large", HudPos["TopMiddle"].x - 157, HudPos["TopMiddle"].y + 11, Color(255,255,255,255), TEXT_ALIGN_LEFT )
                    draw.DrawText(tostring(GAME.TeamWins.Blue), "UD_Font_Large", HudPos["TopMiddle"].x + 151, HudPos["TopMiddle"].y + 11, Color(255,255,255,255), TEXT_ALIGN_LEFT )
     
                    -- Is they alive?
                    if ply:Alive() then
                            -- Player Dodgeball Image
                            draw.RoundedBox(8, HudPos["BottomRight"].x, HudPos["BottomRight"].y - 50, 100, 100, Color(0,0,0,150))
                            surface.SetDrawColor( 255, 255, 255, 255 );
                            surface.SetMaterial(Material("materials/dodgeball/ball_default.png"))
                            surface.DrawTexturedRect(HudPos["BottomRight"].x + 10, HudPos["BottomRight"].y - 40, 80, 80)
     
                            -- Player Health
                            draw.RoundedBox(8, HudPos["BottomLeft"].x + 14, HudPos["BottomLeft"].y + 25, 250, 30, Color(0,0,0,150)) -- Health Bar Background       
                            draw.RoundedBox(8, HudPos["BottomLeft"].x + 14, HudPos["BottomLeft"].y + 25, math.Clamp(health or 100, 0, 100)*2.5*healthratio, 30, Color(102,9,9,255))
                                    draw.DrawText("Health: "..health or 0, "UD_Font_Normal", HudPos["BottomLeft"].x + 25, HudPos["BottomLeft"].y + 25, Color(255,255,255,255), TEXT_ALIGN_LEFT )
                           
                            -- Player Armor
                            if ply:Armor() > 0 then
                                    draw.RoundedBox(8, HudPos["BottomLeft"].x + 14, HudPos["BottomLeft"].y - 10, 250, 30, Color(0,0,0,150)) -- Armor Bar Background
                                    draw.RoundedBox(8, HudPos["BottomLeft"].x + 14, HudPos["BottomLeft"].y - 10, math.Clamp(health or 100, 0, 100)*2.5*armorratio, 30, Color(0,0,150,255))
                                            draw.DrawText("Armor: "..armor or 0, "UD_Font_Normal",  HudPos["BottomLeft"].x + 25, HudPos["BottomLeft"].y - 10, Color(255,255,255,255), TEXT_ALIGN_LEFT )
                            end
                    end
            else
                    print("GAME Table missing - Preventing HUDPaint")
            end
    end
    hook.Add("HUDPaint", "DrawHUD", DrawHUD)
     
    function HideElements(name)
            for _, v in pairs({"CHudHealth", "CHudBattery", "CHudAmmo", "CHudSecondaryAmmo"}) do
                    if name == v then return false end
            end
    end
    hook.Add("HUDShouldDraw", "HideElements", HideElements)

