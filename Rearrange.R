# This script is intended to be applied to data that have already been processed through 
# the Ingalls Lab targeted pipeline:
#
# 1. Import of raw data csvs
# 2. Quality control
# 3. BMIS
# 4. If applicable, quantification
#
# Once the data are a single, processed, long dataframe, they can be put through this script,
# which will format them for upload to CMAP.

# In this case, the "data_raw/" folder DOES NOT CONTAIN COMPLETELY RAW CSVs FROM THE INSTRUMENTS.
# Instead, it should contain a post-processed datasheet containing data in at least step 3 of 
# the above steps.

source("Functions.R")

library(tidyverse)
options(scipen = 999)

file.pattern <- "BMISd"

# Import all files --------------------------------------------------
filenames <- RemoveCsv(list.files(path = "data_processed/", pattern = file.pattern))

for (i in filenames) {
  filepath <- file.path("data_processed/", paste(i,".csv", sep = ""))
  assign(make.names(i), read.csv(filepath, stringsAsFactors = FALSE, check.names = TRUE) %>%
           select(-X))
}


