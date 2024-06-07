use src::sorcerer::Sorcerer;
use src::sorcerer::Talent;
use src::sorcerer::SorcererTrait;


fn carry_attack(ref attacker: Sorcerer, ref attackee: Sorcerer) {
    if attackee.health() > attacker.attack() {
        attackee.health -= attacker.attack();
    } else {
        attackee.health = 0;
    }
}

fn duel(ref sorcerer1: Sorcerer, ref sorcerer2: Sorcerer) {
    // IMPLEMENT THIS FUNCTION
    while !(sorcerer1.is_defeated()) && !(sorcerer2.is_defeated()) {
        match sorcerer2.talent {
            Talent::Talentless(()) | Talent::Venomous(()) => {
                carry_attack(ref sorcerer1, ref sorcerer2); // atttacket is sorcerer1
            },
            Talent::Swift(()) => {
                if sorcerer1.attack() < 4 {
                    sorcerer2.health -= 1;
                } else {
                    carry_attack(ref sorcerer1, ref sorcerer2); // atttacket is sorcerer1
                }
            },
            Talent::Guardian(()) => {
                sorcerer2.talent = Talent::Talentless(());
            }
        }

        // attacked: sorcerer1
        match sorcerer1.talent {
            Talent::Talentless(()) | Talent::Venomous(()) => {
                carry_attack(ref sorcerer2, ref sorcerer1); // atttacket is sorcerer2
            },
            Talent::Swift(()) => {
                if sorcerer2.attack() < 4 {
                    sorcerer1.health -= 1;
                } else {
                    carry_attack(ref sorcerer2, ref sorcerer1); // atttacket is sorcerer1
                }
            },
            Talent::Guardian(()) => {
                sorcerer1.talent = Talent::Talentless(());
            }
        }

        match sorcerer1.talent {
            Talent::Venomous => {sorcerer1.attack += 1},
            _ => {}
        }

        match sorcerer2.talent {
            Talent::Venomous => {sorcerer2.attack += 1},
            _ => {}
        }
    }
}