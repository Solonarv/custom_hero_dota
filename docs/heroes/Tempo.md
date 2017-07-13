# Tempo, the Master of the Arcane

Built around his ultimate, which reduces all other spells' cooldowns whenever he casts a spell.

## Abilities
### Force Wave

Tempo fires a wave of force that damages enemies it collides with and knocks them back.

| 8.75/8/7.25/6.5 second cooldown | 85/100/115/130 mana |
|---|---|
| Damage | 100/140/180/220 |
| Cast range | 600/650/700/750 |
| Knockback distance | 100 |
| Knockback duration | 0.2s |

 - possible talents/aghs upgrades:
   - add silence/disarm/root/slow/etc to the wave

### Arcane Mark
Applies an arcane mark to an enemy unit that deals periodic damage in an area around the target. When the mark deals damage,
it also spreads to a random nearby unaffected unit.

- Multiple applications of Arcane Mark stack fully
- Can only spread to the same enemy once per cast

| 10/9/8/7 second cooldown | 80/100/120/140 mana |
|---|---|
| Damage interval | 0.25s |
| Damage per tick | 18/22/26/30 |
| Duration | 2 seconds |
| Radius | 325/350/375/400 |

 - Deals damage once every 0.25 seconds 
 - possible talents/aghs upgrades:
   - can spread to allies (still only damages enemies)
   - spreads to all nearby targets/more than just one

### Augment
Tempo gains a surge of arcane power, adding damage to each hit he deals. The buff is removed one second after Tempo next casts a spell. Has 20% effectiveness on Arcane Mark.

| 6 second cooldown | 50/70/90/110 mana |
|---|---|
| Duration | 5/6/7/8 seconds |
| Added damage | 15/25/35/45 |

### Energy Flow

Tempo manipulates the flow of arcane energies around him, passively causing each spell cast to reduce his other spells' cooldowns.

| Passive | |
|---|---|
| Cooldown reduction | 1.25/1.5/1.75 seconds |

## Talents

| Level | | |
|---|---|---|
| 25 | +1 second Energy Flow Cooldown reduction; +50% mana cost | 30% of Energy Flow works on items |
| 20 | Force Wave silences and disarms | Arcane Mark can spread to and target allies |
| 15 | +8 Strength | +80 Cast Range |
| 10 | +200 mana | +15 movement speed |

## Math

Quick summary of cooldowns (assuming spells are maxed):

| Spell       | Cooldown | Cooldown with Octarine Core (25% CDR) |
|-------------|----------|---------------------------------------|
| Force Wave  | 6.5s     | 4.875                                 |
| Arcane Mark | 7.0s     | 5.25s                                 |
| Augment     | 6.0s     | 4.5s                                  |

Energy Flow effectively takes 2.5/3/3.5 (5.5 with lv25 talent) seconds off of each cooldown,
since Tempo can just rotate his three spells so each cast is followed by two other casts.

| Spell       | Effective Cooldown | Effective Cooldown with Octarine Core (25% CDR) |
|-------------|--------------------|-------------------------------------------------|
| Force Wave  | 4/3.5/3s           | 2.375/1.875/1.375 |
| Arcane Mark | 4.5/4/3.5s         | 2.75/2.25/1.75s |
| Augment     | 3.5/3/2.5s         | 2/1.5/1s |

Octarine Core provides an effective ~50% cooldown reduction on all three skills, basically doubling Tempo's
DPS output (while also doubling mana expenditure).

A full cycle costs 380 mana, and can be executed every 1.75 seconds. That's 217 mana/second.

### Level 25 talents

#### +1 second Energy Flow Cooldown reduction; +50% mana cost

With the level 25 talent `+1 second Energy Flow Cooldown reduction; +50% mana cost`, the cooldowns are as follows:

| Spell       | Effective Cooldown | Effective Cooldown with Octarine Core (25% CDR) |
|-------------|--------------------|-------------------------------------------------|
| Force Wave  | 1 second           | 0 seconds |
| Arcane Mark | 2.5 seconds        | 0 seconds |
| Augment     | 0.5 seconds        | 0 seconds |

A level 25 Tempo with Octarine Core (which is not a difficult item to acquire if you've made it to level 25) is thus *utterly terrifying*.

However, let's look at the mana expenditure.

A regular spell cycle costs 130 + 140 + 110 = 380 mana.

With the talent, this becomes 570 mana.

Assuming the player manages to perform 3 rotations per second (may not even be possible due to cast animations), each rotation does this much damage before spellamp:

| Spell | Damage | Augment damage |
|---|---|
| Force Wave | 220 | `3 * 45 =` 135 |
| Arcane Mark | `8 * 30 =` 240 | `3 * 0.2 * 8 * 45 =` 216 ^(\*) |
| Augment (total) (3 instances) | 351 | |
| Total | 811 |
| Total DPS | 2433 |

> \* Note: normally only half the Arcane Mark ticks are affected by Augment, but if Tempo is continuously casting 3 rotations per second he always has 3 Augment instances up.

This incredible damage comes at the cost of spending 1710 mana per second, which is beyond any mana regen that could reasonably be acquired. However, it is also enough to delete an enemy hero in ~6 rounds of casting, or ~2 seconds.

This seems sufficiently fair to remain in the hero's initial release.

#### 30% of Energy Flow works on items

Tempo casting at full speed can cast 3 spells every 3.5 seconds without Octarine Core, or every 1.75 seconds with the Core.

This talent grants a total of `0.3 * 3 * 1.75 =` 1.575s cooldown reduction per round of spells.

Without an Octarine Core, this means items lose 5.075 seconds of cooldown every 3.5 seconds; the equivalent of ~31% cooldown reduction.

With an Octarine Core, items lose 3.325 seconds of cooldown every 1.75 seconds; the equivalent of ~47% cooldown reduction. This pseudo-CDR stacks multiplicatively with the CDR from Octarine Core, resulting in a total of ~60% cooldown reduction.

Tabulating most active items with a cooldown, we get the following table:

| Item | Effect | Base CD | CD with talent | CD with talent + Octarine core |
|------|--------|---------|----------------|--------------------------------|
