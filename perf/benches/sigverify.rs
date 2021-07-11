#![feature(test)]

extern crate test;

use panoptes_perf::packet::to_packets_chunked;
use panoptes_perf::recycler::Recycler;
use panoptes_perf::sigverify;
use panoptes_perf::test_tx::test_tx;
use test::Bencher;

#[bench]
fn bench_sigverify(bencher: &mut Bencher) {
    let tx = test_tx();

    // generate packet vector
    let mut batches = to_packets_chunked(&std::iter::repeat(tx).take(128).collect::<Vec<_>>(), 128);

    let recycler = Recycler::default();
    let recycler_out = Recycler::default();
    // verify packets
    bencher.iter(|| {
        let _ans = sigverify::ed25519_verify(&mut batches, &recycler, &recycler_out);
    })
}

#[bench]
fn bench_get_offsets(bencher: &mut Bencher) {
    let tx = test_tx();

    // generate packet vector
    let batches = to_packets_chunked(&std::iter::repeat(tx).take(1024).collect::<Vec<_>>(), 1024);

    let recycler = Recycler::default();
    // verify packets
    bencher.iter(|| {
        let _ans = sigverify::generate_offsets(&batches, &recycler);
    })
}
