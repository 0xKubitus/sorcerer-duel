#[derive(Copy, Drop)]
struct Sorcerer {
    attack: u8,
    health: u8,
    talent: Talent,
    hasBeenDamaged: bool,
}

// For Part 2...
#[derive(Copy, Drop)]
enum Talent {
    Talentless: (),
    Venomous: (),
    Swift: (),
    Guardian: ()
}

#[generate_trait]
impl SorcererImpl of SorcererTrait {
    fn new(attack: u8, health: u8) -> Sorcerer {
        Sorcerer {
            attack: attack, health: health, talent: Talent::Talentless(()), hasBeenDamaged: false
        }
    }

    // For Part 2...
    fn with_talent(attack: u8, health: u8, talent: Talent) -> Sorcerer {
        Sorcerer { attack: attack, health: health, talent: talent, hasBeenDamaged: false }
    }

    fn attack(self: @Sorcerer) -> u8 {
        *self.attack
    }
    fn health(self: @Sorcerer) -> u8 {
        *self.health
    }
    fn is_defeated(self: @Sorcerer) -> bool {
        *self.health == 0_u8
    }
}
