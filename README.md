# LaTeX DevContainer for VS Code

このリポジトリは Visual Studio Code の Dev Containers 機能を用いて  
LaTeX（特に日本語組版）がすぐに使える Docker 環境を提供します。  
プロジェクトに `.devcontainer` を含めるだけで、TeX Live と主要ツール・拡張機能がプリセットされた開発環境が起動し、PDF 生成・整形・クリーンアップまでワンストップで行えます。

## 主な特徴

| 機能                          | 説明                                                                                                                                        |
| ----------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------- |
| **TeX Live 最新版**           | ベースイメージに `registry.gitlab.com/islandoftex/images/texlive:latest` を採用し、`tlmgr` を使って追加パッケージを自動インストールします。 |
| **VS Code 拡張**              | DevContainer 起動時に `James-Yu.latex-workshop` を自動導入。設定済みのレシピで `latexmk` → PDF までワンクリック。                           |
| **日本語向け設定**            | `platex / pbibtex / mendex / dvipdfmx` を使用する `.latexmkrc` を同梱。                                                                     |
| **コード整形**                | `latexindent` を YAML で細かくカスタマイズ。句読点の全角 → 全角カンマ、ピリオド変換例を収録。                                               |
| **クリーンビルド & 出力整理** | 中間ファイルは `out/` に隔離し、ビルド後 PDF を Tex ファイルと同じ階層へ自動移動。                                                          |

## 使い方

1. **前提条件**

   - Docker
   - Visual Studio Code + _Dev Containers_ 拡張

2. **プロジェクトに導入**

   ```bash
    cd your-project/.devcontainer/

    git clone https://github.com/tamago1106/latex-devcontainer.git
   ```

   submodule として追加する場合はこちら ↓

   ```bash
   cd your-project/.devcontainer/

   git submodule add https://github.com/tamago1106/latex-devcontainer.git
   ```

3. **コンテナ起動**  
   VS Code を開き `Dev Containers: Reopen in Container` を実行すると、  
   Docker イメージのビルドと必要パッケージのインストールが自動で走ります。  
   初回は数分かかりますが 2 回目以降はキャッシュが効き高速です。

4. **LaTeX を編集**
   - `Ctrl+S` で自動コンパイル（`latexmk -silent`）
   - 生成された PDF はワークスペース直下に配置
   - 中間ファイルは `out/` に保存され、`Latex Workshop: Clean up` で削除可能

## カスタマイズ方法

| ファイル               | 変更内容                                                                                                                                 |
| ---------------------- | ---------------------------------------------------------------------------------------------------------------------------------------- |
| `texlive-packages.txt` | 追加でインストールしたい TeX Live パッケージを 1 行 1 つで列挙します。コメント行 (`# ...`) 可。ビルド時に `tlmgr install` を実行します。 |
| `.latexmkrc`           | コンパイルコマンドやプレビュアを変更したい場合はこちらを編集します。デフォルトは pLaTeX 系。                                             |
| `latexindent.yaml`     | 整形ルールを YAML で調整できます。記号の置換やインデント幅など。                                                                         |

## フォルダ構成

```
your-project
├── .devcontainer
│   └── latex-devontainer
│       ├── Dockerfile
│       ├── devcontainer.json
│       ├── texlive-packages.txt
│       ├── .latexmkrc
│       └── latexindent.yaml
├── sample1.tex
├── sample2.tex
└── sample
    └── sample3.tex
```

## カスタマイズ方法

| ファイル                                  | 変更内容                                                                                                                                 |
| ----------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------- |
| `texlive-packages.txt`                    | 追加でインストールしたい TeX Live パッケージを 1 行 1 つで列挙します。コメント行 (`# ...`) 可。ビルド時に `tlmgr install` を実行します。 |
| `.latexmkrc`                              | コンパイルコマンドやプレビュアを変更したい場合はこちらを編集します。デフォルトは pLaTeX 系。                                             |
| `latexindent.yaml`                        | 整形ルールを YAML で調整できます。記号の置換やインデント幅など。                                                                         |
| `devcontainer.json` (settings セクション) | LaTeX Workshop の設定を上書き可能。例: latex-workshop.latex.recipes, latex-workshop.view.pdf.viewer などをプロジェクト固有に調整。       |

## よくある質問

### Q. 英語の論文（pdfLaTeX/xelatex）もビルドできますか？

A. `texlive-packages.txt` で必要なパッケージを追加し、`.latexmkrc` の `$latex` 行を `pdflatex` 等に変更すれば利用可能です。

### Q. コンテナ容量を削減したい

A. 不要なパッケージを `texlive-packages.txt` から削除し、`tlmgr` で `scheme-basic` ベースに変更するなどで軽量化できます。

## 貢献

Issues や Pull Request は歓迎です！  
バグ報告・機能要望などお気軽にどうぞ。
