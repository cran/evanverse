## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  eval = FALSE
)

## ----cran-install-------------------------------------------------------------
# install.packages("evanverse")

## ----github-install-----------------------------------------------------------
# # Install devtools if needed
# install.packages("devtools")
# 
# # Install evanverse
# devtools::install_github("evanbio/evanverse")

## ----minimal-install----------------------------------------------------------
# install.packages("evanverse", dependencies = c("Depends", "Imports"))

## ----full-install-------------------------------------------------------------
# install.packages("evanverse", dependencies = TRUE)

## ----version-install----------------------------------------------------------
# # Install a specific version from CRAN
# devtools::install_version("evanverse", version = "0.3.7")
# 
# # Install from a specific GitHub release
# devtools::install_github("evanbio/evanverse@v0.3.7")

## ----bioc-install-------------------------------------------------------------
# # Install BiocManager if needed
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# 
# # Install Bioconductor dependencies
# BiocManager::install(c("Biobase", "GSEABase", "biomaRt", "GEOquery"))

## ----verify-install, eval = TRUE----------------------------------------------
# Load the package
library(evanverse)

# Check version
packageVersion("evanverse")

# List available functions
pkg_functions("evanverse")

# Test basic functionality
"Hello" %p% " " %p% "World"

## ----update-cran--------------------------------------------------------------
# update.packages("evanverse")

## ----update-github------------------------------------------------------------
# devtools::install_github("evanbio/evanverse", force = TRUE)

## ----update-builtin-----------------------------------------------------------
# library(evanverse)
# update_pkg("evanverse")

## ----check-r-version----------------------------------------------------------
# R.version.string

## ----bioc-troubleshoot--------------------------------------------------------
# install.packages("BiocManager")
# BiocManager::install(c("Biobase", "GSEABase"))

## ----user-lib-install---------------------------------------------------------
# install.packages("evanverse", lib = Sys.getenv("R_LIBS_USER"))

## ----proxy-setup--------------------------------------------------------------
# Sys.setenv(http_proxy = "http://your-proxy:port")
# Sys.setenv(https_proxy = "https://your-proxy:port")

## ----uninstall----------------------------------------------------------------
# remove.packages("evanverse")

