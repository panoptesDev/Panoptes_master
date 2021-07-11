---
title: Panoptes Clusters
---

Panoptes maintains several different clusters with different purposes.

Before you begin make sure you have first
[installed the Panoptes command line tools](cli/install-panoptes-cli-tools.md)

Explorers:

- [http://explorer.panoptes.com/](https://explorer.panoptes.com/).
- [http://panoptesbeach.io/](http://panoptesbeach.io/).

## Devnet

- Devnet serves as a playground for anyone who wants to take Panoptes for a
  test drive, as a user, token holder, app developer, or validator.
- Application developers should target Devnet.
- Potential validators should first target Devnet.
- Key differences between Devnet and Mainnet Beta:
  - Devnet tokens are **not real**
  - Devnet includes a token faucet for airdrops for application testing
  - Devnet may be subject to ledger resets
  - Devnet typically runs a newer software version than Mainnet Beta
- Gossip entrypoint for Devnet: `entrypoint.devnet.panoptes.com:8001`
- Metrics environment variable for Devnet:

```bash
export PANOPTES_METRICS_CONFIG="host=https://metrics.panoptes.com:8086,db=devnet,u=scratch_writer,p=topsecret"
```

- RPC URL for Devnet: `https://api.devnet.panoptes.com`

##### Example `panoptes` command-line configuration

```bash
panoptes config set --url https://api.devnet.panoptes.com
```

##### Example `panoptes-validator` command-line

```bash
$ panoptes-validator \
    --identity validator-keypair.json \
    --vote-account vote-account-keypair.json \
    --trusted-validator dv1LfzJvDF7S1fBKpFgKoKXK5yoSosmkAdfbxBo1GqJ \
    --no-untrusted-rpc \
    --ledger ledger \
    --rpc-port 8899 \
    --dynamic-port-range 8000-8010 \
    --entrypoint entrypoint.devnet.panoptes.com:8001 \
    --expected-genesis-hash EtWTRABZaYq6iMfeYKouRu166VU2xqa1wcaWoxPkrZBG \
    --wal-recovery-mode skip_any_corrupted_record \
    --limit-ledger-size
```

The `--trusted-validator`s is operated by Panoptes

## Testnet

- Testnet is where we stress test recent release features on a live
  cluster, particularly focused on network performance, stability and validator
  behavior.
- [Tour de PANO](tour-de-sol.md) initiative runs on Testnet, where we
  encourage malicious behavior and attacks on the network to help us find and
  squash bugs or network vulnerabilities.
- Testnet tokens are **not real**
- Testnet may be subject to ledger resets.
- Testnet includes a token faucet for airdrops for application testing
- Testnet typically runs a newer software release than both Devnet and
  Mainnet Beta
- Gossip entrypoint for Testnet: `entrypoint.testnet.panoptes.com:8001`
- Metrics environment variable for Testnet:

```bash
export PANOPTES_METRICS_CONFIG="host=https://metrics.panoptes.com:8086,db=tds,u=testnet_write,p=c4fa841aa918bf8274e3e2a44d77568d9861b3ea"
```

- RPC URL for Testnet: `https://api.testnet.panoptes.com`

##### Example `panoptes` command-line configuration

```bash
panoptes config set --url https://api.testnet.panoptes.com
```

##### Example `panoptes-validator` command-line

```bash
$ panoptes-validator \
    --identity validator-keypair.json \
    --vote-account vote-account-keypair.json \
    --trusted-validator 5D1fNXzvv5NjV1ysLjirC4WY92RNsVH18vjmcszZd8on \
    --trusted-validator 7XSY3MrYnK8vq693Rju17bbPkCN3Z7KvvfvJx4kdrsSY \
    --trusted-validator Ft5fbkqNa76vnsjYNwjDZUXoTWpP7VYm3mtsaQckQADN \
    --trusted-validator 9QxCLckBiJc783jnMvXZubK4wH86Eqqvashtrwvcsgkv \
    --no-untrusted-rpc \
    --ledger ledger \
    --rpc-port 8899 \
    --dynamic-port-range 8000-8010 \
    --entrypoint entrypoint.testnet.panoptes.com:8001 \
    --entrypoint entrypoint2.testnet.panoptes.com:8001 \
    --entrypoint entrypoint3.testnet.panoptes.com:8001 \
    --expected-genesis-hash 4uhcVJyU9pJkvQyS88uRDiswHXSCkY3zQawwpjk2NsNY \
    --wal-recovery-mode skip_any_corrupted_record \
    --limit-ledger-size
```

The identity of the `--trusted-validator`s are:

- `5D1fNXzvv5NjV1ysLjirC4WY92RNsVH18vjmcszZd8on` - Panoptes Foundation (testnet.panoptes.com)
- `7XSY3MrYnK8vq693Rju17bbPkCN3Z7KvvfvJx4kdrsSY` - Panoptes Foundation (Break RPC node)
- `Ft5fbkqNa76vnsjYNwjDZUXoTWpP7VYm3mtsaQckQADN` - Certus One
- `9QxCLckBiJc783jnMvXZubK4wH86Eqqvashtrwvcsgkv` - Algo|Stake

## Mainnet Beta

A permissionless, persistent cluster for early token holders and launch partners.
Currently, rewards and inflation are disabled.

- Tokens that are issued on Mainnet Beta are **real** PANO
- If you have paid money to purchase/be issued tokens, such as through our
  CoinList auction, these tokens will be transferred on Mainnet Beta.
  - Note: If you are using a non-command-line wallet such as
    [Solflare](wallet-guide/solflare.md),
    the wallet will always be connecting to Mainnet Beta.
- Gossip entrypoint for Mainnet Beta: `entrypoint.mainnet-beta.panoptes.com:8001`
- Metrics environment variable for Mainnet Beta:

```bash
export PANOPTES_METRICS_CONFIG="host=https://metrics.panoptes.com:8086,db=mainnet-beta,u=mainnet-beta_write,p=password"
```

- RPC URL for Mainnet Beta: `https://api.mainnet-beta.panoptes.com`

##### Example `panoptes` command-line configuration

```bash
panoptes config set --url https://api.mainnet-beta.panoptes.com
```

##### Example `panoptes-validator` command-line

```bash
$ panoptes-validator \
    --identity ~/validator-keypair.json \
    --vote-account ~/vote-account-keypair.json \
    --trusted-validator 7Np41oeYqPefeNQEHSv1UDhYrehxin3NStELsSKCT4K2 \
    --trusted-validator GdnSyH3YtwcxFvQrVVJMm1JhTS4QVX7MFsX56uJLUfiZ \
    --trusted-validator DE1bawNcRJB9rVm3buyMVfr8mBEoyyu73NBovf2oXJsJ \
    --trusted-validator CakcnaRDHka2gXyfbEd2d3xsvkJkqsLw2akB3zsN1D2S \
    --no-untrusted-rpc \
    --ledger ledger \
    --rpc-port 8899 \
    --private-rpc \
    --dynamic-port-range 8000-8010 \
    --entrypoint entrypoint.mainnet-beta.panoptes.com:8001 \
    --entrypoint entrypoint2.mainnet-beta.panoptes.com:8001 \
    --entrypoint entrypoint3.mainnet-beta.panoptes.com:8001 \
    --entrypoint entrypoint4.mainnet-beta.panoptes.com:8001 \
    --entrypoint entrypoint5.mainnet-beta.panoptes.com:8001 \
    --expected-genesis-hash 5eykt4UsFv8P8NJdTREpY1vzqKqZKvdpKuc147dw2N9d \
    --wal-recovery-mode skip_any_corrupted_record \
    --limit-ledger-size
```

All four `--trusted-validator`s are operated by Panoptes
