# Deadeye

Deadeye is inspired by Path of Exile's Deadeye class; or, more precisely, by what was at the time the most popular build with that class.

Lightning Arrow is almost identical to PoE's skill of the same name, if augmented in the usual way.

Blink Arrow is again lifted straight from the game, though the illusion-creation is currently left out because it was incredibly laggy.

Graceful Assault has no direct equivalent, though its effects thematically similar to PoE's effects of the same names.
 
Endless Munitions, finally, is inspired by the Deadeye class' passive skill of the same name,
which merely adds an extra projectile (to all attacks!) and increases area-of-effect radius. I've kept that theme, and added the ability to activate it and become able to spam Lightning Arrow, as befits the name.

## Abilities

### Lightning Arrow

Fires a piercing projectile that deals physical damage based on your attack damage to up to 3 nearby targets on impact. Deals half damage when jumping from creeps to heroes.

| 8/7/6/5 second cooldown | 50/45/40/35 mana |
|---|---|
| Attack damage scaling | 20/30/40/50% |
| Base damage | 25/20/15/10 |
| Chain radius | 250 |

### Blink Arrow

Fires an arrow at the target location that will teleport you there when it lands, dealing damage in an area.

**unimplemented:** Also leaves an illusion behind at your former location.

| 20/17/14/11 second cooldown | 120/105/90/75 mana |
|---|---|
| Damage | 75/150/225/300 |
| Radius | 325 |
| Illusion duration | 8 seconds |
| Illusion damage dealt | 30/35/40/45% |
| Illusion damage taken | 400/350/300/250% |

### Graceful Assault
**Passive:** You have 20% chance when dealing damage to gain a stack of Onslaught, which grants movement and attack speed. Cannot gain Onslaught while Grace is active.

**Active:** Consume all stacks of Onslaught and gain Grace for a duration based on the number of stacks consumed, which grants movement speed and evasion.

| 12 second cooldown | No cost |
|---|---|
| Onslaught duration | 4.0/4.75/5.5/6.25 seconds |
| Onslaught movement speed | 4/6/8/10 |
| Onslaught attack speed | 10/15/20/25 |
| Grace duration per stack | 3.5/4.0/4.5/5.0 seconds |
| Grace evade chance | 20/35/50/65% |
| Grace movement speed | 20/30/40/50% |

### Endless Munitions

**Passive:** Causes Lightning Arrow to fire additional projectiles, reduces the cooldowns on Lightning Arrow and Blink Arrow, and increases the radius of Lightning Arrow and Blink Arrow.

**Active:** Reduces Lightning Arrow mana cost by 80% and sets Lightning Arrow's cooldown to your attack time.

| 180/160/140 second cooldown | No cost |
|---|---|
| Active duration | 6/8/10 seconds |
| Extra arrows | 2/2/4 |