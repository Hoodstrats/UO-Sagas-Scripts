# UO-Sagas-Scripts
A collection of LUA scripts for UOSagas Assistant

## Some quirks with the current iteration of the Assistant as of 5-27-25
- Some of the GUMP serial numbers don't work when you try to use them
    - the BANK gump for example, this code snippet will not work: 
    ```LUA
    local backpackInBank = 1111470189

    if Gumps.WaitForGump(backpackInBank, 2000) then
        Messages.Overhead("Bank open?", 89, Player.Serial)
    end
    ```
- Another issue is that open GUMPS like the bank tab will remain "active" 
    - Example: you try and filter through items within the player's backpack but it will also filter the bank if 
    you have previously opened it. It pretty much stays in memory.
    ```LUA
    local filter = { onground = false, container = false, movable = true }
    local items = Items.FindByFilter(filter)
    local extraBackpack = 1111470189

    for i, item in ipairs(items) do
	if item.RootContainer == Player.Serial then
		if item.Name ~= nil and item.Layer == "Invalid" then
			if item.Type ~= ignoreItems[1] and item.Type ~= ignoreItems[2] then
				amount = amount + 1
				Messages.Overhead(("Found: " .. item.Name), 64, Player.Serial)
				Messages.Overhead(("Found: " .. item.Layer), 89, Player.Serial)
				Pause(100)
				Player.PickUp(item.Serial)
				Pause(100)
				Player.DropInContainer(extraBackpack)
				Pause(100)
			end
		end
	end
    end
    ```
    
    - That code snippet will try and still pickup items that are in your bank tab even if you're far away from it/closed
    it

- Some variables if they are being set LOCALLY will not work within the scope they're being used in, if they're 
not reinitialized within that same scope (particular While looped if statements)

- Some GUMP are missing serial numbers altogether/button ID such as the Multiple choice Moon Gates. Their check mark 
buttons do not have IDs (yet?)

