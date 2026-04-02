# tagpr-test

本リポジトリでは、[Songmu/tagpr](https://github.com/Songmu/tagpr) を用いたリリース自動化の手順をテストを行う。

Terraform module を想定している。

## tagpr とは

`tagpr` は、Git タグと GitHub Releases の作成を自動化するCLIツール。
GitHub Actions と組み合わせることで、Pull Request のマージをトリガーとした半自動的なリリースフローを構築できる。

## リポジトリ情報

### ブランチ戦略 (Github Flow)
`main` ブランチをデフォルトブランチとする **GitHub Flow** を採用。