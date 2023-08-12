# Spawn Pallets Stacked!
Why do the pallets only spawn on one layer? NO LONGER! This script mod solves the issue of not enough pallets being able to be spawned in any (base-game or mod) production or husbandry spawn point! 

### Major Features:
- Spawn pallets stacked on each other, up to 2m. This will cause some pallets (ie: Wool) to spawn 2 high, and others (ie: Oils) to spawn up to 5 high!
- Automatic "Double Up" which will take any spawn point that is a single row, and if space allows - spawn two rows,with the same stacking! An example of this is the basegame Grain Mill - by default, this spawns 5 pallets. Now, it spawns 30!
- All basegame buildings have been tested and adjusted to work as expected.
- Mods will also get the same treatment, but will only do so if that mod doesn't already have stacked pallets.

### Advanced Features:
- Customizations! When the mod loads, it will create a `modSettings/SpawnPalletsStacked.xml` in your mod folder, with examples on how you can customize the settings
- Override the maximum height globally (if you want to go higher) within reason - limits at 4.0 m
- Override individual production or husbandries - sometimes the default "shift" when _Doubling Up_ will cause the new row to be too far back, too far forward, or not show up at all. Supports customizing the *DoubleUp* logic to keep your pallets centered in their spawn point.


## Installation Instructions
1. Download this package from ModHub or GitHub on the releases page, save the `FS22_SpawnPalletsStacked.zip` into your mod folder.
2. Launch the game, and activate the mod.
3. The first time the game launches with the mod active, it will create the appropriate config file in your `modSettings/` folder, which will look like this: 
```xml
<spawnPalletsStacked>
    <!-- The factor will be applied to the current rate (2000 litersPerHour) -->
    <overrideFactor>2.0</overrideFactor>

    <!-- OR you can force the output to any rate. A forceOutputTo value will take precedence  -->
    <!-- <forceOutputTo>5000</forceOutputTo> -->
</spawnPalletsStacked>
```
4. By default, the `overrideFactor` is set to `2.0` which means it will output `4000` liters per hour. If you want to change that value, you will have to exit the game, change the value, and re-enter the game.
5. If you don't want to do math, or want to do a strange number like `1234` liters per hour, you can use the `<forceOutputTo>1234</forceOutputTo>` value; make sure you uncomment the line or it won't take effect.

_Enjoy!_


### Thank You
Special thanks to [@loki79uk](https://github.com/loki79uk/) for help along the way building this and other upcoming mods - the code used here to write to and read from the config file was kindly shared from the [FS22_UniversalAutoload](https://github.com/loki79uk/FS22_UniversalAutoload) mod.