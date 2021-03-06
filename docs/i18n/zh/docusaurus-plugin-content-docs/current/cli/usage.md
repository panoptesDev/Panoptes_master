---
title: CLI 使用参考
---

[panoptes-cli crate](https://crates.io/crates/panoptes-cli) 为 Panoptes 提供了一个命令行界面工具

## 示例：

### 获取公钥

```bash
// 命令
$panoptes-keygen pubkey

// 返回
<PUBKEY>
```

### 空投 PANO/Lamports

```bash
// 命令
$ panoptes airdrop 2

// 返回
"2.0000000 PANO"
```

### 获取余额

```bash
// 命令
$ panoptes balance

// 返回
"3.00050001 PANO"
```

### 确认交易

```bash
// 命令
$ panoptes confirm <TX_SIGNATURE>

// 返回
"Confirmed" / "Not found" / "Transaction failed with error <ERR>"
```

### 部署程序

```bash
// 命令
$ panoptes deploy <PATH>

// 返回
<PROGRAM_ID>
```

## 使用方法
###
```text

```
