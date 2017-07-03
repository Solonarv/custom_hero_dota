# Xirgil, the Fractured Shadow

Xirgil is a unique melee caster whose spells revolve around his shadows,
ephemeral clones of himself that are similar to illusions, but unlike them
can use his abilities and cannot attack.
 
## Abilities

### Essence Split
Generates three shadows and dashes to the target location.
One of the shadows is left behind at the former location; the other two
dash the same distance at a 120° angle.

| 20/16/12/8 second cooldown | 130/125/120/115 mana |
|---------|----------|
| Shadow duration | 2.5/3/3.5/4 seconds |
| Dash range | 600 |

### Shadow Nova
Xirgil and his shadows each release a nova, dealing magical damage
to nearby enemies. Enemies hit by multiple novas will take reduced damage
from each nova beyond the first.

| 12/10/8/6 second cooldown | 100/115/130/145 |
|---|---|
| Damage | 80/120/160/200 |
| Repeat damage | 20% |
| Radius | 325 |

### Fractal Rush
Xirgil and his nearby shadows dash through the target point, dealing
magical damage to enemies they collide with. If there are few nearby shadows,
Xirgil will generate several shadows before dashing.

 - The dash takes the same amount of time no matter how far the units travel
 - The units will reach the target point at the same time
 - Casting Essence Split during Fractal Rush creates three shadows
   that accompany the caster's rush instead of the normal behavior

| 18/15/12/9 second cooldown | 100/110/120/130 mana |
|---|---|
| Cast range | 400 |
| Shadow gather radius | 1300 |
| Minimum Shadow threshold | 1/2/3/4 |
| Shadow duration | 3/4/5/6 seconds |

### Fractured Self

**Passive:** Xirgil's spells manipulate his shadows. Those are illusion-like
clones of him that can't attack and take 100% damage, but can use his abilities.
Spell cooldowns are shared between Xirgil and all his shadows.  
**Active:** Xirgil instantly swaps places with the target shadow.

| 0.2 second cooldown | No cost |
| Swap range | 600 |

### Shatter

Xirgil and his nearby shadows become untargetable for a short duration,
then spread out near Xirgil's original position. Also creates a number of
new shadows.

| 120/110/100 second cooldown | 275/325/375 mana |
|-------|---------|
|Number of shadows | 4 8 12 |
|Shadow duration | 12 seconds |
| Shadow gather radius | 1300 |
| Spread radius | 625 |

*Xirgil's self shatters into a thousand pieces.*

## Design philosophy

This is the hero that got me started on the entire gamemode. I was trying to find a unique style of summon-based hero
that hadn't been done yet; I came up with a caster that used illusions to interact with his spells. The hero's title,
Fractured Shadow, came to me almost immediately, as did the concept of his illusions being able to cast his spells and
being able to switch places at will.

Shadow Nova was a rather straightforward ability to think of, so I don't have much to say about it.

The idea of a split-dash was also with the hero from the very beginning; it went through a few iterations, starting
with three dashes in roughly the same direction (think Mirana's new multi-shot arrow) and evolving to the current form
because I wanted the ability to be unclear about which dashing unit is the real Xirgil.

The ultimate, Shatter, is very natural as well; what else would an illusion-caster's ultimate be other than "create a
huge number of illusions"? The shuffle was added for aesthetic reasons, as a few illusions appearing in random spots
somewhere nearby doesn't really look like an ultimate.

Fractal Rush wasthe hardest to come up with; I was looking for a third basic ability, and I wanted it to be able to
truly manipulate his shadows as a whole, rather than having to rely on individual micro. The dash-through-a-point
mechanic is something that I hadn't seen anywhere else and it has synergy with his other abilities: with a few illusions
active (or even just the ones created by Fractal Rush itself), Rushing through an enemy and casting Shadow Nova just
as you pass through them is a strong, rewarding combo. More mechanically skilled players may even be able to squeeze in
an Essence Split before the Nova. Finally, there's the Shatter > Rush > Nova combo, which is reminiscent of Shadowfiend's
Eul's-Requiem combo (and likely also requires a scepter).