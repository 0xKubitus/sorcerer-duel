use src::sorcerer::SorcererTrait;
use core::array::ArrayTrait;
use core::box::BoxTrait;
use core::option::OptionTrait;
use src::sorcerer::Sorcerer;
use src::sorcerer_duel::duel;

fn battle(ref team1: Array<Sorcerer>, ref team2: Array<Sorcerer>,) {
    // Initialize counter of losses for each team
    let mut team1_losses = 0;
    let mut team2_losses = 0;

    // Initialize the first sorcerers from each team
    let mut sorcerer1 = get_sorcerer(ref team1, ref team1_losses);
    let mut sorcerer2 = get_sorcerer(ref team2, ref team2_losses);

    loop {
        // Run a duel between the current sorcerers
        duel(ref sorcerer1, ref sorcerer2);

        // Check if sorcerer1 has lost their duel
        if sorcerer1.is_defeated() {
            // Increase the counter of team1_losses
            team1_losses = team1_losses + 1;

            // if there are still sorcerers in the team...
            if team1_losses != team1.len() {
                // ...fetch another sorcerer for next duel
                sorcerer1 = get_sorcerer(ref team1, ref team1_losses)
            }
        }

        // Check if sorcerer2 has lost their duel
        if sorcerer2.is_defeated() {
            // Increase the counter of team2_losses
            team2_losses = team2_losses + 1;

            // if there are still sorcerers in the team,
            // fetch another sorcerer for next duel
            if team2_losses != team2.len() {
                sorcerer2 = get_sorcerer(ref team2, ref team2_losses)
            }
        }

        // This is the case where team2 wins the battle
        if (team1_losses == team1.len() && team2_losses != team2.len()) {
            let mut team2_survivors = ArrayTrait::new();

            reform_ranks(ref team2, ref team2_survivors, ref team2_losses, ref sorcerer2);

            team2 = team2_survivors;
            team1 = ArrayTrait::new();
            break;
        }

        // This is the case where team1 wins the battle
        if (team2_losses == team2.len() && team1_losses != team1.len()) {
            let mut team1_survivors = ArrayTrait::new();

            reform_ranks(ref team1, ref team1_survivors, ref team1_losses, ref sorcerer1);

            team1 = team1_survivors;
            team2 = ArrayTrait::new();
            break;
        }

        // This is a draw (all sorcerers from both teams are dead at the end of the battle)
        if (team2_losses == team2.len() && team1_losses == team1.len()) {
            team1 = ArrayTrait::new();
            team2 = ArrayTrait::new();
            break;
        }
    }
}

fn reform_ranks(
    ref team: Array<Sorcerer>,
    ref reorganized_team: Array<Sorcerer>,
    ref index: u32,
    ref sorcerer: Sorcerer
) {
    reorganized_team.append(sorcerer);
    index += 1;

    while index < team.len() {
        reorganized_team.append(get_sorcerer(ref team, ref index));
        index += 1;
    };
}

fn get_sorcerer(ref team: Array<Sorcerer>, ref index: u32) -> Sorcerer {
    *team.get(index).unwrap().unbox()
}
