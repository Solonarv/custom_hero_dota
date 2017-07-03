# Flicker, the Eldritch Speedster

Flicker is an extremely mobile melee fighter based around
speed and Flash Step's charge mechanic.

She is inspired by the character Flicker from the
[Fall of Doc Future](http://docfuture.tumblr.com/post/82363551272/fall-of-doc-future-contents)
web novel. Her power is extreme speed, achieved by being able to
freely transfer momentum and entropy between herself and her
environment. If she has nothing to transfer momentum to, she can't
accelerate, slow down or change direction; if she has nothing to
dump entropy to, she heats up from the rapid movement and eventually
becomes radioactive.

## Abilities

### Flash Step

Flicker dashes to the target point at extreme speed, leaving behind a trace at her original location.


|0.5 second cooldown| 50 mana     |
|------------|-----|
| Cast range | 700 |
| Max charges | 3/4/4/5 |
| Charge recovery time | 15/13/11/9 |

### Stabilize

Flicker uses her environment to anchor herself, damaging and slowing all
nearby enemies. She also gains a charge for Flash Step, another charge for
each hero hit, and additional charges based on the number of non-heroes hit.

| 17/15/13/11 second cooldown | 90/105/120/135 mana |
|-----------------------------|---------------------|
| Radius | 425 |
| Damage | 100/150/200/250 |
| Movement slow | 25/30/35/40 %|
| Slow duration | 3 seconds |
| Non-hero hits required per charge | 4/3/2/2 |

### Rapid Strike

Flicker teleports to a target and attacks it several times from different
directions with greatly increased attack speed, then teleports back.

| 15/13/11/9 second cooldown | 120 mana |
|----|---|
| Number of attacks | 2/3/3/4 |
| Base attack time | 1.2/0.8/0.6/0.45 |

### Recall

Flicker instantly returns to the location of the newest trace, destroying
it in the process. Charges and cooldown are shared with Flash Step.

|0.5 second cooldown | 50 mana|
|---|---|

### Ascension

Flicker taps into her eldritch nature, gaining increased cast range for
Flash Step and Rapid Strike; increased radius for Stabilize; the ability
to Recall without using Flash Step charges; and refreshing the cooldowns
on Rapid Strike and Stabilize.

| 150/140/130 second cooldown | 225 mana |
|------|-----|
| Duration | 4/5/6 seconds|
| Radius/range increase | 50/70/90 % |


## Ability Design breakdown

Flash Step, a blink with an almost nonexistent cooldown, represents
Flicker's near-lightspeed movement; dangerous entropy buildup is
translated to a charge mechanic. This also serves to make the blink less
overpowered - even though it's a deviation from her power in the
books, where she can flit across half the world in a fraction of a second.

To recover some of that long-distance swiftness, she also has ability to
Recall to her previous location after a blink, which she can use multiple
times to 'rewind' multiple blinks.

Flicker's momentum/entropy transfer ability naturally gave rise to her
second ability, Stabilize. The more she catches in its radius, the more
she's able to recover from Flash Step usage; but even if nothing is nearby,
she can always do some transferring to the ground and gain at least some
charges back. This is again different from the books, where she exclusively
dumps entropy into inanimate objects (e.g. the ground) and always needs to
push off of something when moving.

Rapid Strike represents her primary combat tactic: use her speed to close
the distance, then punch really fast (usually this also means
punching hard, but bonus damage doesn't really fit her flavor). The return
element, while wholly absent from the original character, fits the ability
thematically.

Her ultimate is based on the source of her power, a being from a
dimension-travelling species; it represents her tapping into that being
to amplify her powers for a short duration. This manifests in increased
cast range, increased radius, and the ability to Recall with no charge cost.

Her primary attribute is of course agility; as the fragile-speedster
archetype demands, her strength is quite low and her intelligence is merely
adequate. She has very high movement speed and an unusually low base attack
time of 1.55s; this together with Rapid Strike allows her to scale quite
well as a right-click carry.