MineshaftBoost = {}
MineshaftBoost.path = g_currentModDirectory;
MineshaftBoost.modName = g_currentModName;
MineshaftBoost.internalSettingsFile = "defaultConfig.xml"
MineshaftBoost.userSettingsFile = "modSettings/MineshaftBoost.xml"
MineshaftBoost.xmlTag = 'mineshaftBoost'
MineshaftBoost.defaultFactor = 2.0
MineshaftBoost.boostComplete = false;
MineshaftBoost.validXMLFilename = 'placeables/productionPoints/miningShaftTower/miningShaftTower.xml'

--
function MineshaftBoost.initXml()
	MineshaftBoost.xmlSchema = XMLSchema.new(MineshaftBoost.xmlTag)
	MineshaftBoost.xmlSchema:register(XMLValueType.FLOAT, MineshaftBoost.xmlTag..".boostFactor", "The multiplication factor applied to the output", MineshaftBoost.defaultFactor)
    MineshaftBoost.xmlSchema:register(XMLValueType.STRING, MineshaftBoost.xmlTag..".forceOutputTo", "Force the output to a specific number", nil)
end
--
function MineshaftBoost.importUserConfigurations(userSettingsFile, overwriteExisting)

	if g_currentMission.isMultiplayer then
		print("-- MineshaftBoost: Custom configurations are not supported in multiplayer")
		return
	end

	if fileExists(userSettingsFile) then
        print("-- MineshaftBoost: IMPORT user settings file")
		MineshaftBoost.importGlobalSettings(userSettingsFile, overwriteExisting)
	else
		print("-- MineshaftBoost: CREATING user settings file")
		local defaultSettingsFile = Utils.getFilename(MineshaftBoost.internalSettingsFile, MineshaftBoost.path)
		copyFile(defaultSettingsFile, userSettingsFile, false)

		MineshaftBoost.globalFactor = MineshaftBoost.defaultGlobalFactor
	end
	return
end
--
function MineshaftBoost.importGlobalSettings(xmlFilename, overwriteExisting)
	local xmlFile = XMLFile.load("configXml", xmlFilename, MineshaftBoost.xmlSchema)
    if xmlFile ~= 0 then
    
        if overwriteExisting or not MineshaftBoost.globalSettingsLoaded then
            print("-- MineshaftBoost: IMPORT global settings")
            MineshaftBoost.globalSettingsLoaded = true
            MineshaftBoost.boostFactor = xmlFile:getValue(MineshaftBoost.xmlTag..".boostFactor", MineshaftBoost.defaultFactor)
            MineshaftBoost.forceOutputTo = xmlFile:getValue(MineshaftBoost.xmlTag..".forceOutputTo", nil)
            printf("    -- boostFactor: %2.1f", MineshaftBoost.boostFactor)
            printf("    -- forceOutputTo: %s", MineshaftBoost.forceOutputTo)
        end
        xmlFile:delete()
    end
end
--
function MineshaftBoost:speedBoost()
    -- Only update it once!
    if MineshaftBoost.boostComplete then
        return
    end

    local foundMineshaft = false

    -- Boost the mining MiningShaft
	if g_currentMission ~= nil and g_currentMission.placeableSystem and g_currentMission.placeableSystem.placeables then
        for v=1, #g_currentMission.placeableSystem.placeables do
			local thisPlaceable = g_currentMission.placeableSystem.placeables[v]
			
            -- Get the xml filename and owner
            local rawXMLFilename = thisPlaceable.storeItem.rawXMLFilename

            -- We only want the Mineshaft from the DLC
			if rawXMLFilename == MineshaftBoost.validXMLFilename then
                foundMineshaft = true

                -- Allow it to be placed
                thisPlaceable.storeItem.showInStore = true
                thisPlaceable.canBeDeleted = true

                -- Get the heapSpawner spec
				local spec_heapSpawner = thisPlaceable['spec_pdlc_forestryPack.heapSpawner']
				local orig_litersPerMs = spec_heapSpawner['spawnAreas'][1].litersPerMs
				local new_litersPerMs = nil

                -- If we have a forceOutputTo value, then calculate what the new litersPerMs should be
                if MineshaftBoost.forceOutputTo ~= nil then
                    printf("---- MineshaftBoost: Using forceOutputTo: %s", MineshaftBoost.forceOutputTo)
                    new_litersPerMs = MineshaftBoost.forceOutputTo / 3600000
                -- Otherwise use the override factor to update it
                elseif MineshaftBoost.boostFactor ~= nil then 
                    printf("---- MineshaftBoost: Using boostFactor: %2.1f", MineshaftBoost.boostFactor)
                    new_litersPerMs =  orig_litersPerMs * MineshaftBoost.boostFactor
                end

                -- Actually reset the value
				if new_litersPerMs ~= nil and new_litersPerMs > 0 then 
                    spec_heapSpawner['spawnAreas'][1].litersPerMs = new_litersPerMs
                end

				printf("---- MineshaftBoost: Output boosted to %s liters/hour",
						math.floor(new_litersPerMs * 3600000)
					)
			end 
		end
    end

    if foundMineshaft == false then 
        print("---- MineshaftBoost: Mineshaft not found on current map")
    end

    MineshaftBoost.boostComplete = true
end
--
function MineshaftBoost:loadXml()
	printf('-- MineshaftBoost: Load XML Settings')

	-- Initialize the xml structure
	MineshaftBoost.initXml()

	-- Load the user settings
	local userSettingsFile = Utils.getFilename(MineshaftBoost.userSettingsFile, getUserProfileAppPath())
	MineshaftBoost.importUserConfigurations(userSettingsFile)
end
--
function MineshaftBoost:init()
	print('-- MineshaftBoost: Initialize')

    -- We need the mission active before this can be called.
	Mission00.loadMission00Finished = Utils.appendedFunction(Mission00.loadMission00Finished, MineshaftBoost.loadXml)

    -- Boost the MiningShaft only after we have a baseMission
	FSBaseMission.registerActionEvents = Utils.appendedFunction(FSBaseMission.registerActionEvents, MineshaftBoost.speedBoost);	
end

MineshaftBoost.init()