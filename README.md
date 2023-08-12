# Spawn Pallets Stacked!
Why do the pallets only spawn on one layer? NO LONGER! This script mod solves the issue of not enough pallets being able to be spawned in any (base-game or mod) production or husbandry spawn point! 

### Major Features:
- Spawn pallets stacked on each other, up to 2m. This will cause some pallets (ie: Wool) to spawn 2 high, and others (ie: Oils) to spawn up to 5 high!
- Automatic "Double Up" which will take any spawn point that is a single row, and if space allows - spawn two rows,with the same stacking! An example of this is the basegame Grain Mill - by default, this spawns 5 pallets. Now, it spawns 30!
- Spawning update applies to all Production buildings, Husbandries that spawn pallets (Chickens, Sheep, Bees), and Greenhouses.
- All base-game productions, husbandries & greenhouses have been tested and adjusted to work as expected.
- Related modded buildings will also get the same treatment, but will only do so if that mod doesn't already have stacked pallets.


### Advanced Features:
- Customizations! When the mod loads for the first time, it will create a `modSettings/SpawnPalletsStacked.xml` in your mod folder, with examples on how you can customize each of the settings
- Override the maximum height globally (if you want to go higher) within reason - limits at 5.0, customize the amount of space between _Double Up_ rows, between stacked rows and many more settings!
- Override individual production or husbandries - sometimes the default "shift" when _Doubling Up_ will cause the new row to be too far back, too far forward, or not show up at all. Supports customizing the _Double Up_ logic to keep your pallets centered in their spawn point.


## Installation Instructions
1. Download this package from ModHub or GitHub on the releases page, save the `FS22_SpawnPalletsStacked.zip` into your mod folder.
2. Launch the game, and activate the mod.
3. The first time the game launches with the mod active, it will create the appropriate config file in your `modSettings/` folder, which will look like this: 
```xml
<spawnPalletsStacked>
    <settings>
        <!--
            maxSpawnHeight: this sets the height to which pallets can spawn
            ~ minValue: 1.0 
            ~ maxValue: 5.0
            ~ default: 2.0
        -->
        <maxSpawnHeight>2.0</maxSpawnHeight>

        <!--
            layerOffset: how much of a gap is created between layers, this facilitates error-free spawning
            ~ minValue: 0.0 
            ~ maxValue: 0.5
            ~ default: 0.1
        -->
        <layerOffset>0.05</layerOffset>

        <!--
            shouldDoubleUp: Should the script automatically double up single row spawn points?
            ~ values: true/false
            ~ default: true
        -->
        <shouldDoubleUp>true</shouldDoubleUp>

        <!--
            doubleUpShift: If a single spawn row is detected, this sets the "shift" that is applied to the first row to accomodate two rows
            ~ minValue: 0.0 
            ~ maxValue: 1.5
            ~ default: 0.7
        -->
        <doubleUpShift>0.7</doubleUpShift>

        <!--
            doubleUpGap: This determines the spacing between the rows when a double up is applied; smaller numbers mean closer together rows
            ~ minValue: 0
            ~ maxValue: 1.0
            ~ default: 0.1
        -->
        <doubleUpGap>0.1</doubleUpGap>

        <!--
            minWidthToDoubleUp: When detecting the width to double up, the minimum "width" of the spawn area that will allow space enough for pallets to be doubled up.
            ~ minValue: 3.0 
            ~ maxValue: 5.0
            ~ default: 3.0
        -->
        <minWidthToDoubleUp>3.0</minWidthToDoubleUp>
    </settings>
</spawnPalletsStacked>
```
4. Each property has a default value, which matches the value if the entry is deleted. You can remove everything you don't need, or leave it there. Any value that you change will directly affect all spawn points next time you load a game.
5. The `adjustments` section is below `settings`, which allows you to apply the same settins, but only to a speficied building. This how you are able to "tweak" individual productions. 
```xml
<spawnPalletsStacked>
    <adjustments>
        <!-- 
            for each of the adjustments, there are multiple props that can be set. If a prop is not set (not included) then it will use deafult values.

            filename: The filename of the mod - the easiest way to get this is to either look in your log, or look in your savegame#/placeables file. The filename should match exactly. (the $ is not needed on $data)
            spawnHeight: The maxSpawnHeight for this specific placeable; description above. 
            doubleUpShift: Specifc to this mod, allows to tweak how the pallets spawn; description above.
            doubleUpGap: Specifc to this mod, allows to tweak how the pallets spawn; description above.
        -->
        <adjustment
            filename="FS22_noMansLand/placeables/sawmill/sawmill.xml"
            spawnHeight="3.0" 
        />

        <!-- base game production building example
        <adjustment
            filename="data/placeables/lizard/productionPoints/carpenterEU/carpenterEU.xml"
            doubleUpShift="0.6" 
        />
        -->

        <!-- dlc production building example
        <adjustment
            filename="pdlc_forestryPack/placeables/productionPoints/petAccessoriesFactory/petAccessoriesFactory.xml"
            shouldStack="false"
        />
        -->
    </adjustments>
</spawnPalletsStacked>
```

_Enjoy!_


### Thank You
Special thanks to [@loki79uk](https://github.com/loki79uk/) - the code used here to write to and read from the config file was kindly shared from the [FS22_UniversalAutoload](https://github.com/loki79uk/FS22_UniversalAutoload) mod.