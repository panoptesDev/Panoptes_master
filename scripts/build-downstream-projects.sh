#!/usr/bin/env bash
#
# Builds known downstream projects against local panoptes source
#

set -e
cd "$(dirname "$0")"/..
source ci/_
source scripts/read-cargo-variable.sh

panoptes_ver=$(readCargoVariable version sdk/Cargo.toml)
panoptes_dir=$PWD
cargo="$panoptes_dir"/cargo
cargo_build_bpf="$panoptes_dir"/cargo-build-bpf
cargo_test_bpf="$panoptes_dir"/cargo-test-bpf

mkdir -p target/downstream-projects
cd target/downstream-projects

update_panoptes_dependencies() {
  declare tomls=()
  while IFS='' read -r line; do tomls+=("$line"); done < <(find "$1" -name Cargo.toml)

  sed -i -e "s#\(panoptes-program = \"\)[^\"]*\(\"\)#\1$panoptes_ver\2#g" "${tomls[@]}" || return $?
  sed -i -e "s#\(panoptes-program-test = \"\)[^\"]*\(\"\)#\1$panoptes_ver\2#g" "${tomls[@]}" || return $?
  sed -i -e "s#\(panoptes-sdk = \"\).*\(\"\)#\1$panoptes_ver\2#g" "${tomls[@]}" || return $?
  sed -i -e "s#\(panoptes-sdk = { version = \"\)[^\"]*\(\"\)#\1$panoptes_ver\2#g" "${tomls[@]}" || return $?
  sed -i -e "s#\(panoptes-client = \"\)[^\"]*\(\"\)#\1$panoptes_ver\2#g" "${tomls[@]}" || return $?
  sed -i -e "s#\(panoptes-client = { version = \"\)[^\"]*\(\"\)#\1$panoptes_ver\2#g" "${tomls[@]}" || return $?
}

patch_crates_io() {
  cat >> "$1" <<EOF
[patch.crates-io]
panoptes-client = { path = "$panoptes_dir/client" }
panoptes-program = { path = "$panoptes_dir/sdk/program" }
panoptes-program-test = { path = "$panoptes_dir/program-test" }
panoptes-sdk = { path = "$panoptes_dir/sdk" }
EOF
}

example_helloworld() {
  (
    set -x
    rm -rf example-helloworld
    git clone https://github.com/panoptes-labs/example-helloworld.git
    cd example-helloworld

    update_panoptes_dependencies src/program-rust
    patch_crates_io src/program-rust/Cargo.toml
    echo "[workspace]" >> src/program-rust/Cargo.toml

    $cargo_build_bpf \
      --manifest-path src/program-rust/Cargo.toml

    # TODO: Build src/program-c/...
  )
}

spl() {
  (
    set -x
    rm -rf spl
    git clone https://github.com/panoptes-labs/panoptes-program-library.git spl
    cd spl

    ./patch.crates-io.sh "$panoptes_dir"

    $cargo build
    $cargo test
    $cargo_test_bpf
  )
}

serum_dex() {
  (
    set -x
    rm -rf serum-dex
    git clone https://github.com/project-serum/serum-dex.git
    cd serum-dex

    update_panoptes_dependencies .
    patch_crates_io Cargo.toml
    patch_crates_io dex/Cargo.toml
    cat >> dex/Cargo.toml <<EOF
[workspace]
exclude = [
    "crank",
]
EOF
    $cargo build

    $cargo_build_bpf \
      --manifest-path dex/Cargo.toml --no-default-features --features program

    $cargo test \
      --manifest-path dex/Cargo.toml --no-default-features --features program
  )
}


_ example_helloworld
#_ spl
_ serum_dex
