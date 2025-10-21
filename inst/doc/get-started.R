## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(evanverse)

## ----install, eval = FALSE----------------------------------------------------
# # Recommended installation via GitHub
# install.packages("devtools")
# devtools::install_github("evanbio/evanverse")

## -----------------------------------------------------------------------------
"Good" %p% "morning"
#> [1] "Good morning"

## -----------------------------------------------------------------------------
combine_logic(c(TRUE, FALSE), c(TRUE, TRUE))
#> [1] TRUE FALSE

