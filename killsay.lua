-- Killsays (CHANGE KILLSAYS HERE)
local killsays = {
    "sit",
    "L",
    "1"
}

-- Killsay function
local function CHAT_killsay(Event)
	if (Event:GetName() == "player_death") then
		local ME = client.GetLocalPlayerIndex()

		local INT_Victim = Event:GetInt("userid");
		local INDEX_Victim = client.GetPlayerIndexByUserID(INT_Victim);

		local INT_Attacker = Event:GetInt("attacker");
		local INDEX_Attacker = client.GetPlayerIndexByUserID(INT_Attacker);
		
		if (INDEX_Attacker == ME and INDEX_Victim ~= ME) then
            local killsayRandom = math.random(1, #killsays)

			client.ChatSay(killsays[killsayRandom])
		end
	end
end

client.AllowListener("player_death")
callbacks.Register("FireGameEvent", "killsay", CHAT_killsay)