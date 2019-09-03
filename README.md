# BCDice naming

[BCDice](https://github.com/bcdice/BCDice)のソースコードにおける名前付けのパターンを集計します。

* [集計結果](bcdice_naming_result.txt)

## 動作確認環境

* [Ruby](https://www.ruby-lang.org/) v2.6.3
    * [Referral](https://github.com/testdouble/referral) v0.0.4
* [R](https://www.r-project.org/) v3.6.1
    * [tidyverse](https://www.tidyverse.org/) 1.2.1

## 準備

### ダウンロード

サブモジュールのBCDiceも含めてcloneしてください。

```Shell
git clone --recurse-submodules https://github.com/ochaochaocha3/bcdice_naming.git
```

### Rの準備

Rをインストールします。Rのインストール後、Rのコンソールでパッケージtidyverseをインストールします。

```R
install.packages("tidyverse")
```

### Rubyの準備

Ruby 2.6以降をインストールします。Rubyのインストール後、bundlerを使用して必要なライブラリをインストールします。

```Shell
bundle install
```

## 使用法

### BCDiceソースコードからの情報収集

以下を実行すると、`referral` コマンドを使用してBCDiceのソースコードから情報を収集し、結果をCSVファイルに出力します。

```Shell
./referral.sh
```

情報収集が完了すると、出力されたCSVファイルの名前が表示されます。

```
bcdice_naming.csv
```

### 名前付けパターンの集計

以下を実行すると、Rおよび情報収集結果を使用して、BCDiceのソースコードにおける名前付けのパターンを集計します。

```Shell
./bcdice_naming.R
```

うまく実行できない場合は、以下のように `Rscript` 経由で実行してください。

```Shell
Rscript bcdice_naming.R
```
