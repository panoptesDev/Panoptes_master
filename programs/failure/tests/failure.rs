use panoptes_runtime::bank::Bank;
use panoptes_runtime::bank_client::BankClient;
use panoptes_runtime::loader_utils::create_invoke_instruction;
use panoptes_sdk::client::SyncClient;
use panoptes_sdk::genesis_config::create_genesis_config;
use panoptes_sdk::instruction::InstructionError;
use panoptes_sdk::signature::Signer;
use panoptes_sdk::transaction::TransactionError;

#[test]
fn test_program_native_failure() {
    let (genesis_config, alice_keypair) = create_genesis_config(50);
    let program_id = panoptes_sdk::pubkey::new_rand();
    let bank = Bank::new(&genesis_config);
    bank.add_native_program("panoptes_failure_program", &program_id, false);

    // Call user program
    let instruction = create_invoke_instruction(alice_keypair.pubkey(), program_id, &1u8);
    let bank_client = BankClient::new(bank);
    assert_eq!(
        bank_client
            .send_and_confirm_instruction(&alice_keypair, instruction)
            .unwrap_err()
            .unwrap(),
        TransactionError::InstructionError(0, InstructionError::Custom(0))
    );
}
