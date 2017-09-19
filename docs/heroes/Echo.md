# Io, the Eternal Echo

## Abilities

### Echo Strike

Io repeats its most recent instance of damage dealt to the target, inflicting a portion of the original damage once more.

| 22/18/14/10 second cooldown | 90/120/150/180 mana |
|---|---|
| Damage effectiveness | 40/50/60/70% |
| Cast range | 250/300/350/400 |

### Ripple

Io emits a wave of energy that expands across the entire battlefield, damaging and briefly revealing all enemy units hit. Deals less damage to more distant targets.

 - Uses exponential damage falloff: `damage = starting_damage * 2^(-distance/100)` (
 - Damages invisible units, but does not reveal them.

| 35 second cooldown | 80/95/110/125 mana |
|---|---|
| Starting damage | 220/330/440/550 |
| Reveal duration | 0.4 seconds |
| Expansion speed | 900/1110/1300/1500 |

### Resonance Cascade

> *Ultimate, No Target*

Sonus emits several waves of resonating sound that damage enemies they hit. If a hero is hit by a wave,
they will emit a weaker wave after a short delay. Waves that arrive during this delay are not echoed.
This effect can chain indefinitely.

 - If a hero takes less than 5 damage from a wave's impact, the wave is not echoed.
 - The first wave is emitted instantly, then every 0.6s afterwards.
 - If this spell consumes Crescendo charges, the damage bonus is applied to all hits, but the stun is only applied
   the first time each enemy is hit by this cast.

| 180/160/140 second cooldown | 225/350/475 mana |
|---|---|
| Damage per wave | 100 |
| Waves | 2/3/4 |
| Wave interval | 0.6 seconds |
| Echo delay | 0.4 seconds |
| Echo damage | 50%/60%/70% |