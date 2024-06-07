use array::ArrayTrait;
use option::OptionTrait;

use src::sorcerer::{Sorcerer, SorcererTrait};

#[generate_trait]
impl TestSorcererImpl of TestSorcererTrait {
    fn assert_health(self: @Sorcerer, expected: u8) {
        assert(self.health() == expected, 'Unexpected Sorcerer: bad health');
        if expected == 0 {
            assert(self.is_defeated(), 'Unexpected Sorcerer: not dead');
        }
    }
}

//! You should try and see exactly what happens here,
//! by printing in your console the values that are being checked:
    //! -> what is the value of s1.health? what's the value of s2.health?
    //! -> what is the value of s1.attack? what's the value of s2.attack?
//! Observing this may give you a hint as to why are those values not matching.
fn assert_team(mut actual: Array<Sorcerer>, mut expected: Array<Sorcerer>) {
    assert(actual.len() == expected.len(), 'Unexpected team size');

    while (!actual.is_empty()) {
        let s1 = actual.pop_front().unwrap();
        let s2 = expected.pop_front().unwrap();

        assert(s1.health() == s2.health(), 'Unexpected sorcerer: bad health');
        assert(s1.attack() == s2.attack(), 'Unexpected sorcerer: bad attack');
    }
}

fn assert_defeated(actual: Array<Sorcerer>) {
    assert(actual.len() == 0, 'Unexpected team size');
}
