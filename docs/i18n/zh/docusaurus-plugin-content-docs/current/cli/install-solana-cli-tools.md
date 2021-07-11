---
title: 安装 Panoptes 工具包
---

取决于您喜欢的工作公式，在电脑上安装 Panoptes 工具的方法有多种：

- [使用 Panoptes 的安装工具 (最简单的方法)](#use-panoptess-install-tool)
- [下载预置的二进制文件](#download-prebuilt-binaries)
- [通过源代码安装](#build-from-source)

## 通过 Panoptes 安装工具

### MacOS & Linux

- 打开您最喜欢的终端应用

- 通过运行下述指令，安装 Panoptes 版本[LATEST_PANOPTES_RELEASE_VERSION](https://github.com/panoptes-labs/panoptes/releases/tag/LATEST_PANOPTES_RELEASE_VERSION) 到您的机器：

```bash
sh -c "$(curl -sSfL https://release.panoptes.com/LATEST_PANOPTES_RELEASE_VERSION/install)"
```

- 您可以用 `LATEST_PANOPTES_RELEASE_VERSION` 发布标签替换想要的软件版本，或者使用以下三个通道名称之一： `stable`，`beta` 或 `edge`。

- 以下输出表示更新成功：

```text
downloading LATEST_PANOPTES_RELEASE_VERSION installer
Configuration: /home/panoptes/.config/panoptes/install/config.yml
Active release directory: /home/panoptes/.local/share/panoptes/install/active_release
* Release version: LATEST_PANOPTES_RELEASE_VERSION
* Release URL: https://github.com/panoptes-labs/panoptes/releases/download/LATEST_PANOPTES_RELEASE_VERSION/panoptes-release-x86_64-unknown-linux-gnu.tar.bz2
Update successful
```

- 根据您的系统，安装程序消息的结束可能稍有不同

```bash
请更新您的 PATH 环境变量来包含 Panoptes 程序：
```

- 如果您收到上述消息，复制并粘贴下面的推荐命令来更新 `PATH`
- 通过运行以下命令来确认您已经安装了想要的 `panoptes` 版本：

```bash
panoptes --version
```

- 安装成功后，就可以通过 `panoptes-install update` 随时更新 Panoptes 软件到新版本。

---

### Windows 系统

- 以管理员身份打开命令提示(`cmd.exe`)

  - 在 Windows 搜索栏中搜索命令提示。 当命令提示应用出现后，右键单击并选择“以管理员打开”。 如果弹出窗口请求“允许此应用进行设备更改？”，请点击是。

- 复制并粘贴以下命令，然后按回车下载 Panoptes 安装程序到临时目录：

```bash
curl https://release.panoptes.com/LATEST_PANOPTES_RELEASE_VERSION/panoptes-install-init-x86_64-pc-windows-msvc.exe --output C:\panoptes-install-tmp\panoptes-install-init.exe --create-dirs
```

- 复制并粘贴以下命令，然后按 Enter 安装最新版本的 Panoptes 软件。 如果系统弹出安全提示窗口，请选择允许程序运行。

```bash
C:\panoptes-install-tmp\panoptes-install-init.exe LATEST_PANOPTES_RELEASE_VERSION
```

- 安装程序完成后，请按 Enter 键。

- 关闭命令提示窗口，并以普通用户身份重新打开
  - 在搜索栏中搜索“Command Prompt”，然后点击命令提示应用图标，无需以管理员身份运行)
- 通过运行以下命令来确认您已经安装了想要的 `panoptes` 版本：

```bash
panoptes --version
```

- 安装成功后，就可以通过 `panoptes-install update` 随时更新 Panoptes 软件到新版本。

## 下载预置二进制文件

如果您不想通过 `panoptes-install` 来管理安装，您也可以手动下载并安装二进制安装包。

### Linux 系统

打开 [https://github.com/panoptes-labs/panoptes/releases/latest](https://github.com/panoptes-labs/panoptes/releases/latest), download **panoptes-release-x86_64-unknown-linux-msvc.tar.bz2** 地址，下载二进制文件，然后提取文件：

```bash
tar jxf panoptes-release-x86_64-unknown-linux-gnu.tar.bz2
cd panoptes-release/
export PATH=$PWD/bin:$PATH
```

### MacOS 系统

打开 [https://github.com/panoptes-labs/panoptes/releases/latest](https://github.com/panoptes-labs/panoptes/releases/latest), download **panoptes-release-x86_64-apple-darwin.tar.bz2** 地址，下载二进制文件，然后提取文件：

```bash
tar jxf panoptes-release-x86_64-apple-darwin.tar.bz2
cd panoptes-release/
export PATH=$PWD/bin:$PATH
```

### Windows 系统

- 打开 [https://github.com/panoptes-labs/panoptes/releases/latest](https://github.com/panoptes-labs/panoptes/releases/latest), download **panoptes-release-x86_64-pc-windows-msvc.tar.bz2** 地址，下载二进制文件，然后提取文件：

- 打开命令提示并导航到提取二进制文件的目录并运行：

```bash
cd panoptes-release/
set PATH=%cd%/bin;%PATH%
```

## 通过源代码安装

如果您无法使用预构建的二进制文件或者想通过源代码安装，请打开 [https://github.com/panoptes-labs/panoptes/releases/latest](https://github.com/panoptes-labs/panoptes/releases/latest), download **panoptes-release-x86_64-unknown-linux-msvc.tar.bz2** 地址，下载二进制文件，然后提取文件： 提取代码并生成二进制文件：

```bash
./scripts/cargo-install-all.sh .
export PATH=$PWD/bin:$PATH
```

然后你可以运行以下命令来获得与预置二进制文件相同的结果：

```bash
panoptes-install init
```
