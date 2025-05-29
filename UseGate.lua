-- Use Moon Gate
-- Assign this to a hotkey in the Assistant
-- UO Sagas
-- github.com/Hoodstrats/UO-Sagas-Scripts

-- Our vars, change the delay to your liking
local gate = Items.FindByType(3948)

-- some gates don't have the same gump serial number like the newbie cave in adena
local gateGump = 585180759
local newbieCaveGump = 577307480

-- adjust this number to account for latency
local gumpDisplayDelay = 1000
-- adjust this number to account for latency
local pauseDelay = 200
local buttonID = 1

-- to help Primusmmo out
local distanceToGate = 1

-- Find a moongate within 1 tile
local function CheckForGate()
	local itemList = Items.FindByFilter({ rangemax = distanceToGate })
	for _, item in ipairs(itemList) do
		if item.Graphic == gate.Graphic then
			Messages.Overhead(("Found: " .. gate.Name), 64, Player.Serial)
			return item
		else
			Messages.Overhead("Not close enough to the Gate!!", 34, Player.Serial)
			return nil
		end
	end
end

local function UseGate()
	if CheckForGate() == nil then
		Messages.Overhead("Not close enough to the Gate!!", 34, Player.Serial)
		return
	end

	Player.UseObject(gate.Serial)
	-- small pause to let the game react
	Pause(pauseDelay)

	-- eliminate chat spam
	if Gumps.IsActive(gateGump) or Gumps.IsActive(newbieCaveGump) then
		return
	end

	if Gumps.WaitForGump(newbieCaveGump, gumpDisplayDelay) then
		-- add pause for when check box IDs are fixed
		-- Pause(pauseDelay)
		-- this will instead be 2 button presses 1 for the check box 1 for OK
		Gumps.PressButton(newbieCaveGump, buttonID)
	end

	if Gumps.WaitForGump(gateGump, gumpDisplayDelay) then
		-- add pause for when check box IDs are fixed
		-- Pause(pauseDelay)
		-- this will instead be 2 button presses 1 for the check box 1 for OK
		Gumps.PressButton(gateGump, buttonID)
	end
end

UseGate()
