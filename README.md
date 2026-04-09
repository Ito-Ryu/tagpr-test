# tagpr-test

本リポジトリでは、[Songmu/tagpr](https://github.com/Songmu/tagpr) を用いたリリース自動化の手順をテストを行う。

Terraform module を想定している。

## tagpr

### 概要
`tagpr` は、Git タグと GitHub Releases の作成を自動化するCLIツール。
GitHub Actions と組み合わせることで、Pull Request のマージをトリガーとした半自動的なリリースフローを構築できる。

### Semantic Versioning
`tagpr` は、マージされた Pull Request のラベルに基づいて、次期バージョン（Major/Minor/Patch）を自動的に計算する。

- **Major アップ**: Pull Request に `major` ラベルが付与されている場合
- **Minor アップ**: Pull Request に `minor` ラベルが付与されている場合
- **Patch アップ**: 上記のラベルがない場合（デフォルト）

### 設定ファイル (.tagpr)
各モジュールのディレクトリ直下に `.tagpr` ファイルを配置し、独立したバージョン管理を行っている。

| 設定項目 | 説明 | 設定値 (例) |
| :--- | :--- | :--- |
| `tagPrefix` | 独立したタグを生成するための接頭辞 | `app1` |
| `vPrefix` | バージョン番号の前に `v` を付与するかどうか | `true` |
| `releaseBranch` | リリースの対象となるブランチ | `main` |

## リポジトリ情報

### ブランチ戦略 (Github Flow)
`main` ブランチをデフォルトブランチとする **GitHub Flow** を採用。

## 注意点

### tagpr を Github Apps Token で利用する場合

#### 問題点
GitHub Actions で `actions/checkout` を実行した**後**に GitHub Apps トークンを生成し、そのトークンを `tagpr` の環境変数（`env: GITHUB_TOKEN`）に渡して実行しようとした際、`tagpr` が行うタグの作成や Push などの Git 操作が、生成した Apps トークンではなくデフォルトの `GITHUB_TOKEN` の権限で実行されてしまい、権限エラー（403 等）で失敗することがある。

#### 理由
`actions/checkout` は、デフォルトの挙動として、チェックアウト時に使用したトークン（指定しなければデフォルトの `GITHUB_TOKEN`）の認証情報をローカルの Git 設定 (`.git/config`) に永続化（保存）する。
`tagpr` は内部で `git push` などのコマンドをシェル経由で実行するが、その際にローカルの `.git/config` にすでに保存されている（権限の弱い）認証情報が優先して使われてしまうため、環境変数に強い権限の Apps トークンを渡していても無視されてしまう。

#### 作業内容（解決策）
この問題を解決するには、以下の2つのアプローチのいずれかを行う。

**解決策1: `persist-credentials: false` を設定する（推奨）**
`actions/checkout` ステップで `persist-credentials: false` を設定し、デフォルトのトークンが `.git/config` に保存されないようにする。
これにより、`tagpr` のステップで `env: GITHUB_TOKEN: ${{ steps.app-token.outputs.token }}` と渡した Apps トークンが純粋に利用されるようになる。

**解決策2: トークン生成を先に行い、checkout に渡す**
`actions/create-github-app-token` を `actions/checkout` より**先**に実行し、取得したトークンを使って `checkout` を行う（`with: token: ${{ steps.app-token.outputs.token }}`）。

**※ 解決策2 の注意点**
解決策2のアプローチをとると、強力な Apps トークンが `.git/config` に永続化されてしまう。
その結果、`checkout` 以降のすべてのステップで強制的に Apps トークンが利用されることになる。ステップごとに異なる権限やトークンを使い分けたい（最小権限の原則を保ちたい）場合には不適応となるため、基本的には解決策1（`persist-credentials: false`）の利用が推奨される。

### tagpr をモノレポで利用する場合
#### 問題点
機能追加や修正の Pull Request (PR) に `major` や `minor` ラベルを付与してマージしても、リリース用 PR のバージョンが上がらない（Patch アップデートになってしまう）場合がある。

#### 理由
`tagpr` は、各モジュールの変更（例: `app1/` 配下の変更）を正確に抽出するため、内部で `git log -- app1` のようにディレクトリのパスを指定して PR の履歴を検索する。
しかし Git の仕様上、このパス指定検索を行うと、コンフリクトなしで作成された「マージコミット（Create a merge commit）」の履歴が検索結果から除外されて見えなくなってしまう。

その結果、`tagpr` は対象モジュールの PR を発見できず、付与されたラベル（`major` など）も読み取れないため、デフォルトの Patch アップデートとして処理してしまう。

#### 作業内容（解決策）
この問題を回避し、意図通りにバージョンを上げる（タグを生成する）ためには、**PR を `main` ブランチにマージする際、必ず「Squash and merge（スクワッシュしてマージ）」を使用する**こと。

Squash マージを使用すれば、変更が1つの通常のコミットとして記録されるため、Git のパス指定検索でも確実にヒットし、`tagpr` がラベルを正しく認識してバージョンを計算できるようになる。
（※ 誤操作防止のため、リポジトリ設定で「Allow squash merging」のみを有効にしておくことを推奨する）
