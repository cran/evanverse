## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment  = "#>",
  eval     = FALSE
)

## ----load---------------------------------------------------------------------
# library(evanverse)

## ----df2list------------------------------------------------------------------
# df <- data.frame(
#   cell_type = c("T_cell", "T_cell", "B_cell", "B_cell", "B_cell"),
#   marker    = c("CD3D", "CD3E", "CD79A", "MS4A1", "CD19"),
#   stringsAsFactors = FALSE
# )
# 
# df2list(df, group_col = "cell_type", value_col = "marker")
# #> $T_cell
# #> [1] "CD3D" "CD3E"
# #>
# #> $B_cell
# #> [1] "CD79A" "MS4A1" "CD19"

## ----df2vect------------------------------------------------------------------
# df <- data.frame(
#   gene  = c("TP53", "BRCA1", "MYC"),
#   score = c(0.91, 0.74, 0.55),
#   stringsAsFactors = FALSE
# )
# 
# df2vect(df, name_col = "gene", value_col = "score")
# #>  TP53 BRCA1   MYC
# #>  0.91  0.74  0.55

## ----df2vect-error------------------------------------------------------------
# bad <- data.frame(id = c("a", "a"), val = 1:2)
# df2vect(bad, "id", "val")
# #> Error in `df2vect()`:
# #> ! `name_col` contains duplicate values.

## ----recode-column------------------------------------------------------------
# df <- data.frame(
#   gene = c("TP53", "BRCA1", "EGFR", "XYZ"),
#   stringsAsFactors = FALSE
# )
# 
# dict <- c("TP53" = "Tumour suppressor", "EGFR" = "Oncogene")
# 
# # Overwrite in place
# recode_column(df, column = "gene", dict = dict)
# #>                gene
# #> 1 Tumour suppressor
# #> 2              <NA>
# #> 3          Oncogene
# #> 4              <NA>
# 
# # Write to a new column, keep original; use a custom fallback
# recode_column(df, column = "gene", dict = dict,
#               name = "role", default = "Unknown")
# #>    gene              role
# #> 1  TP53 Tumour suppressor
# #> 2 BRCA1           Unknown
# #> 3  EGFR          Oncogene
# #> 4   XYZ           Unknown

## ----view---------------------------------------------------------------------
# view(iris, n = 10)

## ----file-ls------------------------------------------------------------------
# # All files in the current directory
# file_ls(".")
# #>              file size_MB       modified_time                          path
# #> 1  DESCRIPTION   0.002  2026-03-20 14:22:01  F:/project/evanverse/DESCRIPTION
# #> 2    NAMESPACE   0.002  2026-03-20 14:22:01  F:/project/evanverse/NAMESPACE
# #> ...
# 
# # R source files only, searched recursively
# file_ls("R", recursive = TRUE, pattern = "\\.R$")

## ----file-info----------------------------------------------------------------
# file_info(c("DESCRIPTION", "NAMESPACE"))
# #>          file size_MB       modified_time                          path
# #> 1 DESCRIPTION   0.002  2026-03-20 14:22:01  F:/project/evanverse/DESCRIPTION
# #> 2   NAMESPACE   0.002  2026-03-20 14:22:01  F:/project/evanverse/NAMESPACE

## ----file-tree----------------------------------------------------------------
# file_tree(".", max_depth = 2)
# #> F:/project/evanverse
# #> +-- DESCRIPTION
# #> +-- NAMESPACE
# #> +-- R
# #> |   +-- base.R
# #> |   +-- plot.R
# #> |   +-- utils.R
# #> +-- tests
# #>     +-- testthat

## ----gene-ref-----------------------------------------------------------------
# # Fast, offline reference for development
# ref <- toy_gene_ref(species = "human")
# 
# # Full reference for analysis (requires network + Bioconductor)
# # ref <- download_gene_ref(species = "human")

## ----gene2entrez--------------------------------------------------------------
# ref <- toy_gene_ref(species = "human")
# 
# gene2entrez(c("tp53", "BRCA1", "GHOST"), ref = ref, species = "human")
# #>   symbol symbol_std entrez_id
# #> 1   tp53       TP53      7157
# #> 2  BRCA1      BRCA1       672
# #> 3  GHOST      GHOST      <NA>

## ----gene2ensembl-------------------------------------------------------------
# ref_mouse <- toy_gene_ref(species = "mouse")
# 
# gene2ensembl(c("Trp53", "TRP53", "FakeGene"), ref = ref_mouse, species = "mouse")
# #>     symbol symbol_std          ensembl_id
# #> 1    Trp53      trp53  ENSMUSG00000059552
# #> 2    TRP53      trp53  ENSMUSG00000059552
# #> 3 FakeGene   fakegene                <NA>

## ----toy-gmt------------------------------------------------------------------
# tmp <- toy_gmt(n = 3)
# readLines(tmp)
# #> [1] "HALLMARK_P53_PATHWAY\tGenes regulated by p53\tTP53\tBRCA1\tMYC\t..."
# #> [2] "HALLMARK_MTORC1_SIGNALING\tGenes upregulated by mTORC1\tPTEN\t..."
# #> [3] "HALLMARK_HYPOXIA\tGenes upregulated under hypoxia\tMTOR\tHIF1A\t..."

## ----gmt2df-------------------------------------------------------------------
# df <- gmt2df(tmp)
# head(df, 4)
# #>                      term               description  gene
# #> 1   HALLMARK_P53_PATHWAY  Genes regulated by p53   TP53
# #> 2   HALLMARK_P53_PATHWAY  Genes regulated by p53  BRCA1
# #> 3   HALLMARK_P53_PATHWAY  Genes regulated by p53    MYC
# #> 4   HALLMARK_P53_PATHWAY  Genes regulated by p53   EGFR

## ----gmt2list-----------------------------------------------------------------
# gs <- gmt2list(tmp)
# names(gs)
# #> [1] "HALLMARK_P53_PATHWAY"      "HALLMARK_MTORC1_SIGNALING"
# #> [3] "HALLMARK_HYPOXIA"
# 
# gs[["HALLMARK_P53_PATHWAY"]]
# #>  [1] "TP53"   "BRCA1"  "MYC"    "EGFR"   "PTEN"   "CDK2"   "MDM2"
# #>  [8] "RB1"    "CDKN2A" "AKT1"

## ----workflow-----------------------------------------------------------------
# library(evanverse)
# 
# # 1. Parse GMT into long format
# tmp <- toy_gmt(n = 5)
# df  <- gmt2df(tmp)
# 
# # 2. Convert symbols to Entrez IDs
# ref    <- toy_gene_ref(species = "human")
# id_map <- gene2entrez(df$gene, ref = ref, species = "human")
# 
# # 3. Attach IDs and drop unmatched
# df$entrez_id <- id_map$entrez_id
# df <- df[!is.na(df$entrez_id), ]
# 
# # 4. Rebuild named list with Entrez IDs
# gs_entrez <- df2list(df, group_col = "term", value_col = "entrez_id")
# gs_entrez[["HALLMARK_P53_PATHWAY"]]
# #> [1] "7157" "672"  "4609" "1956" "5728" "1031" "4193" "5925" "1029"  "207"

