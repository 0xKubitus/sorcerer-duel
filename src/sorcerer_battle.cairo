use src::sorcerer::Sorcerer;
use src::sorcerer_duel::duel;
use src::sorcerer::SorcererTrait;


fn battle(ref team1: Array<Sorcerer>, ref team2: Array<Sorcerer>) {
    let mut sorcerer1: Sorcerer = *team1.at(0);
    let mut sorcerer2: Sorcerer = *team2.at(0);

    while team1.len() > 0 && team2.len() > 0 {

        duel(ref sorcerer1, ref sorcerer2);

        if sorcerer1.health() <= 0 {
            team1.pop_front().unwrap();
            
            println!("team1 lost 1 sorcerer");
            println!("");

            if !team1.is_empty() {
                sorcerer1 = *team1.at(0);

                println!("team1 brings a new sorcerer to the battle");
                println!("");
            }
        }

        if sorcerer2.health() <= 0 {

            println!("team2 lost 1 sorcerer");
            println!("");

            team2.pop_front().unwrap();

            if !team2.is_empty() {
                sorcerer2 = *team2.at(0);

                println!("team2 brings a new sorcerer to the battle");
                println!("");
            }
        }

    }

}
