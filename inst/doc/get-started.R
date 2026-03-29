## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment  = "#>",
  eval     = FALSE
)

## ----load---------------------------------------------------------------------
# library(evanverse)

## ----first-ops----------------------------------------------------------------
# "Good" %p% "morning"
# #> [1] "Good morning"
# 
# c("A", "B", "C") %nin% c("B", "D")
# #> [1]  TRUE FALSE  TRUE
# 
# c("tp53", "egfr") %match% c("TP53", "MYC", "EGFR")
# #> [1] 1 3

## ----pkg-basic----------------------------------------------------------------
# set_mirror("all", "tuna")
# 
# inst_pkg("dplyr", source = "CRAN")
# 
# check_pkg(c("dplyr", "ggplot2"), source = "CRAN")
# #> # A tibble with installed status

## ----pkg-update---------------------------------------------------------------
# update_pkg(source = "CRAN")

## ----data-helpers-------------------------------------------------------------
# df <- data.frame(
#   group = c("A", "A", "B"),
#   gene  = c("TP53", "EGFR", "BRCA1"),
#   score = c(1.2, 0.8, 1.6)
# )
# 
# df2list(df, group_col = "group", value_col = "gene")
# #> $A
# #> [1] "TP53" "EGFR"
# #> $B
# #> [1] "BRCA1"
# 
# df2vect(df, name_col = "gene", value_col = "score")
# #>  TP53  EGFR BRCA1
# #>   1.2   0.8   1.6

## ----gmt-helper---------------------------------------------------------------
# path <- toy_gmt(n = 3)
# 
# gmt_df <- gmt2df(path)
# head(gmt_df, 3)
# #>                    term               description  gene
# #> 1 HALLMARK_P53_PATHWAY   Genes regulated by p53  TP53
# #> ...
# 
# gmt_list <- gmt2list(path)
# names(gmt_list)
# #> [1] "HALLMARK_P53_PATHWAY" "HALLMARK_MTORC1_SIGNALING" "HALLMARK_HYPOXIA"

## ----stat-basic---------------------------------------------------------------
# set.seed(42)
# df <- data.frame(
#   group = rep(c("A", "B"), each = 30),
#   value = c(rnorm(30, 5), rnorm(30, 6))
# )
# 
# res_t <- quick_ttest(df, group_col = "group", value_col = "value")
# print(res_t)
# #> t.test | p = ...

## ----stat-cor-----------------------------------------------------------------
# res_cor <- quick_cor(mtcars)
# print(res_cor)
# #> pearson | ... vars | ... significant pairs

## ----plot-basic---------------------------------------------------------------
# plot_bar(
#   data = data.frame(category = c("A", "B", "C"), value = c(10, 7, 12)),
#   x_col = "category",
#   y_col = "value"
# )
# #> # A ggplot object

## ----workflow-----------------------------------------------------------------
# # 1) Prepare toy reference and gene sets
# ref  <- toy_gene_ref("human", n = 100)
# path <- toy_gmt(n = 3)
# 
# # 2) Parse GMT and convert gene IDs
# long <- gmt2df(path)
# idm  <- gene2entrez(long$gene, ref = ref, species = "human")
# long$entrez_id <- idm$entrez_id
# 
# # 3) Build list per term
# long2 <- long[!is.na(long$entrez_id), ]
# sets  <- df2list(long2, group_col = "term", value_col = "entrez_id")
# 
# # 4) Quick statistical and plotting step
# res <- quick_cor(mtcars[, c("mpg", "hp", "wt", "qsec")])
# plot(res, type = "upper", show_sig = TRUE)

