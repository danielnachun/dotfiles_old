#String operations
library(stringr)

library(openxlsx)

library(GEOquery)
library(lumi)
library(lumiMouseIDMapping)
library(lumiMouseAll.db)

#Functional programming
library(magrittr)
library(purrr)
library(functional)
library(vadr)

#Data arrangement
library(reshape2)
library(plyr)
library(dplyr)
library(tidyr)
library(doBy)


#Redundant
GSE15843.raw <- getGEO("GSE15843", destdir = "./save")[[1]]
GSE15843.pdata <- pData(GSE15843.raw) %>% select(title, characteristics_ch1, characteristics_ch1.1)

#hPSC_iPS are control iPSC-derived neurons, neuronal.diff are patient-dervied iPSCs
GSE65399.raw <- getGEO("GSE65399", destdir = "./save")[[1]]
GSE65399.pdata <- pData(GSE65399.raw) %>% select(title)
write.xlsx(pData(GSE65399.raw), "./GSE65399.xlsx")

#3 statuses, 5 treatments
GSE30933.raw <- getGEO("GSE30933", destdir = "./save")[[1]]
GSE30933.pdata <- pData(GSE30933.raw) %>% select(title, characteristics_ch1, characteristics_ch1.1)

#huh?
GSE22651.raw <- getGEO("GSE22651", destdir = "./save")[[1]]
GSE22651.pdata <- pData(GSE22651.raw) %>% select(title, characteristics_ch1, source_name_ch1, characteristics_ch1.1, characteristics_ch1.2)

#only 1 patient
GSE5040.raw <- getGEO("GSE5040", destdir = "./save")[[1]]
GSE5040.pdata <- pData(GSE5040.raw) %>% select(title, characteristics_ch1)
