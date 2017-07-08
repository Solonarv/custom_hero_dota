# Beholder, the Eye Tyrant

Large health pool
Low armor (zero)
290-ish base movement speed

## Abilities

Has a lot of spells
when you cast a spell, it is replaced by a random other spell from the pool.

### Fly

Beholder uses its power to hover in the air, granting it flying movement as long as it keeps spending mana.
 - Beholder does not need to skill this ability; it is granted at level 1.
 - Incurs its cooldown when toggled off.

| 10 second cooldown | 30 mana |
|---|---|
| Mana cost per second | 15 |
| Movement speed bonus | 25 |

### Random Slot 1

When the ability in this slot is used, it is replaced by the ability in Random Slot 2.
The ability in Random Slot 2 is replaced by the next ability from the Pool.

### Random Slot 2

When the ability in this slot is used, it replaces the ability in Random Slot 1.
This ability is replaced by the next ability from the Pool.
 
### Tyranny of Flesh

Beholder's power of the flesh is a source of raw power for its spells, allowing them to be used more often and increasing their destructive capabilities.
 - Max 7 points

| Passive | |
|---|---|
| Switch-in cooldown reduction | 1/2/3/4/5/6/7 |
| Spell damage | depends on the spell |

### Tyranny of Mind

Beholder's hegemony over all things mental increases the efficiency of its spells, granting additional reach and lengthening their debilitating effects.

| Passive | |
|---|---|
| Cast range | 30 per level |
| Effect duration | 14% per level |

### Anti-Magic Cone

Beholder emits a cone of anti-magic energy that dispels buffs and debuffs from all units caught in it. Enemies also have their mana burned and are silenced.
 - Dispel affects allies and enemies equally. Acts as a strong dispel when removing debuffs.
 - Mana burn deals magic damage equal to the amount of mana burned.

| 70/60/50 second cooldown | 175/225/275 mana |
|---|---|
| Mana burn | 200/275/350 |
| Silence duration | 1.5/1.75/2 seconds |
| Dispel type | Strong Dispel |

## Ability pool

### Charm

Take control of a neutral or enemy creep. Can be cast on heroes to slow them instead.

| 30 second cooldown | 120 mana |
|---|---|
| Dominate duration | 22 seconds |
| Slow duration | 3 seconds |
| Movement slow | 50% |

### Paralyze

Root an enemy in place.

| 26 second cooldown | 80 mana |
|---|---|
| Root duration | 2 seconds |

### Fear

Fill an enemy with fear, causing them to run towards their fountain.

| 40 second cooldown | 100 mana |
|---|---|
| Fear duration | 1.5 seconds |

### Slow
 
Slow an enemy's movement, dramatically reducing their attack and movement speed. The slow weakens over time.

| 22 second cooldown | 140 mana |
| Slow duration | 4 seconds |
| Movement speed slow | 100% |
| Attack speed slow | 50 + 20 per Tyranny of Flesh level |

### Innervation

Steal a target's vital energies, dealing damage and healing Beholder for the damage dealt.
 - Healing is equal to the health lost by the target.

| 20 second cooldown | 150 mana |
|---|---|
| Damage | 60 + 30 per Tyranny of Flesh level |

### Telekinesis

Telekinetically grip the target, slowing its movement speed by 50% for 1 second. While the target is slowed, recasting Telekinesis allows Beholder to push the target towards a target point. Doing so ends the slow.
 - The target is not disabled during the push.
 - This ability is not replaced until the slow ends or Beholder recasts it.
 - Increased duration from Tyranny of Mind does not affect this spell.

| 50 second cooldown | 130 mana |
|---|---|

### Sleep

Put a target enemy to sleep. preventing them from acting. Any damage will wake the target up.

| 35 second cooldown | 90 mana |
|---|---|
| Duration | 5 seconds |

### Petrification

Petrifies the target for 1 second, stunning it and rendering it immune to physical damage. Can be cast on allies and enemies.

| 20 second cooldown | 110 mana |
|---|---|
| Duration | 1 second |

### Disintegrate

Fires an unstoppable beam of energy that deals pure damage in a line and destroys trees.

| 40 second cooldown | 160 mana |
|---|---|
| Damage | 50 + 40 per Tyranny of Flesh level |
| Beam width | 70 + 4 per Tyranny of Mind level |

### Death Ray

Attempts to terminate the target's life, dealing moderate damage and instantly killing the target if its health is below a threshold.
 - Instant death is checked after the damage is done

| 55 second cooldown | 180 mana |
|---|---|
| Damage | 150 + 15 per Tyranny of Flesh level |
| Death threshold | 5% of maximum health or 100, whichever is higher |
