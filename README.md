# nix-devcontainer-integration

Nix と Dev Container を統合した、再現可能で一貫性のある開発環境の研究プロジェクトです。

## 概要

このリポジトリは、以下の技術を組み合わせた良質な開発環境の構築方法を研究しています：

- **Nix Flakes**: 再現可能なパッケージ管理と開発環境の宣言的定義
- **Dev Container**: VS Code での一貫したコンテナベース開発環境
- **direnv**: プロジェクトディレクトリへの移動時に自動的に環境を読み込み

## 特徴

- ✨ **再現可能**: Nix Flakes により、どの環境でも同一の開発環境を構築
- 🐳 **コンテナベース**: Dev Container によるクリーンで隔離された開発環境
- ⚡ **自動環境読み込み**: direnv による seamless な環境切り替え
- 🔧 **拡張可能**: プロジェクトごとのツール要件を柔軟に定義可能
- 🤖 **CI/CD 統合**: GitHub Actions による自動チェックとテスト

## 必要な環境

- [Docker](https://www.docker.com/)
- [Visual Studio Code](https://code.visualstudio.com/)
- [Dev Containers 拡張機能](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)

## クイックスタート

1. **リポジトリのクローン**

```bash
git clone https://github.com/msasaki666/nix-devcontainer-integration.git
cd nix-devcontainer-integration
```

2. **Dev Container で開く**

VS Code でプロジェクトを開き、コマンドパレット（`Cmd/Ctrl+Shift+P`）から：

```
Dev Containers: Reopen in Container
```

を選択します。

3. **開発環境の確認**

コンテナが起動すると、以下のツールが自動的に利用可能になります：

```bash
# direnv のバージョン確認
direnv --version

# Nix フォーマッターの確認
nixfmt --version

# 開発シェルに入る
nix develop
```

## プロジェクト構成

```
.
├── .devcontainer/
│   └── devcontainer.json    # Dev Container 設定
├── .github/
│   └── workflows/
│       └── ci.yml            # CI/CD パイプライン
├── .envrc                    # direnv 設定
├── flake.nix                 # Nix Flakes 定義
├── flake.lock                # Nix 依存関係のロックファイル
└── README.md                 # このファイル
```

## 主要ファイルの説明

### flake.nix

開発環境で使用するパッケージとシェル環境を定義します：

- **globalTools**: VS Code やグローバルに使用するツール（direnv、nixfmt-tree）
- **devShells.default**: `nix develop` で入る開発シェル環境

### .devcontainer/devcontainer.json

Dev Container の設定を定義します：

- ベースイメージ: Ubuntu Jammy
- Nix のインストールと設定（flakes と nix-command を有効化）
- コンテナ作成時に globalTools を自動インストール
- VS Code 拡張機能の自動インストール

### .envrc

direnv の設定で、プロジェクトディレクトリに入ると自動的に `nix develop` が実行されます。

## よくあるワークフロー

### Nix パッケージの追加

`flake.nix` の `globalTools` リストにパッケージを追加：

```nix
globalTools = with pkgs; [
  direnv
  nixfmt-tree
  # 新しいパッケージをここに追加
  git
  nodejs
];
```

その後、Dev Container を再ビルド：

```
Dev Containers: Rebuild Container
```

### フォーマットの実行

```bash
nix fmt
```

### Flake のチェック

```bash
nix flake check --show-trace
```

## CI/CD

GitHub Actions により、以下が自動的に実行されます：

- Nix Flakes の検証
- フォーマットチェック
- globalTools パッケージのビルド
- 開発シェルの動作確認

## トラブルシューティング

### direnv が動作しない

コンテナ内で手動で許可：

```bash
direnv allow
```

### Nix キャッシュの問題

キャッシュをクリア：

```bash
nix-collect-garbage -d
```

## 参考リンク

- [Nix Flakes](https://nixos.wiki/wiki/Flakes)
- [Dev Containers](https://code.visualstudio.com/docs/devcontainers/containers)
- [direnv](https://direnv.net/)

## ライセンス

このプロジェクトは研究目的で作成されています。

## 貢献

Issue や Pull Request は歓迎します。
