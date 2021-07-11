#![feature(test)]

extern crate panoptes_core;
extern crate test;

use panoptes_core::consensus::Tower;
use panoptes_runtime::bank::Bank;
use panoptes_runtime::bank_forks::BankForks;
use panoptes_sdk::{
    pubkey::Pubkey,
    signature::{Keypair, Signer},
};
use std::sync::Arc;
use tempfile::TempDir;
use test::Bencher;

#[bench]
fn bench_save_tower(bench: &mut Bencher) {
    let dir = TempDir::new().unwrap();
    let path = dir.path();

    let vote_account_pubkey = &Pubkey::default();
    let node_keypair = Arc::new(Keypair::new());
    let heaviest_bank = BankForks::new(Bank::default()).working_bank();
    let tower = Tower::new(
        &node_keypair.pubkey(),
        vote_account_pubkey,
        0,
        &heaviest_bank,
        path,
    );

    bench.iter(move || {
        tower.save(&node_keypair).unwrap();
    });
}
