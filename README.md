# Mineshaft BOOST!
If you've felt like the Mineshaft is a bit too slow (or to fast, depending on how you play), this mod is for you. This simple script mod creates a configuration file in your `modSettings` folder called `MineshaftBoost.xml` which will allow you to set the speed of how fast the Mineshaft produces `IronOre`.


## Installation Instructions
1. Download this package from GitHub on the releases page, save the [`FS22_MineshaftBoost.zip` ] into your mod folder.
2. Launch the game, and activate the mod.
3. The first time the game launches with the mod active, it will create the appropriate config file in your modSettings folder, looking like this: 
```xml
<mineshaftBoost>
    <!-- The factor will be applied to the current rate (2000 litersPerHour) -->
    <overrideFactor>2.0</overrideFactor>

    <!-- OR you can force the output to any rate. A forceOutputTo value will take precedence  -->
    <!-- <forceOutputTo>5000</forceOutputTo> -->
</mineshaftBoost>
```
4. By default, the `overrideFactor` is set to `2.0` which means it will output `4000` liters per hour. If you want to change that value, you will have to exit the game, change the value, and re-enter the game.
5. If you don't want to do math, or want to do a strange number like `1234` liters / hour, you can use the `<forceOutputTo>1234</forceOutputTo>` value; make sure you uncomment the line or it won't take effect.

Enjoy!


### Thank You
Special thanks to [@loki79uk](https://github.com/loki79uk/) for help along the way building this and other upcoming mods - the code used here to write to and read from the config file was kindly shared from the [FS22_UniversalAutoload](https://github.com/loki79uk/FS22_UniversalAutoload) mod.