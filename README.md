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

## 集計対象

* クラス名
* クラスメソッド名
* インスタンスメソッド名
    * 現時点では、`attr_accessor` などで作られるメソッドは集計の対象外です。
* グローバル変数への代入
* クラス変数への代入
* インスタンス変数への代入
* ローカル変数への代入

**注意**：情報収集に使用しているgem referralの処理の都合上、同じ対象を複数回操作している場合も収集されているため、実際の項目数と出力される項目数は異なります。目安として考えてください。

## 集計結果の見方

集計結果は [bcdice\_naming\_result.txt](bcdice_naming_result.txt) に記載されています。

* カテゴリ
    * `Contain underscore`：アンダースコア `_` を含む名前。
        * `snake_case` で命名されている可能性があります。ただし、`ダイスボット名_Korean` のようなパターンも含まれます。
        * 使用しない変数の命名に使う `_` のみの場合は除外されています。
    * `UPPERCASE`：すべて大文字
        * 主に定数に使われます。ただし、ダイスボットのクラス名が略称などのためすべて大文字になる場合もあります。
    * `lowerCamelCase`：最初が小文字のCamelCase。
        * 変数名やメソッド名など、主に通常の識別子で使われています。
    * `UpperCamelCase`：最初が大文字のCamelCase。
        * クラス名で使われます。
* `type`：構文の種類
    * `class`：クラス名
    * `instance_method`：インスタンスメソッド名
    * `instance_var_assign`：インスタンス変数への代入
    * `local_var_assign`：ローカル変数への代入
    * `global_var_assign`：グローバル変数への代入
    * `class_method`：クラスメソッド名
    * `class_var_assign`：クラス変数への代入
* `underscore`、`uppercase`、`lower_camel_case`、`upper_camel_case`
    * `FALSE`：そのカテゴリに属さない項目の集合であることを示します。
    * `TRUE`：そのカテゴリに属す項目の集合であることを示します。
* `n`：含まれる項目数。
* `percentage`：割合を％で示します。
