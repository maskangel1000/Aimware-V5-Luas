--[[
	Visuals > ESP On Spotted
]]

local ref = gui.Tab(gui.Reference("Visuals"), "lua_tab", "ESP On Spotted")
local groupbox = gui.Groupbox(ref, "ESP On Spotted", 5, 20, 325, 350)

local isESPOnSpotted = gui.Checkbox(groupbox, "ESPOnSpotted", "ESP On Spotted", 0)
isESPOnSpotted:SetDescription("Toggle enemy ESP when spotted on radar.")

local isESPBox = gui.Checkbox(groupbox, "isESPBox", "Show Box", 0)
local colorESPBox = gui.ColorPicker(isESPBox, "colorESPBox", "", 255, 255, 255, 255)

local isESPName = gui.Checkbox(groupbox, "isESPName", "Show Name", 0)
local colorESPName = gui.ColorPicker(isESPName, "colorESPName", "", 255, 255, 255, 255)

local isESPHealth = gui.Checkbox(groupbox, "isESPHealth", "Show Health", 0)
local colorESPHealth = gui.ColorPicker(isESPHealth, "colorESPHealth", "", 255, 255, 255, 255)

local isESPWeapon = gui.Checkbox(groupbox, "isESPWeapon", "Show Weapon", 0)
local colorESPWeapon = gui.ColorPicker(isESPWeapon, "colorESPWeapon", "", 255, 255, 255, 255)

local function drawESP(builder)
    
    -- Check if enabled
    if not isESPOnSpotted:GetValue() then return end

    -- Check if builder is valid
    if not builder then return end

    -- Check if builderEntity is valid
    local builderEntity = builder:GetEntity()
    if not builderEntity then return end

    -- Check if entity is on opposite team
    local localPlayer = entities.GetLocalPlayer()
    if builderEntity:GetTeamNumber() == localPlayer:GetTeamNumber() then return end

    -- Check if entity is spotted
    if builderEntity:GetProp("m_bSpotted") == 1 then

        -- Box
        if isESPBox:GetValue() then

            builder:Color(colorESPBox:GetValue())
            builder:AddBarTop(1)
			builder:AddBarLeft(1)
			builder:AddBarRight(1)
			builder:AddBarBottom(1)

        end

        -- Name
        if isESPName:GetValue() then

            builder:Color(colorESPName:GetValue())
            builder:AddTextTop(builderEntity:GetName())

        end

        -- Health
        if isESPHealth:GetValue() then

            builder:Color(colorESPHealth:GetValue())
            builder:AddBarLeft(builderEntity:GetHealth() / builderEntity:GetMaxHealth())

        end

        -- Weapon
        local weapon = builderEntity:GetPropEntity("m_hActiveWeapon")

        if isESPWeapon:GetValue() then

            local weaponString = string.sub(tostring(weapon), string.find(tostring(weapon), "_") + 1, string.len(tostring(weapon)))

            builder:Color(colorESPWeapon:GetValue())
            builder:AddTextBottom(weaponString)

        end

    end

end

callbacks.Register("DrawESP", drawESP)