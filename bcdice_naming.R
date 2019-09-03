library(tidyverse)

# 名前のパターン
# see https://stackoverflow.com/a/47591707

# lowerCamelCase
lower_camel_case_re <- "^[a-z]+(?:\\d|[A-Z\\d][a-z\\d]+)*[A-Z]?$"
# UpperCamelCase
upper_camel_case_re <- "^[A-Z][a-z\\d]+(?:\\d|[A-Z\\d][a-z\\d]+)*[A-Z]?$"
# UPPERCASE
upper_case_re <- "^[A-Z][_A-Z\\d]*$"

# データを読み込む
d <- read.csv('bcdice_naming.csv') %>%
  # 使用しない変数 "_" を除く
  filter(name != "_") %>%
  # グローバル変数やインスタンス変数の接頭辞を除く
  mutate(name_without_pre_sym = str_replace(name, "^(?:\\$|@@?)", "")) %>%
  # 使用しない変数に名前が付いていた場合、その接頭辞 "_" を除く
  mutate(name_without_pre_underscore = str_replace(name_without_pre_sym, "^_+", "")) %>%
  # カテゴリごとに条件を満たすかどうかの真偽値をセットする
  mutate(unused = str_starts(name, "_"),
         underscore = str_detect(name_without_pre_underscore, "_"),
         uppercase = str_detect(name_without_pre_underscore, upper_case_re),
         lower_camel_case = str_detect(name_without_pre_underscore, lower_camel_case_re),
         upper_camel_case = str_detect(name_without_pre_underscore, upper_camel_case_re))

# colを基準として割合を求める
calc_ratio_by <- function(d, col) {
  d %>%
    # col でグループ分けする
    group_by(!!as.name(col)) %>%
    # グループごとに項目数 n を求める
    tally() %>%
    # 割合を％で求める
    mutate(percentage = 100.0 * n / sum(n))
}

# 種類別に、criteriaで指定された基準の割合を求める
summarize_ratio <- function(d, criteria) {
  d %>%
    group_by(type) %>%
    nest() %>%
    mutate(data = map(data, calc_ratio_by, criteria)) %>%
    unnest()
}

# 出力

cat("\n[Contain underscore]\n")
d %>% summarize_ratio("underscore")

cat("\n[UPPERCASE]\n")
d %>% summarize_ratio("uppercase")

cat("\n[lowerCamelCase]\n")
d %>% summarize_ratio("lower_camel_case")

cat("\n[UpperCamelCase]\n")
d %>% summarize_ratio("upper_camel_case")
