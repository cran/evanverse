## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment  = "#>",
  eval     = FALSE
)

## ----load---------------------------------------------------------------------
# library(evanverse)

## ----get-palette-basic--------------------------------------------------------
# # Auto-detect type
# get_palette("qual_vivid")
# #> [1] "#E64B35" "#4DBBD5" "#00A087" "#3C5488" "#F39B7F" "#8491B4"
# 
# # Specify type explicitly
# get_palette("qual_vivid", type = "qualitative")
# #> [1] "#E64B35" "#4DBBD5" "#00A087" "#3C5488" "#F39B7F" "#8491B4"
# 
# # Take only the first 3 colors
# get_palette("seq_blues", type = "sequential", n = 3)
# #> [1] "#deebf7" "#9ecae1" "#3182bd"

## ----get-palette-wrong-type---------------------------------------------------
# get_palette("qual_vivid", type = "sequential")
# #> Error in `get_palette()`:
# #> ! Palette "qual_vivid" not found under "sequential", but exists under "qualitative".
# #> Try: get_palette("qual_vivid", type = "qualitative")

## ----get-palette-too-many-----------------------------------------------------
# get_palette("qual_softtrio", type = "qualitative", n = 10)
# #> Error in `get_palette()`:
# #> ! Palette "qual_softtrio" only has 3 colors, but requested 10.

## ----list-palettes-all--------------------------------------------------------
# list_palettes()
# #>              name       type n_color                                   colors
# #> 1    div_contrast  diverging       5  #2166ac, #92c5de, #f7f7f7, ...
# #> 2    div_fireice   diverging       7  #4575b4, #91bfdb, #e0f3f8, ...
# #> ...
# #> 12   qual_vivid   qualitative       6  #E64B35, #4DBBD5, #00A087, ...
# #> ...

## ----list-palettes-filter-----------------------------------------------------
# # Single type
# list_palettes(type = "qualitative")
# 
# # Multiple types
# list_palettes(type = c("sequential", "diverging"))

## ----preview-basic------------------------------------------------------------
# preview_palette("seq_blues", type = "sequential")
# preview_palette("div_fireice", plot_type = "pie")
# preview_palette("qual_vivid", n = 4, plot_type = "circle")

## ----preview-title------------------------------------------------------------
# preview_palette("qual_vivid", title = "My favourite palette")

## ----gallery-all--------------------------------------------------------------
# plots <- palette_gallery()
# #> i Type sequential: 8 palettes -> 1 page(s)
# #> v Built "sequential_page1"
# #> i Type diverging: 6 palettes -> 1 page(s)
# #> v Built "diverging_page1"
# #> i Type qualitative: 16 palettes -> 1 page(s)
# #> v Built "qualitative_page1"

## ----gallery-filter-----------------------------------------------------------
# plots <- palette_gallery(type = "qualitative")
# plots <- palette_gallery(type = c("sequential", "diverging"), max_palettes = 10)

## ----gallery-access-----------------------------------------------------------
# plots[["qualitative_page1"]]

## ----create-basic-------------------------------------------------------------
# temp_dir <- file.path(tempdir(), "palettes")
# 
# create_palette("blues", "sequential", c("#deebf7", "#9ecae1", "#3182bd"),
#                color_dir = temp_dir)
# #> v Palette saved: /tmp/.../palettes/sequential/blues.json
# 
# create_palette("qual_vivid", "qualitative",
#                c("#E64B35", "#4DBBD5", "#00A087"),
#                color_dir = temp_dir)
# #> v Palette saved: /tmp/.../palettes/qualitative/qual_vivid.json

## ----create-overwrite---------------------------------------------------------
# create_palette("blues", "sequential", c("#c6dbef", "#6baed6", "#2171b5"),
#                color_dir = temp_dir, overwrite = TRUE)
# #> i Overwriting existing palette: "blues"
# #> v Palette saved: /tmp/.../palettes/sequential/blues.json

## ----create-error-------------------------------------------------------------
# # Without overwrite = TRUE
# create_palette("blues", "sequential", c("#deebf7", "#9ecae1", "#3182bd"),
#                color_dir = temp_dir)
# #> Error in `create_palette()`:
# #> ! Palette "blues" already exists. Use `overwrite = TRUE` to replace.

## ----remove-basic-------------------------------------------------------------
# remove_palette("blues", color_dir = temp_dir)
# #> v Removed "blues" from sequential
# 
# # Specify type to skip the search
# remove_palette("qual_vivid", type = "qualitative", color_dir = temp_dir)
# #> v Removed "qual_vivid" from qualitative

## ----remove-missing-----------------------------------------------------------
# remove_palette("nonexistent", color_dir = temp_dir)
# #> ! Palette "nonexistent" not found in any type.

## ----compile------------------------------------------------------------------
# compiled <- compile_palettes(
#   palettes_dir = system.file("extdata", "palettes", package = "evanverse")
# )
# #> v Compiled 30 palettes: Sequential=8, Diverging=6, Qualitative=16

## ----compile-access-----------------------------------------------------------
# compiled$qualitative[["qual_vivid"]]
# #> [1] "#E64B35" "#4DBBD5" "#00A087" "#3C5488" "#F39B7F" "#8491B4"

## ----hex2rgb-basic------------------------------------------------------------
# hex2rgb("#FF8000")
# #>       hex   r   g b
# #> 1 #FF8000 255 128 0
# 
# hex2rgb(c("#FF8000", "#00FF00", "#3182bdB2"))
# #>          hex   r   g   b
# #> 1    #FF8000 255 128   0
# #> 2    #00FF00   0 255   0
# #> 3 #3182bdB2  49 130 189

## ----hex2rgb-error------------------------------------------------------------
# # Missing '#' prefix
# hex2rgb("FF8000")
# #> Error in `hex2rgb()`:
# #> ! `hex` contains invalid HEX codes: "FF8000".
# 
# # NA is treated as an invalid code
# hex2rgb(c("#FF8000", NA))
# #> Error in `hex2rgb()`:
# #> ! `hex` contains invalid HEX codes: NA.

## ----rgb2hex-vector-----------------------------------------------------------
# # Single color as a length-3 vector
# rgb2hex(c(255, 128, 0))
# #> [1] "#FF8000"

## ----rgb2hex-df---------------------------------------------------------------
# # Round-trip: HEX -> RGB -> HEX
# rgb2hex(hex2rgb(c("#FF8000", "#00FF00")))
# #> [1] "#FF8000" "#00FF00"

## ----rgb2hex-round------------------------------------------------------------
# # Non-integer values are rounded
# rgb2hex(c(254.7, 128.2, 0.4))
# #> [1] "#FF8000"

## ----rgb2hex-error-vector-----------------------------------------------------
# # Wrong length
# rgb2hex(c(255, 128))
# #> Error in `rgb2hex()`:
# #> ! `rgb` must be a numeric vector of length 3.
# 
# # Value out of range
# rgb2hex(c(255, 128, 300))
# #> Error in `rgb2hex()`:
# #> ! `rgb` values must be in [0, 255].

## ----rgb2hex-error-df---------------------------------------------------------
# # Missing column
# rgb2hex(data.frame(r = 255, g = 128))
# #> Error in `rgb2hex()`:
# #> ! `rgb` must have columns {"r", "g", "b"}. Missing: {"b"}.
# 
# # Column value out of range
# rgb2hex(data.frame(r = 255, g = 128, b = 300))
# #> Error in `rgb2hex()`:
# #> ! Column "b" in `rgb` must be numeric with values in [0, 255].

## ----workflow-----------------------------------------------------------------
# library(evanverse)
# 
# # 1. Retrieve a qualitative palette
# colors <- get_palette("qual_vivid", type = "qualitative", n = 4)
# colors
# #> [1] "#E64B35" "#4DBBD5" "#00A087" "#3C5488"
# 
# # 2. Convert to RGB for numeric manipulation
# rgb_df <- hex2rgb(colors)
# rgb_df
# #>       hex   r   g   b
# #> 1 #E64B35 230  75  53
# #> 2 #4DBBD5  77 187 213
# #> 3 #00A087   0 160 135
# #> 4 #3C5488  60  84 136
# 
# # 3. Lighten each color by blending 50% toward white (255)
# rgb_light <- rgb_df
# rgb_light$r <- (rgb_light$r + 255) / 2
# rgb_light$g <- (rgb_light$g + 255) / 2
# rgb_light$b <- (rgb_light$b + 255) / 2
# 
# # 4. Convert back to HEX and preview
# light_hex <- rgb2hex(rgb_light)
# light_hex
# #> [1] "#F2A59A" "#A6DDEA" "#80CFC7" "#9EAAC4"
# 
# # 5. Save the new derived palette for reuse
# temp_dir <- file.path(tempdir(), "palettes")
# create_palette("qual_vivid_light", "qualitative", light_hex,
#                color_dir = temp_dir)
# #> v Palette saved: /tmp/.../palettes/qualitative/qual_vivid_light.json
# 
# # 6. Verify the new palette is retrievable
# "qual_vivid_light" %in% list_palettes(type = "qualitative")$name
# #> [1] TRUE
# 
# # 7. Clean up
# unlink(temp_dir, recursive = TRUE)

