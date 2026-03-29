## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment  = "#>",
  eval     = FALSE
)

## ----load---------------------------------------------------------------------
# library(evanverse)

## ----bar-basic----------------------------------------------------------------
# df <- data.frame(
#   category = c("Alpha", "Beta", "Gamma", "Delta", "Epsilon"),
#   count    = c(42, 18, 35, 27, 51)
# )
# 
# plot_bar(df, x_col = "category", y_col = "count")
# #> # A ggplot object — vertical bars, categories in original order

## ----bar-sorted---------------------------------------------------------------
# plot_bar(df, x_col = "category", y_col = "count", sort = TRUE)
# #> # Bars ordered from tallest (Epsilon = 51) to shortest (Beta = 18)

## ----bar-horizontal-----------------------------------------------------------
# plot_bar(df, x_col = "category", y_col = "count",
#          sort = TRUE, horizontal = TRUE)
# #> # Horizontal bars, sorted descending

## ----bar-grouped--------------------------------------------------------------
# df2 <- data.frame(
#   category = rep(c("Alpha", "Beta", "Gamma"), each = 2),
#   group    = rep(c("Control", "Treatment"), 3),
#   value    = c(10, 15, 8, 22, 18, 20)
# )
# 
# plot_bar(df2, x_col = "category", y_col = "value", group_col = "group")
# #> # Side-by-side bars, two groups per category

## ----density-basic------------------------------------------------------------
# set.seed(42)
# df <- data.frame(score = rnorm(200, mean = 50, sd = 10))
# 
# plot_density(df, x_col = "score")
# #> # Density curve for all 200 observations

## ----density-groups-----------------------------------------------------------
# df2 <- data.frame(
#   score = c(rnorm(100, 50, 10), rnorm(100, 65, 8)),
#   group = rep(c("Control", "Treatment"), each = 100)
# )
# 
# plot_density(df2, x_col = "score", group_col = "group")
# #> # Two overlaid density curves, one per group

## ----density-facet------------------------------------------------------------
# df3 <- data.frame(
#   score  = c(rnorm(150, 50, 10), rnorm(150, 60, 12)),
#   group  = rep(c("A", "B"), each = 150),
#   cohort = rep(c("Discovery", "Replication"), 150)
# )
# 
# plot_density(df3, x_col = "score", group_col = "group", facet_col = "cohort")
# #> # Two facet panels (Discovery / Replication), each with two group curves

## ----pie-vector---------------------------------------------------------------
# counts <- c(T_cell = 423, B_cell = 187, NK_cell = 95, Monocyte = 312)
# plot_pie(counts)
# #> # Pie chart with four slices, percentage labels

## ----pie-df-------------------------------------------------------------------
# df <- data.frame(
#   cell_type = c("T_cell", "B_cell", "NK_cell", "Monocyte"),
#   n         = c(423, 187, 95, 312)
# )
# 
# plot_pie(df, group_col = "cell_type", count_col = "n", label = "both")
# #> # Pie chart with count + percentage labels

## ----pie-palette--------------------------------------------------------------
# plot_pie(counts, palette = c("#4C72B0", "#DD8452", "#55A868", "#C44E52"))
# #> # Same chart with custom fill colours

## ----venn-two-----------------------------------------------------------------
# set.seed(42)
# genes_a <- sample(paste0("GENE", 1:100), 40)
# genes_b <- sample(paste0("GENE", 1:100), 35)
# 
# plot_venn(genes_a, genes_b, set_names = c("Set A", "Set B"))
# #> # Two-circle Venn with overlap count labels

## ----venn-three---------------------------------------------------------------
# genes_c <- sample(paste0("GENE", 1:100), 30)
# 
# plot_venn(genes_a, genes_b, genes_c,
#           set_names = c("RNA-seq", "ATAC-seq", "ChIP-seq"),
#           label = "percent")
# #> # Three-circle Venn with percentage labels

## ----venn-gradient------------------------------------------------------------
# plot_venn(genes_a, genes_b, genes_c,
#           method  = "gradient",
#           palette = "Blues")
# #> # Gradient-filled Venn (requires ggVennDiagram)

## ----venn-return--------------------------------------------------------------
# result <- plot_venn(genes_a, genes_b, return_sets = TRUE)
# names(result)
# #> [1] "plot" "sets"
# 
# lapply(result$sets, length)
# #> $genes_a
# #> [1] 40
# #>
# #> $genes_b
# #> [1] 35

## ----forest-basic-------------------------------------------------------------
# df <- data.frame(
#   item      = c("Exposure vs. control", "Unadjusted", "Fully adjusted"),
#   `Cases/N` = c("", "89/4521", "89/4521"),
#   p_value   = c(NA_real_, 0.001, 0.006),
#   check.names = FALSE
# )
# 
# p <- plot_forest(
#   data      = df,
#   est       = c(NA, 1.52, 1.43),
#   lower     = c(NA, 1.18, 1.11),
#   upper     = c(NA, 1.96, 1.85),
#   ci_column = 2L,
#   indent    = c(0L, 1L, 1L),
#   p_cols    = "p_value",
#   xlim      = c(0.5, 3.0)
# )
# 
# plot(p)
# #> # Forest plot — header row bolded, two indented model rows,
# #> # OR (95% CI) column auto-generated, significant p-values bolded

## ----forest-multi-------------------------------------------------------------
# df2 <- data.frame(
#   item    = c("Biomarker A", "  Model 1", "  Model 2",
#               "Biomarker B", "  Model 1", "  Model 2"),
#   N       = c("", "4521", "4521", "", "4389", "4389"),
#   p_value = c(NA, 0.001, 0.012, NA, 0.034, 0.21),
#   check.names = FALSE
# )
# 
# p2 <- plot_forest(
#   data       = df2,
#   est        = c(NA, 1.52, 1.43, NA, 0.88, 0.91),
#   lower      = c(NA, 1.18, 1.11, NA, 0.72, 0.74),
#   upper      = c(NA, 1.96, 1.85, NA, 1.07, 1.12),
#   ci_column  = 2L,
#   indent     = c(0L, 1L, 1L, 0L, 1L, 1L),
#   bold_label = c(TRUE, FALSE, FALSE, TRUE, FALSE, FALSE),
#   p_cols     = "p_value",
#   xlim       = c(0.5, 2.5),
#   background = "bold_label"
# )
# 
# plot(p2)
# #> # Two parent rows (bolded, shaded) with four indented sub-rows

## ----forest-colors------------------------------------------------------------
# p3 <- plot_forest(
#   data      = df,
#   est       = c(NA, 1.52, 1.43),
#   lower     = c(NA, 1.18, 1.11),
#   upper     = c(NA, 1.96, 1.85),
#   ci_column = 2L,
#   indent    = c(0L, 1L, 1L),
#   ci_col    = c(NA, "#E74C3C", "#3498DB"),
#   p_cols    = "p_value",
#   xlim      = c(0.5, 3.0)
# )
# 
# plot(p3)
# #> # Red CI for Unadjusted model, blue CI for Fully adjusted model

## ----forest-save--------------------------------------------------------------
# plot_forest(
#   data        = df,
#   est         = c(NA, 1.52, 1.43),
#   lower       = c(NA, 1.18, 1.11),
#   upper       = c(NA, 1.96, 1.85),
#   ci_column   = 2L,
#   indent      = c(0L, 1L, 1L),
#   p_cols      = "p_value",
#   xlim        = c(0.5, 3.0),
#   save        = TRUE,
#   dest        = "results/forest_plot",
#   save_width  = 20,
#   save_height = 8
# )
# #> # Saves forest_plot.pdf, .png, .svg, .tiff to results/

## ----workflow-----------------------------------------------------------------
# library(evanverse)
# 
# # Group sizes as a sorted bar chart
# summary_df <- data.frame(
#   group = c("T_cell", "B_cell", "NK_cell", "Monocyte"),
#   n     = c(423, 187, 95, 312)
# )
# 
# plot_bar(summary_df, x_col = "group", y_col = "n",
#          sort = TRUE, horizontal = TRUE)
# #> # Horizontal sorted bar chart
# 
# # Proportional composition as a pie chart
# plot_pie(summary_df, group_col = "group", count_col = "n", label = "percent")
# #> # Pie chart with percentage labels
# 
# # Score distributions per cell type
# score_df <- data.frame(
#   score = c(rnorm(423, 55, 10), rnorm(187, 62, 9),
#             rnorm(95, 70, 8),   rnorm(312, 48, 12)),
#   group = rep(c("T_cell", "B_cell", "NK_cell", "Monocyte"),
#               c(423, 187, 95, 312))
# )
# 
# plot_density(score_df, x_col = "score", group_col = "group")
# #> # Overlaid density curves for all four cell types
# 
# # DEG overlaps across comparisons
# deg_tc <- paste0("GENE", sample(1:500, 80))
# deg_bc <- paste0("GENE", sample(1:500, 65))
# deg_nk <- paste0("GENE", sample(1:500, 45))
# 
# plot_venn(deg_tc, deg_bc, deg_nk,
#           set_names = c("T_cell DEGs", "B_cell DEGs", "NK_cell DEGs"))
# #> # Three-set Venn of differentially expressed genes

## ----help---------------------------------------------------------------------
# ?plot_bar
# ?plot_density
# ?plot_pie
# ?plot_venn
# ?plot_forest
# 
# help(package = "evanverse")

