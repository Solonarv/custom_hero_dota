# Sonus, the Master of Tempo

## Abilities

### Acceleration Strike

> *Point Target*

Grants a charge of Acceleration and launches a slow-moving pulse of energy that damages enemies it passes through.
Acceleration grants attack speed per charge and causes attacks to reset Acceleration Strike's cooldown.
Casting Acceleration Strike while at maximum charges removes all charges.

| 10/9/8/7 second cooldown | 70 mana |
|---|---|
| Damage | 50 |
| Projectile speed | 600 + 150 per Acceleration charge |
| Attack speed per charge | 40 |
| Maximum charges | 3/4/5/6 |
| Charge duration | 2 seconds |

### Tempo Theft

> *Unit Target*

Steals an enemy's tempo, applying a debuff that damages them and grants Sonus attack speed when they attack,
or damages them and reduces Tempo Theft's cooldown when they cast a spell.

 - Spells that have no manacost or no cooldown do not trigger Tempo Theft.
 - If this spell consumes Crescendo charges, the damage bonus is applied to the entire debuff and the stun is applied
 when placing the debuff.

| 32/28/24/20 second cooldown | 100/110/120/130 mana |
|---|---|
| Debuff duration | 8 seconds |
| Damage per attack | 20/30/40/50 |
| Attack speed bonus | 20 |
| Attack speed bonus duration | 2 seconds (stacking) |
| Damage per cast | 80/120/160/200 |
| Cooldown reduction | 2 seconds |

### Crescendo

> *Passive*

Every time Sonus attacks the same target, he gains a charge of Crescendo.
Casting a spell consumes all Crescendo charges to deal bonus damage based on the number of charges.
If Crescendo is at full charges, the spell will additionally stun its targets.
Sonus cannot gain or consume Crescendo charges while Crescendo is on cooldown.

 - Enters cooldown when charges are consumed
 - If fewer than full charges are consumed, the cooldown is shortened

| 11/10/8/9 second cooldown | No cost |
|---|---|
| Maximum charges | 4 |
| Bonus damage per charge | 4%/5%/6%/7% |
| Stun duration | 0.8/1.2/1.6/2 seconds |

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