## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(
  echo = TRUE,
  warning = FALSE,
  message = FALSE,
  fig.width = 10,
  fig.height = 6,
  collapse = TRUE,
  comment = "#>"
)

library(evanverse)

## ----eval=FALSE---------------------------------------------------------------
# library(evanverse)
# 
# # Type is inferred from prefix
# get_palette("seq_sunset")    # Automatically knows type = "sequential"
# get_palette("div_redblue")   # Automatically knows type = "diverging"
# get_palette("qual_vivid")    # Automatically knows type = "qualitative"
# 
# # Can still specify type explicitly
# get_palette("seq_sunset", type = "sequential")
# 
# # Wrong type will error with helpful message
# get_palette("seq_sunset", type = "diverging")
# #> Error: Palette 'seq_sunset' is sequential, not diverging

## ----eval=FALSE---------------------------------------------------------------
# # List all palettes
# list_palettes()
# 
# # Filter by type
# list_palettes(type = "sequential")
# list_palettes(type = c("diverging", "qualitative"))

## ----eval=FALSE---------------------------------------------------------------
# library(ggplot2)
# 
# # Sequential - continuous values
# ggplot(data, aes(x, y, fill = expression)) +
#   geom_tile() +
#   scale_fill_gradientn(colors = get_palette("seq_sunset"))
# 
# # Diverging - fold change
# ggplot(data, aes(x, y, color = log2FC)) +
#   geom_point() +
#   scale_color_gradientn(colors = get_palette("div_redblue"))
# 
# # Qualitative - categories
# ggplot(iris, aes(Sepal.Length, Sepal.Width, color = Species)) +
#   geom_point() +
#   scale_color_manual(values = get_palette("qual_vivid"))

## ----eval=FALSE---------------------------------------------------------------
# create_palette(
#   name = "qual_ocean",
#   type = "qualitative",
#   colors = c("#006BA4", "#FF7F0E", "#2CA02C", "#D62728", "#9467BD"),
#   color_dir = system.file("extdata", "palettes", package = "evanverse")
# )

## ----eval=FALSE---------------------------------------------------------------
# # Recompile palettes.rds
# compile_palettes(
#   palettes_dir = system.file("extdata", "palettes", package = "evanverse"),
#   output_rds = system.file("extdata", "palettes.rds", package = "evanverse")
# )
# 
# # Test
# get_palette("qual_ocean")
# preview_palette("qual_ocean", type = "qualitative")

