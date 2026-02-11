## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  fig.width = 12,
  fig.height = 8,
  dpi = 300,
  out.width = "100%"
)

## ----setup, message = FALSE, warning = FALSE----------------------------------
library(evanverse)
library(dplyr)
library(grid)

## ----installation, eval = FALSE-----------------------------------------------
# # Install from CRAN (when available)
# install.packages("evanverse")
# 
# # Or install development version from GitHub
# # install.packages("devtools")
# devtools::install_github("evanbio/evanverse")

## ----load-data----------------------------------------------------------------
# Load built-in example data
data("forest_data")

# Inspect structure
head(forest_data, 10)

## ----prepare-data-------------------------------------------------------------
# Filter single-model data
df_single <- forest_data %>%
  filter(is.na(est_2)) %>%      # Single model (no est_2)
  filter(!is.na(est)) %>%        # Remove header rows
  head(10)                       # First 10 rows for demo

# Create display table
plot_data <- df_single %>%
  mutate(
    ` ` = strrep(" ", 20),       # Blank column for CI graphic
    `OR (95% CI)` = sprintf("%.2f (%.2f-%.2f)", est, lower, upper),
    `P` = ifelse(pval < 0.001, "<0.001", sprintf("%.3f", pval)),
    `N` = n_total
  ) %>%
  select(Variable = variable, ` `, `OR (95% CI)`, `P`, `N`)

print(plot_data)

## ----basic-forest, fig.height = 6---------------------------------------------
# Create forest plot
p1 <- plot_forest(
  data = plot_data,
  est = list(df_single$est),
  lower = list(df_single$lower),
  upper = list(df_single$upper),
  ci_column = 2,                 # Column for CI graphic (blank column)
  ref_line = 1,                  # OR = 1 reference
  xlim = c(0.5, 2.5),
  arrow_lab = c("Lower Risk", "Higher Risk")
)

print(p1)

## ----data-structure, eval = FALSE---------------------------------------------
# # YOUR data frame should have:
# # 1. Display columns (text, formatted strings)
# # 2. Numeric vectors for est, lower, upper (NOT in data frame)
# # 3. A blank column (" ") where CI graphics will be drawn
# 
# plot_data <- data.frame(
#   Variable = c("Age", "Sex", "BMI"),           # Display
#   ` ` = rep(strrep(" ", 20), 3),               # Blank for CI
#   `OR (95% CI)` = c("1.45 (...)", ...),        # Display
#   `P` = c("0.001", "0.189", "0.045")           # Display
# )
# 
# # Numeric vectors (not in data frame)
# est_values <- c(1.45, 0.88, 1.35)
# lower_values <- c(1.10, 0.65, 1.05)
# upper_values <- c(1.83, 1.18, 1.71)

## ----theme-preset, fig.height = 6---------------------------------------------
# Default theme (built-in)
p2 <- plot_forest(
  data = plot_data,
  est = list(df_single$est),
  lower = list(df_single$lower),
  upper = list(df_single$upper),
  ci_column = 2,
  ref_line = 1,
  theme_preset = "default"
)

print(p2)

## ----theme-custom, fig.height = 6---------------------------------------------
# Override specific theme parameters
p3 <- plot_forest(
  data = plot_data,
  est = list(df_single$est),
  lower = list(df_single$lower),
  upper = list(df_single$upper),
  ci_column = 2,
  ref_line = 1,
  theme_custom = list(
    base_size = 14,              # Larger font
    ci_pch = 18,                 # Diamond shape
    ci_lwd = 2,                  # Thicker lines
    ci_fill = "#4DBBD5",         # Custom color
    ci_Theight = 0.15            # Box height
  )
)

print(p3)

## ----alignment, fig.height = 6------------------------------------------------
p4 <- plot_forest(
  data = plot_data,
  est = list(df_single$est),
  lower = list(df_single$lower),
  upper = list(df_single$upper),
  ci_column = 2,
  ref_line = 1,
  align_left = 1,                # Variable names left
  align_center = c(2, 3),        # CI column and OR center
  align_right = c(4, 5)          # P-value and N right
)

print(p4)

## ----bold-groups, fig.height = 6----------------------------------------------
# Assuming "Sex" and "BMI category" are group headers
p5 <- plot_forest(
  data = plot_data,
  est = list(df_single$est),
  lower = list(df_single$lower),
  upper = list(df_single$upper),
  ci_column = 2,
  ref_line = 1,
  bold_group = c("Sex", "BMI category"),
  bold_group_col = 1
)

print(p5)

## ----bold-pvalues, fig.height = 6---------------------------------------------
p6 <- plot_forest(
  data = plot_data,
  est = list(df_single$est),
  lower = list(df_single$lower),
  upper = list(df_single$upper),
  ci_column = 2,
  ref_line = 1,
  bold_pvalue_cols = 4,          # P-value column
  p_threshold = 0.05             # Significance level
)

print(p6)

## ----background-zebra, fig.height = 6-----------------------------------------
p7 <- plot_forest(
  data = plot_data,
  est = list(df_single$est),
  lower = list(df_single$lower),
  upper = list(df_single$upper),
  ci_column = 2,
  ref_line = 1,
  background_style = "zebra",
  background_colors = list(
    primary = "#F0F0F0",
    secondary = "white"
  )
)

print(p7)

## ----background-group, fig.height = 6-----------------------------------------
# Identify rows that are group headers (NA in est)
group_rows <- which(is.na(df_single$est))

p8 <- plot_forest(
  data = plot_data,
  est = list(df_single$est),
  lower = list(df_single$lower),
  upper = list(df_single$upper),
  ci_column = 2,
  ref_line = 1,
  background_style = "group",
  background_group_rows = group_rows,
  background_colors = list(
    primary = "#E3F2FD",         # Group headers
    secondary = "white"          # Data rows
  )
)

print(p8)

## ----ci-single, fig.height = 6------------------------------------------------
p9 <- plot_forest(
  data = plot_data,
  est = list(df_single$est),
  lower = list(df_single$lower),
  upper = list(df_single$upper),
  ci_column = 2,
  ref_line = 1,
  ci_colors = "#E64B35"          # All boxes same color
)

print(p9)

## ----ci-significance, fig.height = 6------------------------------------------
# Color based on p-value
ci_cols <- ifelse(df_single$pval < 0.05, "#E64B35", "#CCCCCC")

p10 <- plot_forest(
  data = plot_data,
  est = list(df_single$est),
  lower = list(df_single$lower),
  upper = list(df_single$upper),
  ci_column = 2,
  ref_line = 1,
  ci_colors = ci_cols             # Vector matching rows
)

print(p10)

## ----borders, fig.height = 6--------------------------------------------------
p11 <- plot_forest(
  data = plot_data,
  est = list(df_single$est),
  lower = list(df_single$lower),
  upper = list(df_single$upper),
  ci_column = 2,
  ref_line = 1,
  add_borders = TRUE,
  border_width = 3
)

print(p11)

## ----complete-custom, fig.height = 7------------------------------------------
# All customizations combined
p12 <- plot_forest(
  data = plot_data,
  est = list(df_single$est),
  lower = list(df_single$lower),
  upper = list(df_single$upper),
  ci_column = 2,
  ref_line = 1,
  xlim = c(0.5, 2.5),
  arrow_lab = c("Protective", "Risk"),

  # Alignment
  align_left = 1,
  align_center = c(2, 3),
  align_right = c(4, 5),

  # Bold
  bold_pvalue_cols = 4,
  p_threshold = 0.05,

  # Background
  background_style = "zebra",

  # CI colors by significance
  ci_colors = ifelse(df_single$pval < 0.05, "#E64B35", "#4DBBD5"),

  # Borders
  add_borders = TRUE,

  # Layout
  height_main = 10,
  height_bottom = 8,
  layout_verbose = FALSE
)

print(p12)

## ----multi-model-data---------------------------------------------------------
# Filter multi-model data
df_multi <- forest_data %>%
  filter(!is.na(est_2))          # Has multiple models

# Create display table with multiple model columns
plot_data_multi <- df_multi %>%
  mutate(
    ` ` = strrep(" ", 15),
    `Model 1` = sprintf("%.2f (%.2f-%.2f)", est, lower, upper),
    `Model 2` = sprintf("%.2f (%.2f-%.2f)", est_2, lower_2, upper_2),
    `Model 3` = sprintf("%.2f (%.2f-%.2f)", est_3, lower_3, upper_3)
  ) %>%
  select(Variable = variable, ` `, `Model 1`, `Model 2`, `Model 3`)

print(plot_data_multi)

## ----multi-basic, fig.height = 5----------------------------------------------
p13 <- plot_forest(
  data = plot_data_multi,
  est = list(df_multi$est, df_multi$est_2, df_multi$est_3),
  lower = list(df_multi$lower, df_multi$lower_2, df_multi$lower_3),
  upper = list(df_multi$upper, df_multi$upper_2, df_multi$upper_3),
  ci_column = 2,
  ref_line = 1,
  xlim = c(0.5, 3)
)

print(p13)

## ----multi-nudge, fig.height = 5----------------------------------------------
p14 <- plot_forest(
  data = plot_data_multi,
  est = list(df_multi$est, df_multi$est_2, df_multi$est_3),
  lower = list(df_multi$lower, df_multi$lower_2, df_multi$lower_3),
  upper = list(df_multi$upper, df_multi$upper_2, df_multi$upper_3),
  ci_column = 2,
  ref_line = 1,
  xlim = c(0.5, 3),
  nudge_y = 0.3                  # Increase spacing
)

print(p14)

## ----multi-sizes, fig.height = 5----------------------------------------------
# IMPORTANT: sizes must match number of ROWS, not models!
# For 3 rows, repeat the pattern
sizes_vec <- rep(0.6, nrow(plot_data_multi))

p15 <- plot_forest(
  data = plot_data_multi,
  est = list(df_multi$est, df_multi$est_2, df_multi$est_3),
  lower = list(df_multi$lower, df_multi$lower_2, df_multi$lower_3),
  upper = list(df_multi$upper, df_multi$upper_2, df_multi$upper_3),
  ci_column = 2,
  ref_line = 1,
  xlim = c(0.5, 3),
  sizes = sizes_vec              # Must match row count!
)

print(p15)

## ----auto-ticks, fig.height = 6-----------------------------------------------
p16 <- plot_forest(
  data = plot_data,
  est = list(df_single$est),
  lower = list(df_single$lower),
  upper = list(df_single$upper),
  ci_column = 2,
  ref_line = 1,
  xlim = c(0.5, 2.5),
  ticks_at = NULL                # Auto-generate 5 ticks
)

print(p16)

## ----layout-defaults----------------------------------------------------------
# Default values (can be customized)
# height_top = 8        # Top margin
# height_header = 12    # Header row
# height_main = 10      # Data rows
# height_bottom = 8     # Bottom margin
# width_left = 10       # Left margin
# width_right = 10      # Right margin

## ----layout-custom, fig.height = 6--------------------------------------------
p17 <- plot_forest(
  data = plot_data,
  est = list(df_single$est),
  lower = list(df_single$lower),
  upper = list(df_single$upper),
  ci_column = 2,
  ref_line = 1,
  height_main = 12,              # Taller rows
  height_bottom = 6,             # Smaller bottom margin
  width_adjust = 8,              # Wider columns
  layout_verbose = TRUE          # Print layout info
)

print(p17)

## ----layout-manual, fig.height = 6--------------------------------------------
p18 <- plot_forest(
  data = plot_data,
  est = list(df_single$est),
  lower = list(df_single$lower),
  upper = list(df_single$upper),
  ci_column = 2,
  ref_line = 1,
  height_custom = list('3' = 15, '4' = 15),  # Specific rows
  width_custom = list('2' = 80, '3' = 100),  # Specific columns
  layout_verbose = FALSE
)

print(p18)

## ----save-plots, eval = FALSE-------------------------------------------------
# # Save to multiple formats
# p19 <- plot_forest(
#   data = plot_data,
#   est = list(df_single$est),
#   lower = list(df_single$lower),
#   upper = list(df_single$upper),
#   ci_column = 2,
#   ref_line = 1,
#   save_plot = TRUE,
#   filename = "my_forest_plot",
#   save_path = "output",
#   save_formats = c("png", "pdf", "tiff"),
#   save_width = 30,
#   save_height = 25,
#   save_dpi = 300
# )

## ----example-logistic, fig.height = 8-----------------------------------------
# Simulate logistic regression results
set.seed(123)
logistic_results <- data.frame(
  Variable = c(
    "Demographics", "  Age (per 10 years)", "  Male sex",
    "Clinical", "  BMI ≥30", "  Hypertension", "  Diabetes",
    "Laboratory", "  CRP >3 mg/L", "  LDL-C >130 mg/dL"
  ),
  OR = c(NA, 1.35, 0.82, NA, 1.58, 1.42, 1.67, NA, 1.44, 1.28),
  Lower = c(NA, 1.15, 0.65, NA, 1.22, 1.18, 1.32, NA, 1.15, 1.02),
  Upper = c(NA, 1.58, 1.03, NA, 2.05, 1.71, 2.11, NA, 1.81, 1.61),
  P = c(NA, 0.001, 0.085, NA, 0.001, 0.001, 0.001, NA, 0.002, 0.035)
)

# Prepare display
logistic_display <- logistic_results %>%
  mutate(
    ` ` = strrep(" ", 20),
    `OR (95% CI)` = ifelse(is.na(OR), "",
                           sprintf("%.2f (%.2f-%.2f)", OR, Lower, Upper)),
    `P-value` = ifelse(is.na(P), "",
                       ifelse(P < 0.001, "<0.001", sprintf("%.3f", P)))
  ) %>%
  select(Variable, ` `, `OR (95% CI)`, `P-value`)

# Identify group headers
group_rows <- c(1, 4, 7)

# Create plot
p_logistic <- plot_forest(
  data = logistic_display,
  est = list(logistic_results$OR),
  lower = list(logistic_results$Lower),
  upper = list(logistic_results$Upper),
  ci_column = 2,
  ref_line = 1,
  xlim = c(0.5, 2.5),
  arrow_lab = c("Protective", "Risk Factor"),

  align_left = 1,
  align_center = 2,
  align_right = c(3, 4),

  bold_group = logistic_display$Variable[group_rows],
  bold_pvalue_cols = 4,
  p_threshold = 0.05,

  background_style = "group",
  background_group_rows = group_rows,

  ci_colors = ifelse(is.na(logistic_results$P) | logistic_results$P >= 0.05,
                     "#CCCCCC", "#E64B35"),

  add_borders = TRUE,
  layout_verbose = FALSE
)

print(p_logistic)

## ----example-cox, fig.height = 7----------------------------------------------
# Survival analysis hazard ratios
cox_results <- data.frame(
  Gene = c("BRCA1", "BRCA2", "TP53", "EGFR", "MYC",
           "KRAS", "PIK3CA", "AKT1", "PTEN"),
  HR = c(1.45, 0.78, 2.12, 1.23, 0.91, 1.87, 1.56, 0.85, 1.34),
  Lower = c(1.18, 0.61, 1.58, 0.95, 0.72, 1.42, 1.20, 0.66, 1.05),
  Upper = c(1.78, 0.99, 2.84, 1.59, 1.15, 2.46, 2.03, 1.09, 1.71),
  P = c(0.001, 0.041, 0.001, 0.124, 0.412, 0.001, 0.001, 0.235, 0.018)
)

cox_display <- cox_results %>%
  mutate(
    ` ` = strrep(" ", 20),
    `HR (95% CI)` = sprintf("%.2f (%.2f-%.2f)", HR, Lower, Upper),
    `P-value` = ifelse(P < 0.001, "<0.001", sprintf("%.3f", P))
  ) %>%
  select(Gene, ` `, `HR (95% CI)`, `P-value`)

p_cox <- plot_forest(
  data = cox_display,
  est = list(cox_results$HR),
  lower = list(cox_results$Lower),
  upper = list(cox_results$Upper),
  ci_column = 2,
  ref_line = 1,
  xlim = c(0.5, 3),
  arrow_lab = c("Better Survival", "Worse Survival"),

  align_left = 1,
  align_right = c(3, 4),

  bold_pvalue_cols = 4,
  p_threshold = 0.05,

  background_style = "zebra",

  ci_colors = ifelse(cox_results$P < 0.05, "#E64B35", "#4DBBD5"),

  add_borders = TRUE,
  height_main = 10,
  layout_verbose = FALSE
)

print(p_cox)

## ----example-comparison, fig.height = 5---------------------------------------
# Use built-in multi-model data
comparison_display <- plot_data_multi %>%
  mutate(Note = c(
    "Crude model",
    "Age + Sex adjusted",
    "Fully adjusted"
  )) %>%
  select(Variable, ` `, `Model 1`, `Model 2`, `Model 3`, Note)

p_comparison <- plot_forest(
  data = comparison_display,
  est = list(df_multi$est, df_multi$est_2, df_multi$est_3),
  lower = list(df_multi$lower, df_multi$lower_2, df_multi$lower_3),
  upper = list(df_multi$upper, df_multi$upper_2, df_multi$upper_3),
  ci_column = 2,
  ref_line = 1,
  xlim = c(0.5, 3),
  nudge_y = 0.25,

  align_left = 1,
  align_center = c(3, 4, 5),
  align_right = 6,

  add_borders = TRUE,
  border_width = 4,

  layout_verbose = FALSE
)

print(p_comparison)

