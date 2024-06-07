use src::sorcerer::Sorcerer;
use src::sorcerer::Talent;


fn duel(ref sorcerer1: Sorcerer, ref sorcerer2: Sorcerer) {
    while sorcerer1.health > 0 && sorcerer2.health > 0 {
        apply_talent_and_cast_spell(ref sorcerer1, ref sorcerer2);
        apply_talent_and_cast_spell(ref sorcerer2, ref sorcerer1);

        stack_venom_if_applicable(ref sorcerer1, ref sorcerer2);
    }
}

fn apply_talent_and_cast_spell(ref target: Sorcerer, ref caster: Sorcerer) {
    match target.talent {
        Talent::Talentless => { apply_damage(ref target, ref caster); },
        Talent::Venomous => { apply_damage(ref target, ref caster); },
        Talent::Swift => {
            if (caster.attack < 4 && caster.attack != 0) {
                target.health = target.health - 1;
            } else {
                apply_damage(ref target, ref caster);
            }
        },
        Talent::Guardian => {
            if target.hasBeenDamaged == false {
                target.hasBeenDamaged = true;
            } else {
                apply_damage(ref target, ref caster);
            }
        },
    }
}
fn apply_damage(ref sorcerer1: Sorcerer, ref sorcerer2: Sorcerer) {
    if (sorcerer1.health <= sorcerer2.attack) {
        sorcerer1.health = 0;
    } else {
        sorcerer1.health = sorcerer1.health - sorcerer2.attack;
    }
}


fn stack_venom_if_applicable(ref sorcerer1: Sorcerer, ref sorcerer2: Sorcerer) {
    match sorcerer1.talent {
        Talent::Venomous => { sorcerer1.attack = sorcerer1.attack + 1; },
        _ => {},
    // Save space using above expression for useless Talent variants
    // Talent::Swift => {},
    // Talent::Guardian => {},
    // Talent::Talentless => {}
    }

    match sorcerer2.talent {
        Talent::Venomous => { sorcerer2.attack = sorcerer2.attack + 1; },
        Talent::Swift => {},
        Talent::Guardian => {},
        Talent::Talentless => {}
    }
}

