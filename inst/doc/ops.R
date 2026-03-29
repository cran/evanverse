## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment  = "#>",
  eval     = FALSE
)

## ----load---------------------------------------------------------------------
# library(evanverse)

## ----p-basic------------------------------------------------------------------
# "Hello" %p% "world"
# #> [1] "Hello world"
# 
# c("good", "hello") %p% c("morning", "world")
# #> [1] "good morning" "hello world"

## ----p-recycle----------------------------------------------------------------
# "Gene:" %p% c("TP53", "BRCA1", "MYC")
# #> [1] "Gene: TP53"  "Gene: BRCA1" "Gene: MYC"

## ----p-empty------------------------------------------------------------------
# "" %p% "world"
# #> [1] " world"

## ----p-error------------------------------------------------------------------
# "Hello" %p% NA
# #> Error in `%p%()`:
# #> ! `rhs` must be a non-empty character vector without NA values.
# 
# 123 %p% "world"
# #> Error in `%p%()`:
# #> ! `lhs` must be a non-empty character vector without NA values.

## ----nin-basic----------------------------------------------------------------
# c("A", "B", "C") %nin% c("B", "D")
# #> [1]  TRUE FALSE  TRUE
# 
# 1:5 %nin% c(2, 4)
# #> [1]  TRUE FALSE  TRUE FALSE  TRUE

## ----nin-na-------------------------------------------------------------------
# # NA matches NA in the table
# NA %nin% c(NA, 1)
# #> [1] FALSE
# 
# # NA does not match non-NA elements
# NA %nin% c(1, 2)
# #> [1] TRUE

## ----nin-coerce---------------------------------------------------------------
# c("1", "2") %nin% c(1, 2)
# #> [1] FALSE FALSE

## ----nin-empty----------------------------------------------------------------
# c("a", "b") %nin% character(0)   # nothing to be in
# #> [1] TRUE TRUE
# 
# character(0) %nin% c("a", "b")
# #> logical(0)

## ----match-basic--------------------------------------------------------------
# c("tp53", "BRCA1", "egfr") %match% c("TP53", "EGFR", "MYC")
# #> [1]  1 NA  2

## ----match-dupe-table---------------------------------------------------------
# c("x") %match% c("X", "x", "X")
# #> [1] 1

## ----match-dupe-x-------------------------------------------------------------
# c("tp53", "tp53") %match% c("TP53", "EGFR")
# #> [1] 1 1

## ----match-error--------------------------------------------------------------
# # empty x
# character(0) %match% c("TP53")
# #> Error in `%match%()`:
# #> ! `x` must be a non-empty character vector without NA values.
# 
# # NA in x
# c("tp53", NA) %match% c("TP53")
# #> Error in `%match%()`:
# #> ! `x` must be a non-empty character vector without NA values.
# 
# # empty table
# c("tp53") %match% character(0)
# #> Error in `%match%()`:
# #> ! `table` must be a non-empty character vector without NA values.
# 
# # NA in table
# c("tp53") %match% c("TP53", NA)
# #> Error in `%match%()`:
# #> ! `table` must be a non-empty character vector without NA values.

## ----map-basic----------------------------------------------------------------
# c("tp53", "brca1", "egfr") %map% c("TP53", "EGFR", "MYC")
# #>   TP53   EGFR
# #> "tp53" "egfr"

## ----map-order----------------------------------------------------------------
# c("egfr", "tp53") %map% c("TP53", "EGFR")
# #>   EGFR   TP53
# #> "egfr" "tp53"

## ----map-drop-----------------------------------------------------------------
# c("akt1", "tp53") %map% c("TP53", "EGFR")
# #>   TP53
# #> "tp53"

## ----map-none-----------------------------------------------------------------
# c("none1", "none2") %map% c("TP53", "EGFR")
# #> named character(0)

## ----map-dupe-----------------------------------------------------------------
# c("tp53", "tp53") %map% c("TP53", "EGFR")
# #>   TP53   TP53
# #> "tp53" "tp53"

## ----map-error----------------------------------------------------------------
# # empty x
# character(0) %map% c("TP53")
# #> Error in `%map%()`:
# #> ! `x` must be a non-empty character vector without NA values.
# 
# # NA in x
# c("tp53", NA) %map% c("TP53")
# #> Error in `%map%()`:
# #> ! `x` must be a non-empty character vector without NA values.
# 
# # empty table
# c("tp53") %map% character(0)
# #> Error in `%map%()`:
# #> ! `table` must be a non-empty character vector without NA values.
# 
# # NA in table
# c("tp53") %map% c("TP53", NA)
# #> Error in `%map%()`:
# #> ! `table` must be a non-empty character vector without NA values.

## ----is-basic-----------------------------------------------------------------
# 1:3 %is% 1:3
# #> [1] TRUE
# 
# "hello" %is% "hello"
# #> [1] TRUE
# 
# list(a = 1) %is% list(a = 1)
# #> [1] TRUE

## ----is-mismatch--------------------------------------------------------------
# 1:3 %is% c(1, 2, 3)          # integer vs double
# #> [1] FALSE
# 
# c(a = 1, b = 2) %is% c(b = 1, a = 2)   # same values, different names
# #> [1] FALSE

## ----is-null-na---------------------------------------------------------------
# NULL %is% NULL
# #> [1] TRUE
# 
# NA %is% NA
# #> [1] TRUE
# 
# NA %is% NA_real_   # logical NA vs double NA
# #> [1] FALSE

## ----workflow-----------------------------------------------------------------
# library(evanverse)
# 
# canonical <- c("TP53", "BRCA1", "EGFR", "MYC", "PTEN")
# query     <- c("tp53", "brca1", "AKT1", "egfr", "unknown")
# 
# # 1. Which queries are not in the canonical set (case-insensitive)?
# missing_idx <- which(is.na(query %match% canonical))
# query[missing_idx]
# #> [1] "AKT1"    "unknown"
# 
# # 2. Map matched queries to their canonical names
# query %map% canonical
# #>    TP53   BRCA1    EGFR
# #> "tp53" "brca1"  "egfr"
# 
# # 3. Build an annotation column using %p%
# anno <- "Gene:" %p% canonical
# anno
# #> [1] "Gene: TP53"  "Gene: BRCA1" "Gene: EGFR"  "Gene: MYC"   "Gene: PTEN"
# 
# # 4. Check that the canonical list hasn't changed
# canonical %is% c("TP53", "BRCA1", "EGFR", "MYC", "PTEN")
# #> [1] TRUE

