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
