## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment  = "#>",
  eval     = FALSE
)

## ----load---------------------------------------------------------------------
# library(evanverse)

## ----set-mirror-basic---------------------------------------------------------
# # Set both mirrors to Tsinghua (default)
# set_mirror()
# #> v CRAN mirror set to: https://mirrors.tuna.tsinghua.edu.cn/CRAN
# #> v Bioconductor mirror set to: https://mirrors.tuna.tsinghua.edu.cn/bioconductor
# 
# # CRAN only
# set_mirror("cran", "ustc")
# #> v CRAN mirror set to: https://mirrors.ustc.edu.cn/CRAN
# 
# # Bioconductor only
# set_mirror("bioc", "nju")
# #> v Bioconductor mirror set to: https://mirrors.nju.edu.cn/bioconductor

## ----set-mirror-error---------------------------------------------------------
# set_mirror("all", "aliyun")
# #> Error in `set_mirror()`:
# #> ! Mirror "aliyun" is CRAN-only and cannot be used with `repo = "all"`.
# #> i Use `set_mirror("cran", "aliyun")` instead.
# #> i Shared mirrors: "official", "tuna", "ustc", "westlake", "nju"

## ----set-mirror-restore-------------------------------------------------------
# prev <- set_mirror("cran", "tuna")
# # ... do work ...
# options(prev)  # restore original mirror

## ----inst-cran----------------------------------------------------------------
# # CRAN
# inst_pkg("ggplot2", source = "CRAN")
# #> i Installing from CRAN: ggplot2
# #> v Installation complete!
# 
# # Multiple packages at once
# inst_pkg(c("dplyr", "tidyr", "purrr"), source = "CRAN")

## ----inst-github--------------------------------------------------------------
# # GitHub — basic "user/repo" format
# inst_pkg("hadley/emo", source = "GitHub")
# 
# # devtools extended formats are also accepted:
# # @ref pins a specific branch, tag, or SHA; #pr installs from a pull request
# inst_pkg("tidyverse/ggplot2@v3.4.0", source = "GitHub")
# inst_pkg("r-lib/cli#123",            source = "GitHub")

## ----inst-bioc----------------------------------------------------------------
# # Bioconductor
# inst_pkg("DESeq2",    source = "Bioconductor")
# inst_pkg("scRNAseq",  source = "Bioconductor")

## ----inst-local---------------------------------------------------------------
# # Local file
# inst_pkg(source = "Local", path = "mypackage_1.0.0.tar.gz")

## ----inst-local-error---------------------------------------------------------
# inst_pkg(source = "Local")
# #> Error in `inst_pkg()`:
# #> ! Must provide `path` for local installation.

## ----inst-skip----------------------------------------------------------------
# inst_pkg("ggplot2", source = "CRAN")
# #> i Package ggplot2 is already installed. Skipped.
# #> v All packages already installed.

## ----check-basic--------------------------------------------------------------
# check_pkg("ggplot2", source = "CRAN")
# #> # A tibble: 1 × 4
# #>   package name    installed source
# #>   <chr>   <chr>   <lgl>     <chr>
# #> 1 ggplot2 ggplot2 TRUE      CRAN

## ----check-multiple-----------------------------------------------------------
# check_pkg(c("ggplot2", "fakepkg123"), source = "CRAN")
# #> v Installed: ggplot2
# #> ! Missing: fakepkg123
# #> # A tibble: 2 × 4
# #>   package    name       installed source
# #>   <chr>      <chr>      <lgl>     <chr>
# #> 1 ggplot2    ggplot2    TRUE      CRAN
# #> 2 fakepkg123 fakepkg123 FALSE     CRAN

## ----check-github-------------------------------------------------------------
# check_pkg("r-lib/cli", source = "GitHub")
# #> # A tibble: 1 × 4
# #>   package   name  installed source
# #>   <chr>     <chr> <lgl>     <chr>
# #> 1 r-lib/cli cli   TRUE      GitHub

## ----check-auto---------------------------------------------------------------
# check_pkg(c("ggplot2", "fakepkg123"), source = "CRAN", auto_install = TRUE)
# #> v Installed: ggplot2
# #> ! Missing: fakepkg123
# #> i Installing from CRAN: fakepkg123
# #> ...

## ----update-all---------------------------------------------------------------
# # Update all CRAN + Bioconductor packages
# update_pkg()
# #> i Checking for BiocManager updates...
# #> i Upgrading Bioconductor packages to version 3.21...
# #> v Bioconductor upgraded to version 3.21.
# #> i Updating all CRAN packages...
# #> v Update complete!

## ----update-source------------------------------------------------------------
# # CRAN only
# update_pkg(source = "CRAN")
# 
# # Bioconductor only (full Bioc upgrade)
# update_pkg(source = "Bioconductor")

## ----update-targeted----------------------------------------------------------
# # Specific packages
# update_pkg("ggplot2",            source = "CRAN")
# update_pkg("hadley/ggplot2",     source = "GitHub")
# update_pkg("DESeq2",             source = "Bioconductor")

## ----update-error-------------------------------------------------------------
# update_pkg("ggplot2")
# #> Error in `update_pkg()`:
# #> ! Must specify `source` when providing `pkg`.

## ----pkg-version-basic--------------------------------------------------------
# pkg_version(c("ggplot2", "dplyr"))
# #>   package version latest source
# #> 1 ggplot2   3.4.4  3.5.0   CRAN
# #> 2   dplyr   1.1.4  1.1.4   CRAN

## ----pkg-version-unknown------------------------------------------------------
# pkg_version("nonexistentpkg")
# #>        package version latest      source
# #> 1 nonexistentpkg    <NA>   <NA> Not Found

## ----pkg-version-github-------------------------------------------------------
# pkg_version("emo")
# #>   package version  latest                      source
# #> 1     emo   0.0.1 a1b2c3d GitHub (hadley/emo@master)

## ----pkg-version-dedup--------------------------------------------------------
# pkg_version(c("ggplot2", "ggplot2"))
# #>   package version latest source
# #> 1 ggplot2   3.4.4  3.5.0   CRAN

## ----pkg-functions-basic------------------------------------------------------
# pkg_functions("evanverse")
# #>  [1] "check_pkg"       "compile_palettes" "create_palette"  "df2list"
# #>  [5] "df2vect"         "file_info"        "file_ls"         "file_tree"
# #>  ...

## ----pkg-functions-key--------------------------------------------------------
# # Filter by keyword (case-insensitive)
# pkg_functions("evanverse", key = "palette")
# #> [1] "compile_palettes" "create_palette"   "get_palette"
# #> [4] "list_palettes"    "palette_gallery"   "preview_palette"
# #> [7] "remove_palette"
# 
# pkg_functions("stats", key = "test")
# #> [1] "ansari.test"     "bartlett.test"   "binom.test"
# #> [4] "chisq.test"      "cor.test"        "fisher.test"
# #> ...

## ----pkg-functions-empty------------------------------------------------------
# pkg_functions("stats", key = "zzzzzz")
# #> character(0)

## ----pkg-functions-error------------------------------------------------------
# pkg_functions("somefakepkg")
# #> Error in `pkg_functions()`:
# #> ! Package `somefakepkg` is not installed.

## ----workflow-----------------------------------------------------------------
# library(evanverse)
# 
# # 1. Switch to a fast local mirror
# set_mirror("all", "tuna")
# #> v CRAN mirror set to: https://mirrors.tuna.tsinghua.edu.cn/CRAN
# #> v Bioconductor mirror set to: https://mirrors.tuna.tsinghua.edu.cn/bioconductor
# 
# # 2. Define required packages
# cran_pkgs <- c("ggplot2", "dplyr", "purrr", "readxl")
# bioc_pkgs <- c("DESeq2", "clusterProfiler")
# 
# # 3. Check what is already installed
# cran_status <- check_pkg(cran_pkgs, source = "CRAN")
# bioc_status <- check_pkg(bioc_pkgs, source = "Bioconductor")
# 
# # 4. Install only missing packages
# missing_cran <- cran_status$name[!cran_status$installed]
# missing_bioc <- bioc_status$name[!bioc_status$installed]
# 
# if (length(missing_cran) > 0) inst_pkg(missing_cran, source = "CRAN")
# if (length(missing_bioc) > 0) inst_pkg(missing_bioc, source = "Bioconductor")
# 
# # 5. Verify versions -flag anything outdated
# versions <- pkg_version(c(cran_pkgs, bioc_pkgs))
# outdated <- versions[!is.na(versions$version) &
#                      !is.na(versions$latest)   &
#                      versions$version != versions$latest, ]
# outdated
# #>      package version latest source
# #> 1    ggplot2   3.4.4  3.5.0   CRAN
# #> 2     DESeq2  1.38.0 1.40.0   Bioconductor
# 
# # 6. Update only the outdated ones
# if (nrow(outdated) > 0) {
#   cran_out <- outdated$package[outdated$source == "CRAN"]
#   bioc_out <- outdated$package[outdated$source == "Bioconductor"]
#   if (length(cran_out) > 0) update_pkg(cran_out, source = "CRAN")
#   if (length(bioc_out) > 0) update_pkg(bioc_out, source = "Bioconductor")
# }
# 
# # 7. Confirm evanverse exports look right
# pkg_functions("evanverse", key = "pkg")
# #> [1] "check_pkg"    "inst_pkg"     "pkg_functions" "pkg_version"  "update_pkg"

