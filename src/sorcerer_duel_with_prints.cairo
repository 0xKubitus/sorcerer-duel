use src::sorcerer::Sorcerer;
use src::sorcerer::Talent;
use src::sorcerer::SorcererTrait;


fn carry_attack(ref attacker: Sorcerer, ref attackee: Sorcerer) {
    if attackee.health() > attacker.attack() {
        attackee.health -= attacker.attack();

        println!("=> attackee now has {} HP left", attackee.health);
        println!("");

    } else {
        attackee.health = 0;

        println!("=> attackee is dead");
        println!("");
    }
}

fn duel(ref sorcerer1: Sorcerer, ref sorcerer2: Sorcerer) {
    println!("A new duel begins!");
    println!("");

    println!(
        "sorcerer1.attack = {} / sorcerer1.health = {}", sorcerer1.attack, sorcerer1.health
    );
    println!(
        "sorcerer2.attack = {} / sorcerer2.health = {}", sorcerer2.attack, sorcerer2.health
    );
    println!("");

    // IMPLEMENT THIS FUNCTION
    while !(sorcerer1.is_defeated()) && !(sorcerer2.is_defeated()) {

        match sorcerer2.talent {
            Talent::Talentless(()) |
            Talent::Venomous(()) => {
                println!("================================");
                println!("sorcerer1 attacks sorcerer2");
                println!("sorcerer1 attack = {}", sorcerer1.attack);
                println!("sorcerer2 health before = {}", sorcerer2.health);
                println!("");

                carry_attack(ref sorcerer1, ref sorcerer2); // atttacket is sorcerer1

                println!("sorcerer2 health after = {}", sorcerer2.health);
                println!("================================");
                println!("");

            },
            Talent::Swift(()) => {
                if sorcerer1.attack() < 4 {
                    sorcerer2.health -= 1;
                } else {
                    carry_attack(ref sorcerer1, ref sorcerer2); // atttacket is sorcerer1
                }
            },
            Talent::Guardian(()) => { sorcerer2.talent = Talent::Talentless(()); }
        }

        // attacked: sorcerer1
        match sorcerer1.talent {
            Talent::Talentless(()) |
            Talent::Venomous(()) => {
                println!("================================");
                println!("sorcerer2 attacks sorcerer1");
                println!("sorcerer2 attack = {}", sorcerer2.attack);
                println!("sorcerer1 health before = {}", sorcerer1.health);
                println!("");

                carry_attack(ref sorcerer2, ref sorcerer1); // atttacket is sorcerer1

                println!("sorcerer1 health after = {}", sorcerer1.health);
                println!("================================");
                println!("");
            },
            Talent::Swift(()) => {
                if sorcerer2.attack() < 4 {
                    sorcerer1.health -= 1;
                } else {
                    carry_attack(ref sorcerer2, ref sorcerer1); // atttacket is sorcerer1
                }
            },
            Talent::Guardian(()) => { sorcerer1.talent = Talent::Talentless(()); }
        }

        match sorcerer1.talent {
            Talent::Venomous => { sorcerer1.attack += 1 },
            _ => {}
        }

        match sorcerer2.talent {
            Talent::Venomous => { sorcerer2.attack += 1 },
            _ => {}
        }

    };
    println!("DUEL IS OVER");
    println!("");
}
