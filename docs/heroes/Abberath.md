# Abberath, the Cloven God

## Base stats

### Stats

| Stat | Base value |
|---|---|
| Movement Speed | **310** |
| Damage | **19-27** *(**41-49** with starting str)* |
| Base Attack Time | **1.8** *(slow)*|
| Attack Range | **150** *(melee)*|
| Attack point | **0.33** |
| Armor | **1** *(**2.8** with starting agi)* |
| Turn Rate | **0.8** *(fast)*|


### Attributes

| Strength | Agility | Intelligence |
|---|---|---|
| **22** + **2.1**/lvl | **13** + **1.8**/lvl | **24** + **2.6**/lvl |

## Abilities

### Meteor Storm

> *Ground Target, Channeled*

Abberath calls down a shower of meteors over the target area, growing in power as he channels.

 - Every 0.1 seconds while channeling, a meteor will strike a random location within the target area.
 - Meteor radius and meteor damage are each increased by 10% for every second spent channeling.
 - The channel time bonuses are applied linearly
 - Can hit units up to 766.8 units away (cast range + area radius + maximum meteor radius)

| 28/25/22/19 second cooldown | 90/100/110/120 mana + 10 per second |
|---|---|
| Maximum channel duration | 8 seconds |
| Area radius | 220 |
| Meteor radius | 20/22/24/26 |
| Damage per meteor | 10/13/16/19 + 30% of Strength |
| Cast range | 500 |

> *The fires that rent Abberath's soul now torment his foes.*

### Cloven Fury

> *Toggle*

Abberath's hooves shake the ground, damaging nearby enemies with each step he takes.

 - Triggers for every 50 units that Abberath moves under his own power (i.e. while not affected by any motion-controlling modifiers).
 - Does not trigger if Abberath moves more than 2000 units in 0.09 seconds.
 - Uses mana each time it triggers
 - Toggling does not interrupt other actions and can be done even while stunned, but not while silenced.

| No cooldown | No cost |
|---|---|
| Radius | 240/280/320/360 |
| Damage per 100 units | 6/8/10/12 |
| Mana cost per 100 units | 10/12/14/16 |

> *Abberath's enemies tremble at the sound of his hooves.*

### Heat Shroud

> *No target*

Abberath surrounds himself with a shield torrid air. If Abberath is damaged by a nearby enemy, the shroud reflects a portion of the damage back to the attacker. The shroud can only reflect a certain amount of damage.

| 50/38/26/14 second cooldown | 80/95/110/125 mana |
|---|---|
| Duration | 7/8/9/10 seconds |
| Reflect portion | 8/10/12/14% |
| Reflect radius | 240/280/320/360 |
| Shroud health | 80/100/120/140 + 40/50/60/70% of Strength |

> *An odd shimmer of heat surrounds the Cloven God, causing his foes' blows to turn against them.*

### Consume Soul

> *Ultimate*

Attempt to feast on the target's soul, instantly killing a non-ancient creep or dealing massive pure damage to a hero.
If the target is killed by Consume Soul, Abberath permanently gains bonus Strength. Heroes give **3** times as much Strength.

| 70/60/50 second cooldown | 175/225/275 mana |
|---|---|
| Damage | 350/450/550 + 3/4/5 * Strength |
| Cast range | 150 |
| Strength gained | 0.8/1.1/1.4 |

> *The Cloven God's hunger grows with each soul he consumes.*
