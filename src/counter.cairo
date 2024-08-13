#[starknet::contract]
mod counter_contract {
    #[storage]
    struct Storage {
        counter: u32,
    }
    #[constructor]
    fn constructor(ref self: ContractState, counter: u32) {
        self.counter.write(counter);
    }
}