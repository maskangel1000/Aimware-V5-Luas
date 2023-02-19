local ref = gui.Reference("Visuals", "Other")
local groupbox = gui.Groupbox(ref, "Defuse Kit ESP", 15, 420, 300, 350)

local isDefuseKitESP = gui.Checkbox(groupbox, "isDefuseKitESP", "Defuse Kit ESP", 0)
isDefuseKitESP:SetDescription("Display ESP for defuse kits.")

local isESPWhenPlayerHasDefuser = gui.Checkbox(groupbox, "isESPWhenPlayerHasDefuser", "ESP When Player Has Defuser", 0)
isESPWhenPlayerHasDefuser:SetDescription("Display ESP when you have a defuser.")

local isESPWhenBombNotPlanted = gui.Checkbox(groupbox, "isESPWhenBombNotPlanted", "ESP When Bomb Not Planted", 0)
isESPWhenBombNotPlanted:SetDescription("Display ESP when bomb is not planted.")

local isBombPlanted

local function checkEvent(Event)
    if Event:GetName() == "bomb_planted" then
        isBombPlanted = true
    elseif Event:GetName() == "round_officially_ended" then
        isBombPlanted = false
    end
end

local function drawESP()

    -- Check isDefuseKitESP
    if not isDefuseKitESP:GetValue() then return end

    -- Check isESPWhenPlayerHasDefuser
    local localPlayer = entities.GetLocalPlayer()
    if localPlayer:GetPropBool("m_bHasDefuser") and not isESPWhenPlayerHasDefuser:GetValue() then return end

    -- Check isESPWhenBombNotPlanted
    if not isESPWhenBombNotPlanted:GetValue() and not isBombPlanted then return end

    -- Get entities
    local defusers = entities.FindByClass("CEconEntity")
    for i=1, #defusers do

        -- Check if entity is defuser
		local defuser = defusers[i]
		if defuser:GetName() == "CEconEntity" then

            -- Get defuser location
			local defuserLocation = {client.WorldToScreen(defuser:GetAbsOrigin())}
            if defuserLocation[1] and defuserLocation[2] then

                local defuserX = defuserLocation[1]
                local defuserY = defuserLocation[2]
                
                draw.Text(defuserX-25, defuserY, "Defuser")

            end

		end

    end

end

client.AllowListener("bomb_planted")
client.AllowListener("round_officially_ended")

callbacks.Register("FireGameEvent", "checkEvent", checkEvent);
callbacks.Register("Draw", "EngineRadar", drawESP)