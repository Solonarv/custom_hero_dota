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

| Item                    | Active effect                          | Base CD   | CD with talent | CD with talent + Core | Notes |
|-------------------------|----------------------------------------|-----------|----------------|-----------------------|-------|
| Abyssal Blade           | 2s stun                                | 35s       | 24.1s          | 13.8s | |
| Arcane Boots            | AoE restore 135 mana                   | 55s       | 37.9s          | 21.7s | 2.45/3.56/6.22 mana/sec |
| BKB (depleted)          | 5s spell immune and +100% magic resist | 55s       | 37.9s          | 21.7s | up to 23% BKB uptime    |
| Blade Mail              | 4.5s reflect 100% of dmg taken         | 20s       | 13.8s          | 7.9s | 22.5/32.6/56.9% uptime (that's a lot) |
| Blink Dagger            | Instant teleport to target location    | 12/3s     | 8.3/2.1s       | 4.7/1.2s | Very fast blink after taking dmg |
| Boots of Travel         | Teleport to building/creep/hero        | 45s       | 31s            | 17.8s | TP to fight > spam > TP out > repeat |
| Dagon                   | 400-800 instant magic damage           | 35-15s    | 24.1-10.3s     | 13.8-5.9s | |
| Ethereal Blade          | Magic dmg + 3s ethereal, 40% magic amp | 20s       | 13.8s          | 7.9s | high uptime, especially on self/ally (lasts 4s) |
| Eul's Scepter           | 2.5s cyclone                           | 23s       | 15.9s          | 9s   | |
| Force Staff             | 600 range push forward                 | 20s       | 13.8s          | 7.9s | |
| Ghost Scepter           | 4s self ethereal                       | 20s       | 13.8s          | 7.9s | high uptime (over 50%) |
| Glimmer Cape            | 5s invis + 45% magic res, can cast     | 14s       | 9.7s           | 5.5s | super high uptime, but casting disables invis/magicres for 0.6sec so not broken |
| Guardian Greaves        | AoE restore 160 mana + 250 health      | 40s       | 27.6s          | 15.8s | Can't actually use that often because of debuff |
| Hand of Midas           | Kill creep for 1.85x XP and 200 gold   | 100s      | 69s            | 39.5s | hard to keep spamming for that long/hard to use midas in a fight |
| Heaven's Halberd        | 5s ranged/3s melee disarm              | 18s       | 12.4s          | 7.1s | really high uptime against ranged |
| Hood/Pipe               | 12s 400 magic damage absorb            | 60s       | 41.4s          | 23.7s | quite spammable |
| Linken's Sphere         | Block a single-target spell            | 13s       | 9.0s           | 5.1s | actually really good |
| Lotus Orb     | Dispel, then for 6s reflect single-target spells | 15s       | 10.3s          | 5.9s | ~permanent Echo Shell, also really good |
| Magic Stick/Wand        | Restore 15 health + mana per charge    | 13s       | 9.0s           | 5.1s | too cheap, limited by charge gain anyway |
| Manta Style             | Dispel, disjoint, 2x 20s illusions  | 45s (ranged) | 31s            | 17.8s | permanent illusions, yay...? |
| Mekansm                 | AoE restore 250 health                 | 65s       | 44.8s          | 25.7s | just barely longer than the 25s debuff! |
| Mjollnir             | 15s shield: chance for lightning when hit | 35s       | 24.1s          | 13.8s | permanent shield |
| Necronomicon            | 50s summon Warrior and Archer          | 90s       | 62.1s          | 35.5s | EZ perma necro summons |
| Orchid/Bloodthorn | 5s silence + 30% dmg amp/+ truestrike + 100%chance 140%dmg crit | 18s | 12.4s | 7.1s | very high uptime, lot of extra damage |
| Refresher Orb           | Refresh all cooldowns                  | 195s      | 134.5s         | 77s | hard to spam for that long, and not needed since hero can already shorten cooldowns so much |
| Rod of Atos             | 2s root                                | 16s       | 11s            | 6.3s  | ....eh? maybe good? |
| Satanic                 | 4.5s +175% lifesteal                   | 35s       | 24.1s          | 13.8s | Tempo doesn't rightclick...? |
| Scythe of Vyse          | 3.5s hex                               | 22s       | 15.2s          | 8.7s  | hex good, more hex better. Also gives lots of mana. |
| Shiva's Guard           | AoE 4s 40% slow + 200 damage           | 30s       | 20.7s          | 11.8s | no crazy synergy, but shiva's is a nice item anyway |
| Soul Ring               | Lose 150 health, gain 150 temp mana    | 30s       | 20.7s          | 11.8s | 7.25/12.7 mana/sec, not really worth it |

Items left out:

 - Mask of Madness, because the silence renders Tempo near useless and prevents spamming to refresh cooldown anyway
 - Medaillon of Courage/Solar Crest, since their effects already have 100% uptime
 - Phase Boots, because come on
 - Shadow Blade/Silver Edge, because spamming to reduce the cooldown cancels the invis so it's pointless
 - Urn of Shadows, because doesn't stack + perma uptime + limited by charges
 
Conclusion: this talent is strong, but not massively busted.