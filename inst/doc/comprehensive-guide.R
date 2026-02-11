## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  fig.width = 7,
  fig.height = 5,
  fig.align = "center",
  warning = FALSE,
  message = FALSE
)

## ----package-install, eval=FALSE----------------------------------------------
# # Install from CRAN
# install.packages("evanverse")
# 
# # Or install development version from GitHub
# evanverse::inst_pkg("evanbio/evanverse")

## ----package-load-------------------------------------------------------------
library(evanverse)

## ----package-check------------------------------------------------------------
# Check if packages are installed
required_packages <- c("dplyr", "ggplot2", "tidyr")
check_pkg(required_packages)

# Get package version (skip on CRAN due to network dependency)
if (!identical(Sys.getenv("NOT_CRAN"), "false")) {
  try(pkg_version("evanverse"), silent = TRUE)
}

## ----palettes-list------------------------------------------------------------
# List all available palettes
palettes_info <- list_palettes()
print(palettes_info)

## ----palettes-demo------------------------------------------------------------
# Get specific palettes
vivid_colors <- get_palette("qual_vivid", type = "qualitative")
blues_gradient <- get_palette("seq_blues", type = "sequential")

cat("Vivid qualitative palette:\n")
print(vivid_colors)

cat("\nBlues sequential palette:\n")
print(blues_gradient)

## ----custom-palette-----------------------------------------------------------
# Create a custom palette (demonstration only - not executed to avoid file creation)
custom_colors <- c("#FF6B6B", "#4ECDC4", "#45B7D1", "#96CEB4")

# Example of how to create a custom palette (using temp directory):
# create_palette(
#   name = "custom_demo",
#   colors = custom_colors,
#   type = "qualitative",
#   color_dir = tempdir()  # Use temporary directory to avoid cluttering package
# )

# Preview the custom colors
print("Custom palette colors:")
print(custom_colors)
cat("This would create a palette named 'custom_demo' with", length(custom_colors), "colors\n")

## ----venn-demo, fig.cap="Venn diagram example"--------------------------------
# Create sample data for Venn diagram
set1 <- c("A", "B", "C", "D", "E")
set2 <- c("C", "D", "E", "F", "G")
set3 <- c("E", "F", "G", "H", "I")

# Create Venn diagram
venn_plot <- plot_venn(
  set1 = set1,
  set2 = set2,
  set3 = set3,
  category.names = c("Set1", "Set2", "Set3"),
  title = "Three-way Venn Diagram Example"
)
print(venn_plot)

## ----bar-demo, fig.cap="Professional bar plot"--------------------------------
# Sample data
sample_data <- data.frame(
  Category = c("Type A", "Type B", "Type C"),
  Count = c(25, 18, 12),
  Group = c("High", "High", "Medium")
)

# Create bar plot with custom colors
vivid_colors <- get_palette("qual_vivid", type = "qualitative")
bar_plot <- plot_bar(data = sample_data,
                     x = "Category",
                     y = "Count",
                     fill = "Group") +
  ggplot2::scale_fill_manual(values = vivid_colors) +
  ggplot2::labs(title = "Sample Distribution by Category",
                x = "Sample Type",
                y = "Count")
print(bar_plot)

## ----gene-conversion, eval=FALSE----------------------------------------------
# # Convert gene symbols to Ensembl IDs
# gene_symbols <- c("TP53", "BRCA1", "EGFR")
# ensembl_ids <- convert_gene_id(
#   ids = gene_symbols,
#   from = "SYMBOL",
#   to = "ENSEMBL",
#   species = "human"
# )
# print(ensembl_ids)

## ----gmt-processing, eval=FALSE-----------------------------------------------
# # Convert GMT file to data frame
# gmt_df <- gmt2df("path/to/geneset.gmt")
# head(gmt_df)
# 
# # Convert GMT file to list
# gmt_list <- gmt2list("path/to/geneset.gmt")
# length(gmt_list)

## ----void-handling------------------------------------------------------------
# Create sample vector with void values
messy_vector <- c("A", "", "C", NA, "E")

print("Original vector:")
print(messy_vector)

# Check for void values
cat("\nAny void values:", any_void(messy_vector), "\n")

# Replace void values
clean_vector <- replace_void(messy_vector, value = "MISSING")
print("After replacing voids:")
print(clean_vector)

## ----data-transform-----------------------------------------------------------
# Convert data frame to grouped list by cylinder count
grouped_data <- df2list(
  data = mtcars[1:10, ],
  key_col = "cyl",
  value_col = "mpg"
)

print("Cars grouped by cylinder, showing MPG values:")
str(grouped_data)

## ----operators-demo-----------------------------------------------------------
# Demonstrate custom operators
x <- c(1, 2, 3, 4, 5)
y <- c(3, 4, 5, 6, 7)

# Check what's NOT in another vector
print(x %nin% y)

# Paste operator
result <- "Hello" %p% " " %p% "World"
print(result)

# Check identity
print(5 %is% 5)

## ----file-operations, eval=FALSE----------------------------------------------
# # Read various file formats flexibly
# data1 <- read_table_flex("data.csv")
# data2 <- read_excel_flex("data.xlsx", sheet = 1)
# 
# # Get file information
# file_info("data.csv")
# 
# # Display directory tree
# file_tree(".")

## ----timing-demo--------------------------------------------------------------
# Time execution of code
result <- with_timer(function() {
  Sys.sleep(0.01)  # Quick simulation
  sum(1:1000)
}, name = "Sum calculation")

print(result)

## ----safe-execution-----------------------------------------------------------
# Execute code safely
safe_result <- safe_execute({
  x <- 1:10
  mean(x)
})

print(safe_result)

