## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(evanverse)

## ----eval = FALSE-------------------------------------------------------------
# # Install a single CRAN package
# inst_pkg("dplyr", source = "CRAN")
# 
# # Install from GitHub
# inst_pkg("evanbio/evanverse", source = "GitHub")
# 
# # Install Bioconductor packages
# inst_pkg("edgeR", source = "Bioconductor")

## ----eval = FALSE-------------------------------------------------------------
# check_pkg("ggplot2")    # TRUE
# check_pkg("notapkg")    # FALSE

## ----eval = FALSE-------------------------------------------------------------
# # Update CRAN and Bioconductor packages
# update_pkg()
# 
# # Update GitHub packages only
# update_pkg(pkg = c("evanbio/evanverse", "rstudio/gt"), source = "GitHub")
# 
# # Update specific Bioconductor package
# update_pkg(pkg = "limma", source = "Bioconductor")

