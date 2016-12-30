# Custom Hero Dota

## What is this?

Basically regular dota, but with all new, completely different heroes. See [docs/heroes](https://github.com/Solonarv/custom_hero_dota/tree/master/docs/heroes) for a list of them.

## How to play

Subscribe to the mod [here](https://steamcommunity.com/sharedfiles/filedetails/?id=713147757), install Dota 2 if you haven't already, and then start it just like any other custom game!

## How to develop

Get the Dota 2 Workshop Tools.

Once you've done that, go into `<steam folder>/steamapps/common/dota 2 beta/` and clone this repository by running the following from git-bash or a similar shell:

    git clone https://github.com/Solonarv/custom_hero_dota.git
    rm -r game content
    cmd setup.cmd # if this doesn't work, open the folder you're in and run setup.cmd as admin
    git checkout

This will install the mod in your workshop tools. The only thing missing is the map; it isn't included because of its size.

To get the map, navigate to `dota 2 beta/content/dota/maps` and copy `dota.vmap` to the mod's `content/maps` directory. Then, rename the file to something else, like `custom_700.vmap`.
