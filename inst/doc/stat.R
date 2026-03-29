## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment  = "#>",
  eval     = FALSE
)

## ----load---------------------------------------------------------------------
# library(evanverse)

## ----stat-power-basic---------------------------------------------------------
# res <- stat_power(n = 30, effect_size = 0.5)
# print(res)
# #> Power: 47.8%  (very low) | Two-sample t-test
# #> n = 30 per group,  effect size = 0.500,  alpha = 0.050

## ----stat-power-anova---------------------------------------------------------
# stat_power(n = 25, effect_size = 0.25, test = "anova", k = 3)
# #> # power_result object

## ----stat-power-chisq---------------------------------------------------------
# stat_power(n = 120, effect_size = 0.3, test = "chisq", df = 2)
# #> # power_result object

## ----stat-power-methods-------------------------------------------------------
# summary(res)
# plot(res)
# #> # A ggplot object: power curve over sample size

## ----stat-n-basic-------------------------------------------------------------
# res_n <- stat_n(power = 0.8, effect_size = 0.5)
# print(res_n)
# #> n = 64 per group (128 total) | Two-sample t-test
# #> Target power = 80%,  effect size = 0.500,  alpha = 0.050

## ----stat-n-correlation-------------------------------------------------------
# stat_n(
#   power = 0.9,
#   effect_size = 0.3,
#   test = "correlation",
#   alternative = "greater"
# )
# #> # power_result object

## ----stat-n-methods-----------------------------------------------------------
# summary(res_n)
# plot(res_n)
# #> # A ggplot object: required n as a function of effect size

## ----quick-ttest-basic--------------------------------------------------------
# set.seed(42)
# df <- data.frame(
#   group = rep(c("A", "B"), each = 30),
#   value = c(rnorm(30, 5), rnorm(30, 6))
# )
# 
# res_t <- quick_ttest(df, group_col = "group", value_col = "value")
# print(res_t)
# #> t.test | p = 0.0012* | A n=30, B n=30
# summary(res_t)

## ----quick-ttest-paired-------------------------------------------------------
# set.seed(7)
# df_p <- data.frame(
#   id    = rep(1:20, 2),
#   group = rep(c("pre", "post"), each = 20),
#   value = c(rnorm(20, 10, 2), rnorm(20, 11, 2))
# )
# 
# res_p <- quick_ttest(
#   df_p,
#   group_col = "group",
#   value_col = "value",
#   paired = TRUE,
#   id_col = "id"
# )
# plot(res_p, plot_type = "both", p_label = "p.format")

## ----quick-anova-basic--------------------------------------------------------
# set.seed(123)
# df_a <- data.frame(
#   group = rep(LETTERS[1:3], each = 40),
#   value = rnorm(120, mean = rep(c(0, 0.5, 1.2), each = 40), sd = 1)
# )
# 
# res_a <- quick_anova(df_a, group_col = "group", value_col = "value")
# print(res_a)
# #> One-way ANOVA | p < 0.001* | A n=40, B n=40, C n=40
# summary(res_a)

## ----quick-anova-forced-------------------------------------------------------
# res_a2 <- quick_anova(
#   df_a,
#   group_col = "group",
#   value_col = "value",
#   method = "anova",
#   post_hoc = "tukey"
# )
# plot(res_a2, plot_type = "violin")

## ----quick-chisq-basic--------------------------------------------------------
# set.seed(123)
# df_c <- data.frame(
#   treatment = sample(c("A", "B", "C"), 100, replace = TRUE),
#   response  = sample(c("Success", "Failure"), 100, replace = TRUE,
#                      prob = c(0.6, 0.4))
# )
# 
# res_c <- quick_chisq(df_c, x_col = "treatment", y_col = "response")
# print(res_c)
# #> Chi-square test | p = 0.0410* | 3x2 | V = 0.20 (small)
# summary(res_c)

## ----quick-chisq-fisher-------------------------------------------------------
# df_2x2 <- data.frame(
#   exposed = c("Yes", "Yes", "No", "No", "Yes", "No"),
#   event   = c("Yes", "No", "Yes", "No", "Yes", "No")
# )
# 
# res_f <- quick_chisq(df_2x2, x_col = "exposed", y_col = "event", method = "fisher")
# plot(res_f, plot_type = "heatmap")

## ----quick-cor-basic----------------------------------------------------------
# res_cor <- quick_cor(mtcars)
# print(res_cor)
# #> pearson | 11 vars | 24/55 significant pairs (alpha = 0.05)
# summary(res_cor)

## ----quick-cor-adjust---------------------------------------------------------
# res_cor2 <- quick_cor(
#   mtcars,
#   vars = c("mpg", "hp", "wt", "qsec"),
#   method = "spearman",
#   p_adjust_method = "BH"
# )
# plot(res_cor2, type = "upper", show_sig = TRUE)

## ----workflow-----------------------------------------------------------------
# library(evanverse)
# 
# # 1. Plan sample size
# plan <- stat_n(power = 0.8, effect_size = 0.5, test = "t_two")
# 
# # 2. Collect / prepare data and run a primary two-group test
# set.seed(101)
# df <- data.frame(
#   group = rep(c("Control", "Treatment"), each = plan$n),
#   value = c(rnorm(plan$n, 10, 2), rnorm(plan$n, 11, 2))
# )
# res_t <- quick_ttest(df, group_col = "group", value_col = "value")
# 
# # 3. Explore correlation structure among related numeric variables
# res_c <- quick_cor(mtcars[, c("mpg", "disp", "hp", "wt", "qsec")])
# 
# # 4. Report + visualize
# print(res_t)
# plot(res_t)
# print(res_c)
# plot(res_c, type = "upper", show_sig = TRUE)

