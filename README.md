# tagpr-test

本リポジトリでは、[Songmu/tagpr](https://github.com/Songmu/tagpr) を用いたリリース自動化の手順をテストを行う。

Terraform module を想定している。

## tagpr

### tagpr とは
`tagpr` は、Git タグと GitHub Releases の作成を自動化するCLIツール。
GitHub Actions と組み合わせることで、Pull Request のマージをトリガーとした半自動的なリリースフローを構築できる。

### tagpr について
`tagpr` は、マージされた Pull Request のラベルに基づいて、次期バージョン（Major/Minor/Patch）を自動的に計算する。

- **Major アップ**: Pull Request に `major` ラベルが付与されている場合
- **Minor アップ**: Pull Request に `minor` ラベルが付与されている場合
- **Patch アップ**: 上記のラベルがない場合（デフォルト）

## リポジトリ情報

### ブランチ戦略 (Github Flow)
`main` ブランチをデフォルトブランチとする **GitHub Flow** を採用。
