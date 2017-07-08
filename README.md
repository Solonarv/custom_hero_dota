# Custom Hero Dota

## What is this?

Basically regular dota, but with all new, completely different heroes. See [docs/heroes](https://github.com/Solonarv/custom_hero_dota/tree/master/docs/heroes) for a list of them (including ones that haven't been implemented yet).

## How to play

Subscribe to the mod [here](https://steamcommunity.com/sharedfiles/filedetails/?id=713147757), install Dota 2 if you haven't already, and then start it just like any other custom game!

## How to develop

Get the Dota 2 Workshop Tools.

Once you've done that, go into `<steam folder>/steamapps/common/dota 2 beta/` and clone this repository by running the following command in any shell:

    git clone https://github.com/Solonarv/custom_hero_dota.git

If you want to run the addon in Dota 2 as well, you also need to:

 - Make sure you have Dota 2 and the Dota 2 Workshop Tools installed (obviously)
 - Create a new, empty addon with whatever name you want
 - Move the `game` folder's contents to `dota 2 beta/game/dota_addons/addon_name_here`
 - Move the `content` folder's contents to `dota 2 beta/content/dota_addons/addon_name_here`
 - Delete the `content` and `game` folders
 - In the Windows Command Prompt (`cmd.exe`), run the following commands to create directory junctions between the repository and Dota 2's files:
   ```batch
   mklink /j game C:\path\to\Steam\library\dota 2 beta\game\dota_addons\addon_name_here
   mklink /j content C:\path\to\Steam\library\dota 2 beta\content\dota_addons\addon_name_here
   ```
 - Done!

It may be possible to create a junction the other way around, but that didn't work when I tried it.
