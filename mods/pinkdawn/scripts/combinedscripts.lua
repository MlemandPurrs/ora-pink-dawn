
if Map.LobbyOption("growthrate") == "double" then
	Utils.Do(Map.NamedActors, function(actor)
	  if actor.Type == "split2" then
		actor.GrantCondition("double-growth")
	  end
	  if actor.Type == "split3" then
		actor.GrantCondition("double-growth")
	  end
	  if actor.Type == "splitblue" then
		actor.GrantCondition("double-growth")
	  end
	end)
elseif Map.LobbyOption("growthrate") == "triple" then
	Utils.Do(Map.NamedActors, function(actor)
	  if actor.Type == "split2" then
		actor.GrantCondition("triple-growth")
	  end
	  if actor.Type == "split3" then
		actor.GrantCondition("triple-growth")
	  end
	  if actor.Type == "splitblue" then
		actor.GrantCondition("triple-growth")
	  end
	end)
end

Levels =
{
	Multi0 = 0,
	Multi1 = 0,
	Multi2 = 0,
	Multi3 = 0,
	Multi4 = 0,
	Multi5 = 0,
	Multi6 = 0,
	Multi7 = 0,
	Multi8 = 0,
	Multi9 = 0,
	Multi10 = 0,
	Multi11 = 0,
	Multi12 = 0,
	Multi13 = 0,
	Multi14 = 0,
	Multi15 = 0,
}

Ranks = { "1", "2", "3", "4", "5", "6", "7" }
RankXPs = { 0, 800, 2400, 4800, 8000, 12000, 16800 }
--[[ RankXPs = { 0, 800, 1600, 2400, 3200, 4000, 4800 } ]]
PlayerCount = 16
Players = { }

WorldLoaded = function()
	for i=0, PlayerCount-1 do
		local player = Player.GetPlayer("Multi" .. i)
		if player then
			print("Added player Multi" .. i)
			table.insert(Players, player)
		else
			print("Player Multi" .. i .. " not valid. Skipping.")
		end
	end
	if Map.LobbyOption("dynamictechlevel") == "disabled" then
		for i,player in pairs(Players)
			do
				player.GrantCondition("no-dynamic-tech")

				--Media.DisplayMessage("Granted 'no-dynamic-tech' condition", "Options", HSLColor.Red)
			end
		end
	end

Tick = function()
	if Map.LobbyOption("dynamictechlevel") == "enabled" then
		TickScienceLevels()
    end
end

TickScienceLevels = function()
	for _,player in pairs(Players) do
		if player.IsLocalPlayer then
			if Levels[player.InternalName] < 6 then
				UserInterface.SetMissionText("Current Tech Level: " .. Ranks[Levels[player.InternalName] + 1] .. "\nNext Tech Level: " .. player.Experience - RankXPs[Levels[player.InternalName] + 1] .. "/" .. RankXPs[Levels[player.InternalName] + 2] - RankXPs[Levels[player.InternalName] + 1] .. "", HSLColor.White)
			else
				UserInterface.SetMissionText("Current Tech Level: " .. Ranks[Levels[player.InternalName] + 1] .. "\nMaximum Tech Level ", HSLColor.White)
			end
		end

		if player.Experience >= RankXPs[2] and not (Levels[player.InternalName] > 0) then
			Levels[player.InternalName] = Levels[player.InternalName] + 1

			Actor.Create("techlevel.2", true, { Owner = player })
		end

		if player.Experience >= RankXPs[3] and not (Levels[player.InternalName] > 1) then
			Levels[player.InternalName] = Levels[player.InternalName] + 1

			Actor.Create("techlevel.3", true, { Owner = player })
		end

		if player.Experience >= RankXPs[4] and not (Levels[player.InternalName] > 2) then
			Levels[player.InternalName] = Levels[player.InternalName] + 1

			Actor.Create("techlevel.4", true, { Owner = player })
		end

		if player.Experience >= RankXPs[5] and not (Levels[player.InternalName] > 3) then
			Levels[player.InternalName] = Levels[player.InternalName] + 1

			Actor.Create("techlevel.5", true, { Owner = player })
		end

		if player.Experience >= RankXPs[6] and not (Levels[player.InternalName] > 4) then
			Levels[player.InternalName] = Levels[player.InternalName] + 1

			Actor.Create("techlevel.6", true, { Owner = player })
		end

		if player.Experience >= RankXPs[7] and not (Levels[player.InternalName] > 5) then
			Levels[player.InternalName] = Levels[player.InternalName] + 1

			Actor.Create("techlevel.7", true, { Owner = player })
		end
	end
end
