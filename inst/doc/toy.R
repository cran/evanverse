## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment  = "#>",
  eval     = FALSE
)

## ----load---------------------------------------------------------------------
# library(evanverse)

## ----toy-gene-ref-basic-------------------------------------------------------
# ref_human <- toy_gene_ref()
# head(ref_human, 3)
# #>          symbol       ensembl_id entrez_id      gene_type species ensembl_version download_date
# #> 1        RNA5S5 ENSG00000199396 124905431           rRNA   human             113    2025-04-24
# #> 2          <NA> ENSG00000295528        NA         lncRNA   human             113    2025-04-24
# #> 3          <NA> ENSG00000301748        NA         lncRNA   human             113    2025-04-24

## ----toy-gene-ref-mouse-------------------------------------------------------
# ref_mouse <- toy_gene_ref(species = "mouse", n = 10)
# ref_mouse[, c("symbol", "ensembl_id", "species")]
# #>          symbol          ensembl_id species
# #> 1          <NA> ENSMUSG00000123309   mouse
# #> 2       Gm45096 ENSMUSG00000108739   mouse
# #> ...

## ----toy-gene-ref-cap---------------------------------------------------------
# nrow(toy_gene_ref(n = 999))
# #> [1] 100

## ----toy-gmt-basic------------------------------------------------------------
# path <- toy_gmt()
# path
# #> [1] "C:/Users/.../Rtmp.../file....gmt"
# 
# readLines(path)[1]
# #> [1] "HALLMARK_P53_PATHWAY\tGenes regulated by p53\tTP53\tBRCA1\tMYC\tEGFR\t..."

## ----toy-gmt-n----------------------------------------------------------------
# length(readLines(toy_gmt(n = 1)))
# #> [1] 1
# 
# length(readLines(toy_gmt(n = 3)))
# #> [1] 3
# 
# length(readLines(toy_gmt(n = 99)))
# #> [1] 5

## ----toy-with-gene-conversion-------------------------------------------------
# ref <- toy_gene_ref(species = "human", n = 50)
# gene2entrez(c("TP53", "BRCA1", "GHOST"), ref = ref, species = "human")
# #>   symbol symbol_std entrez_id
# #> 1   TP53       TP53      7157
# #> 2  BRCA1      BRCA1       672
# #> 3  GHOST      GHOST      <NA>

## ----toy-with-gmt-parsers-----------------------------------------------------
# tmp <- toy_gmt(n = 3)
# 
# df <- gmt2df(tmp)
# head(df, 4)
# #>                    term               description  gene
# #> 1 HALLMARK_P53_PATHWAY   Genes regulated by p53  TP53
# #> 2 HALLMARK_P53_PATHWAY   Genes regulated by p53 BRCA1
# #> 3 HALLMARK_P53_PATHWAY   Genes regulated by p53   MYC
# #> 4 HALLMARK_P53_PATHWAY   Genes regulated by p53  EGFR
# 
# lst <- gmt2list(tmp)
# names(lst)
# #> [1] "HALLMARK_P53_PATHWAY" "HALLMARK_MTORC1_SIGNALING" "HALLMARK_HYPOXIA"

## ----workflow-----------------------------------------------------------------
# library(evanverse)
# 
# # 1. Toy reference
# ref <- toy_gene_ref(species = "human", n = 100)
# 
# # 2. Toy gene sets
# path <- toy_gmt(n = 3)
# long <- gmt2df(path)
# 
# # 3. Convert symbols to Entrez IDs
# id_map <- gene2entrez(long$gene, ref = ref, species = "human")
# long$entrez_id <- id_map$entrez_id
# 
# # 4. Rebuild list of Entrez IDs per term
# long2 <- long[!is.na(long$entrez_id), ]
# sets_entrez <- df2list(long2, group_col = "term", value_col = "entrez_id")
# 
# names(sets_entrez)
# #> [1] "HALLMARK_P53_PATHWAY" "HALLMARK_MTORC1_SIGNALING" "HALLMARK_HYPOXIA"

