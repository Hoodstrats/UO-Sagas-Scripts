-- (scuffed) Grind healing skill using magical wizard hat
-- make sure you have bandages and a magical wizard hat
-- uo sagas
-- github.com/hoodstrats/uo-sagas-scripts

-- Magical Wizard Hat
local hat = Items.FindByType(5912)
-- Helmet I'm currently using Plate Helm
local originalHelm = Items.FindByType(5138)
-- The layer we're looking for (helmet)
local checkHelm = Items.FindByLayer(6)
-- good math from the folks over on the discord to not override the bandage timer
local seconds = math.floor((9.0 + 0.85 * ((130 - Player.Dex) / 20)))
-- heal level goal adjust if needed
local healGoal = 80

local function Main()
	while not Player.IsDead do
		if Skills.GetValue("Healing") < healGoal then
			if Player.Hits >= Player.HitsMax then
				Messages.Overhead("Looping...", 34, Player.Serial)
				if checkHelm == nil then
					Messages.Overhead("No helm found, equip a Helmet first.", 34, Player.Serial)
					return
				end
				Messages.Overhead("Equipping Magical Wizard Hat", 70, Player.Serial)
				Pause(2000)
				currentHelm = Items.FindByLayer(6)
				Player.PickUp(currentHelm.Serial)
				Player.DropInBackpack()
				Pause(2000)
				hat = Items.FindByType(5912)
				Player.Equip(hat.Serial)
				Pause(2000)
				currentHelm = Items.FindByLayer(6)
				Player.PickUp(currentHelm.Serial)
				Player.DropInBackpack()
				Pause(2000)
				originalHelm = Items.FindByType(5138)
				Player.Equip(originalHelm.Serial)
			else
				bandage = Items.FindByType(3617)
				if bandage == nil then
					Messages.Overhead("Out of bandages!", 32, Player.Serial)
				else
					Player.UseObject(bandage.Serial)
					if Targeting.WaitForTarget(2000) then
						Targeting.TargetSelf()
					end
					for i = seconds, 1, -1 do
						local message = i .. "s"
						Messages.Overhead(message, 70, Player.Serial)
						Pause(1000)
					end
				end
			end
			Pause(1000)
		else
			break
		end
	end
end
Messages.Overhead("Done grinding!", 64, Player.Serial)

Main()
