--[[
	Visuals > Other > Extra
]]

local ref = gui.Reference("Visuals", "Other", "Extra")
local EngineRadar = gui.Checkbox(ref, "EngineRadar", "Engine Radar", 0)
EngineRadar:SetDescription("Display enemies on in-game radar.")

local function OnDraw()
	local isEngineRadar
	if EngineRadar:GetValue() then
		isEngineRadar = 1
	else
		isEngineRadar = 0
	end

	local players = entities.FindByClass("CCSPlayer")
	for i=1, #players do
		player = players[i]
		player:SetProp("m_bSpotted", isEngineRadar)
	end
end

callbacks.Register("Draw", "EngineRadar", OnDraw)