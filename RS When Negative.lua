local function CHAT_ResetStats(Event)
	if (Event:GetName() == "player_death") then
		local me = client.GetLocalPlayerIndex()
		local victim = client.GetPlayerIndexByUserID(Event:GetInt("userid"))
		
		if (victim == me) then
        	local myKills = entities.GetPlayerResources():GetPropInt("m_iKills", client.GetLocalPlayerIndex())
        	local myDeaths = entities.GetPlayerResources():GetPropInt("m_iDeaths", client.GetLocalPlayerIndex())
			local myKDR = myKills/myDeaths

			if (myKDR < 1) then
				client.ChatSay("!rs")
			end
		end
	end
end

client.AllowListener("player_death")
callbacks.Register("FireGameEvent", "RsWhenNegative", CHAT_ResetStats)