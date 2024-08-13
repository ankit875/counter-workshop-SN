
#[starknet::interface]
pub trait ICounter<TContractState> {
    fn get_counter(self: @TContractState) -> u32;
}

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
    #[abi(embed_v0)]
    fn get_counter(self: ContractState) -> u32{
       let value = self.counter.read();
        value
    }
}