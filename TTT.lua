-- Tab

local ref = gui.Reference("Misc")
local tttTab = gui.Tab(ref, "tttTab", "TTT")

-- Killer List

local killerListGroupbox = gui.Groupbox(tttTab, "Killer List")
local killerListCheckbox = gui.Checkbox(killerListGroupbox, "killerListCheckbox", "Enable", false)
local displayNameEachKillCheckbox = gui.Checkbox(killerListGroupbox, "displayNameEachKillCheckbox", "Display Name Each Kill", false)
local killerListWidth = gui.Slider(killerListGroupbox, "killerListWidth", "Width", 200, 0, 1000, 1)
local killerListWindow = gui.Window("killerListWindow", "Killer List", 10, 10, killerListWidth:GetValue(), 65)

local killerList = {}

local function isKiller(killer)
    for i=1, #killerList do
        if killerList[i] == killer then
            return true
        end
    end
    return false
end

local function drawKillerList()
    if killerListCheckbox:GetValue() then
        killerListWindow:SetActive(true)
        killerListWindow:SetWidth(killerListWidth:GetValue())
        killerListWindow:SetHeight(65 + 25*(#killerList - 1))
    else
        killerListWindow:SetActive(false)
    end
end

callbacks.Register("Draw", "drawKillerList", drawKillerList)

-- Alive List

-- local aliveListGroupbox = gui.Groupbox(tttTab, "Alive List")
-- local aliveListCheckbox = gui.Checkbox(aliveListGroupbox, "aliveListCheckbox", "Enable", false)
-- local aliveListWidth = gui.Slider(aliveListGroupbox, "aliveListWidth", "Width", 200, 0, 1000, 1)
-- local aliveListWindow = gui.Window("aliveListWindow", "Alive List", 10, 10, aliveListWidth:GetValue(), 65)

-- local aliveList = {}

-- local function drawAliveList()
--     if aliveListCheckbox:GetValue() then
--         aliveListWindow:SetActive(true)
--         aliveListWindow:SetWidth(aliveListWidth:GetValue())
--         aliveListWindow:SetHeight(65 + 25*(#aliveList - 1))
--     else
--         aliveListWindow:SetActive(false)
--     end
-- end

-- callbacks.Register("Draw", "drawAliveList", drawAliveList)

-- Event Handler

local function eventHandler(event)
    if event:GetName() == "player_death" then
        local killer = client.GetPlayerNameByUserID(event:GetInt("attacker"))

        if not isKiller(killer) or displayNameEachKillCheckbox:GetValue() then
            table.insert(killerList, killer)
            local killerListText = gui.Text(killerListWindow, killer)
        end
    end
end

client.AllowListener("player_death")

callbacks.Register("FireGameEvent", eventHandler)