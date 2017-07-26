# Invoker, the Arsenal Mage

Same lore and concept as regular Invoker, but with a different approach to spellcasting.

## Abilities

Invoker's spells are broken up into three Domains. Invoker can focus on one domain at a time, recalling a different set of basic and ultimate spells. All abilities that occupy the same slot share cooldown and levels.

### Slot: Destroy

Invoker channels destructive power through his current Domain.

### Slot: Warp

Invoker warps aspects of reality related to his current Domain.

### Slot: Amplify/Create

Invoker amplifies or creates forces related to his current Domain.

### Cycle forward

Switches to the next Domain in Invoker's arsenal.

Switching Domains has no inherent cooldown, but Invoker cannot switch to the same Domain twice within 3 seconds.

### Cycle backward

Switches to the previous Domain in Invoker's arsenal.

Switching Domains has no inherent cooldown, but Invoker cannot switch to the same Domain twice within 3 seconds.

### Ultimate slot

One of Invoker's most powerful spells.

## Domain: Dimensionalism

### Phase

Invoker attacks his connection to space-time, allowing him to move through terrain and units unhindered. The terrainwalking only lasts a short time.

 - Also disjoints incoming projectiles on cast.
 - Grants Invoker the flying status for the terrainwalking duration.

| 20/17/14/11 second cooldown | 75/90/105/120 mana |
|---|---|
| Terrainwalking duration | 2 seconds |
| Unitwalking duration | 10/12/14/16 seconds |

### Time Warp

> *Unit target*

Invoker warps the flow of time around the target unit, speeding them up if allied or slowing them if enemy. The effect decays over time.

 - The attack speed and movement speed modifiers are proportional to the remaining duration, reaching zero when it expires.

| 18/16/14/12 second cooldown | 80/90/100/110 mana |
|---|---|
| Duration | 4/5/6/7 seconds |
| Movement speed lost/gained | 30/40/50/60% |
| Attack speed lost/gained | 40/70/100/130 |

### Unmoor

> *Point target, AoE*

Invoker creates a pocket dimension and wraps it around the target area, creating a dimensional boundary. Enemies that cross the boundary take damage and are stunned.

 - The damage and stun occur after an enemy enters or leaves the area by any means.
 - Can affect the same unit multiple times.

| 9 second cooldown | 120/130/140/150 mana |
|---|---|
| Radius | 325 |
| Duration | 4 seconds |
| Damage | 80/135/190/245 |
| Stun duration | 0.25/0.5/0.75/1 second |

### Gate

> *Ultimate, point target*

After channeling for *2/1.5/1* second, Invoker creates a Gate between his current location and the target location. Has a global cast range, but Invoker must have vision of the target location for the entire channel duration. Allies that step onto one end of the Gate are transported to the other end after standing still for 1/0.5/0.25 seconds.

Taking damage while channeling disrupts Invoker's concentration, interrupting the channel.

| 140/120/100 seconds cooldown | 300/400/500 mana |
|---|---|
| Channel duration | 2/1.5/1 seconds |
| Teleport delay | 1/0.5/0.25 seconds |
| Gate duration | 10/12/14 seconds |

## Domain: Divination

### Entropic Shield

Wraps the target unit in an entropic shield that selectively destroys information passing through it.

When cast on an ally, grants them invisibility and evasion. They can attack, use items or cast spells while invisible, but will be revelead for a short duration when doing so. During the first second of the invisibility, the ally cannot be revealed even by True Sight.

When cast on an enemy, sets their vision radius to zero and causes their attacks to miss. Both effects decay over time.

 - The vision reduction decays linearly, returning to normal by the end of the duration.
 - The miss chance decays linearly, reaching zero by the end of the duration.

| 20/17/14/11 second cooldown | 120/135/150/165 mana |
|---|---|
| Duration | 4/4.5/5/5.5 seconds |
| Ally fade time | 0.5/0.4/0.3/0.2 seconds |
| Miss chance | 100% |

### Shadowstep

Invoker slips into the shadows, becoming invisible.

If he was not visible to the enemy team upon casting, he additionally becomes unrevealable. While Invoker is unrevealable, he may recast Shadowstep to teleport to a location that is not visible to the enemy team, ending the invisibility.

 - Recasting Shadowstep has the same mana cost as the initial cast.

| 18/16/14/12 second cooldown | 90/100/110/120 mana |
|---|---|
| Invisibility duration | 5 seconds |
| Unrevealable duration | 1.5 seconds |
| Teleport cast range | 400/450/500/550 |

### Scry

Invoker scries the target area, gaining vision of it if it contains an enemy hero. Mana cost is based on Invoker's distance to the target area, halved if a hero is found.

| 9 seconds cooldown | 1 mana per 50 units |
|---|---|
| Vision duration | 2/2.5/3/3.5 seconds |
| Radius | 300/375/450/525 |

### Moment of Clarity

> *Ultimate*

Invoker briefly gains vision of the entire map, seeing even invisible units.

| 140/120/100 seconds cooldown | 250/400/550 mana |
|---|---|
| Duration | 2/3/4 seconds |

## Domain: Death

### Shatter Life

Expels life energy from the target enemy unit, dealing magic damage.

| 20/17/14/11 second cooldown | 80/95/110/125 mana |
|---|---|
| Damage | 100/170/240/310 |

### Reflect Harm

Warps the target's connection to death, causing a portion of damage dealt (if enemy) or taken (if ally) to be reflected back to the attacker.

| 18/16/14/12 second cooldown | 80/90/100/110 mana |
|---|---|
| Duration | 2/3/4/5 seconds |
| Reflect portion | 12/16/20/24% |

### Death Zone

Invoker creates a zone of deadly energy, dealing damage over time to enemies that stand in it. Multiple zones can overlap.

| 9 second cooldown | 100/115/130/145 mana |
|---|---|
| Duration | 12/15/18/21 seconds |
| Base damage per second | 10/15/20/25 |
| DPS per 100 maximum health | 0.8/1/1.2/1.4 |

### Touch of Death

> *Ultimate*

Invoker sacrifices a portion of his current mana to deal damage based on the mana lost.

| 140/120/100 second cooldown | 70/60/50% of current mana |
|---|---|
| Damage per mana | 0.75/0.85/1.05 |

## Talents

| Level | | |
|---|---|---|
| 25 |  |  |
| 20 |  |  |
| 15 |  |  |
| 10 |  |  |

## Aghanim's Scepter

When Invoker casts a spell, his spells from other domains in the same slot only incur 75% of their cooldown.

Switching domains has no cooldown or manacost.
