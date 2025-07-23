// whats left of the body model system

/// Discards body model from limbs_id to find the mob's alternative sprite
#define GET_BODY_SPRITE(human) (human.dna.species.limbs_id)
/// Checks if the given human has a normal human body sprite
#define NORMAL_BODY_SPRITE(human) (GET_BODY_SPRITE(human) == "human")

