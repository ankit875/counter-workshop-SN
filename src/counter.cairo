

#[starknet::interface]
pub trait ICounter<TContractState> {
    fn get_counter(self: @TContractState) -> u32;
    fn increase_counter(ref self: TContractState) -> ();
}

#[starknet::contract]
pub mod counter_contract {
    use core::starknet::event::EventEmitter;
    use starknet::ContractAddress;

    #[storage]
    struct Storage {
        counter: u32,
        kill_switch: ContractAddress,
    }

    #[event]
    #[derive(Drop, starknet::Event)]
    enum Event {
        CounterIncreased: CounterIncreased,
    }

    #[derive(Drop, starknet::Event)]
    struct CounterIncreased {
        #[key]
        counter: u32, 
    }

    #[constructor]
    pub fn constructor(ref self: ContractState, counter: u32,kill_switch: ContractAddress) {
        self.counter.write(counter);
        self.kill_switch.write(kill_switch);
    }
    #[abi(embed_v0)]
    impl IcounterImpl of super::ICounter<ContractState>{
        fn get_counter(self: @ContractState) -> u32{
            let value = self.counter.read();
            value
        }
        fn increase_counter(ref self: ContractState) -> (){
            let value = self.counter.read();
            self.emit(CounterIncreased{counter: value + 1});
        }
    }
}