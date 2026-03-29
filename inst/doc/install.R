## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment  = "#>",
  eval     = FALSE
)

## ----load---------------------------------------------------------------------
# library(evanverse)

## ----install-cran-------------------------------------------------------------
# install.packages("evanverse")

## ----install-github-----------------------------------------------------------
# install.packages("devtools")
# devtools::install_github("evanbio/evanverse")

## ----install-deps-------------------------------------------------------------
# # Minimal: Depends + Imports only
# install.packages("evanverse", dependencies = c("Depends", "Imports"))
# 
# # Full: include Suggests
# install.packages("evanverse", dependencies = TRUE)

## ----set-mirror-basic---------------------------------------------------------
# # Set both CRAN + Bioconductor mirrors (default mirror: tuna)
# set_mirror()
# #> v CRAN mirror set to: https://mirrors.tuna.tsinghua.edu.cn/CRAN
# #> v Bioconductor mirror set to: https://mirrors.tuna.tsinghua.edu.cn/bioconductor
# 
# # CRAN only
# set_mirror("cran", "westlake")
# 
# # Bioconductor only
# set_mirror("bioc", "official")

## ----set-mirror-error---------------------------------------------------------
# set_mirror("all", "aliyun")
# #> Error in `set_mirror()`:
# #> ! Mirror "aliyun" is CRAN-only and cannot be used with repo = "all".

## ----inst-cran----------------------------------------------------------------
# inst_pkg("dplyr", source = "CRAN")

## ----inst-github--------------------------------------------------------------
# inst_pkg("hadley/emo", source = "GitHub")

## ----inst-bioc----------------------------------------------------------------
# inst_pkg("DESeq2", source = "Bioconductor")

## ----inst-local---------------------------------------------------------------
# inst_pkg(source = "Local", path = "mypackage_1.0.0.tar.gz")

## ----inst-local-error---------------------------------------------------------
# inst_pkg(source = "Local")
# #> Error in `inst_pkg()`:
# #> ! Must provide `path` for local installation.

## ----check-basic--------------------------------------------------------------
# check_pkg("ggplot2", source = "CRAN")
# #> # A tibble: 1 x 4
# #>   package name    installed source
# #>   <chr>   <chr>   <lgl>     <chr>
# #> 1 ggplot2 ggplot2 TRUE      CRAN

## ----check-multiple-----------------------------------------------------------
# check_pkg(c("ggplot2", "fakepkg123"), source = "CRAN")
# #> v Installed: ggplot2
# #> ! Missing: fakepkg123

## ----check-auto---------------------------------------------------------------
# check_pkg(c("ggplot2", "fakepkg123"), source = "CRAN", auto_install = TRUE)
# #> i Installing missing packages automatically...

## ----check-github-------------------------------------------------------------
# check_pkg("r-lib/devtools", source = "GitHub")

## ----update-all---------------------------------------------------------------
# # Update all CRAN + Bioconductor packages
# update_pkg()

## ----update-cran-only---------------------------------------------------------
# # CRAN only
# update_pkg(source = "CRAN")

## ----update-specific----------------------------------------------------------
# # Specific package(s)
# update_pkg("ggplot2", source = "CRAN")
# update_pkg("hadley/ggplot2", source = "GitHub")
# update_pkg("DESeq2", source = "Bioconductor")

## ----check-r-version----------------------------------------------------------
# R.version.string

## ----install-biocmanager------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE)) {
#   install.packages("BiocManager")
# }
# BiocManager::install(c("Biobase", "GSEABase", "biomaRt", "GEOquery"))

## ----proxy--------------------------------------------------------------------
# Sys.setenv(http_proxy = "http://your-proxy:port")
# Sys.setenv(https_proxy = "https://your-proxy:port")

## ----user-lib-----------------------------------------------------------------
# install.packages("evanverse", lib = Sys.getenv("R_LIBS_USER"))

## ----workflow-----------------------------------------------------------------
# # 1) Install evanverse
# install.packages("evanverse")
# library(evanverse)
# 
# # 2) Set mirrors
# set_mirror("all", "tuna")
# 
# # 3) Install key dependencies
# inst_pkg(c("dplyr", "ggplot2"), source = "CRAN")
# inst_pkg("DESeq2", source = "Bioconductor")
# 
# # 4) Verify status
# check_pkg(c("dplyr", "ggplot2", "DESeq2"), source = "CRAN")
# 
# # 5) Keep packages updated
# update_pkg(source = "CRAN")

