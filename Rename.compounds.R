## Temp script to rename compounds to updated Ingalls Standards names

source("Functions.R")

library(tidyverse)
options(scipen = 999)

file.pattern <- "BMISd"

# Import all files --------------------------------------------------
filenames <- RemoveCsv(list.files(path = 'data_raw', pattern = file.pattern))

for (i in filenames) {
  filepath <- file.path('data_raw', paste(i,".csv", sep = ""))
  assign(make.names(i), read.csv(filepath, stringsAsFactors = FALSE, check.names = TRUE))
}

Ingalls.Standards <- read.csv(
  "https://raw.githubusercontent.com/IngallsLabUW/Ingalls_Standards/master/Ingalls_Lab_Standards_NEW.csv") %>%
  select(Compound.Name, Compound.Name_old) %>%
  rename(Compound.Name_new = Compound.Name,
         Mass.Feature = Compound.Name_old)

# Rename compounds --------------------------------------------------
Names.Fixed <- BMISd_Time0_Fixed_2020.08.03 %>%
  mutate(Mass.Feature = recode(Mass.Feature, 
                               "2-Hydroxy-4-(methylthio)butyric" = "2-Hydroxy-4-(methylthio)butyric_acid")) %>%
  left_join(Ingalls.Standards, by = "Mass.Feature") 

BMISd <- Names.Fixed %>%
  select(Compound.Name_new, Replicate.Name, Adjusted.Area) %>%
  rename(Mass.Feature = Compound.Name_new)

write.csv(BMISd, "data_processed/BMISd_CmpdNamesFixed.csv")

