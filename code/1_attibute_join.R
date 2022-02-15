## Clear workspace and console
rm(list=ls()); cat("\014")

# Load required packages
library(FSA); library(plyr); library(dplyr); library(magrittr); library(ggplot2)
library(lubridate); library(tidyr); library(scales); library(gridExtra)
library(tidyverse)
library(patchwork)

#--------------------------------------

# CODE to clean up and begin analysis on MCD and SB isotope data

#1. need to combine fish attribute data with isotope data 

# load isotope data
 
# manually added 'lake' and 'year' columns to isotope dataset, 
# created 'simple ID' without year (going to combine with lake separately), simplified column names
iso = read.csv('data/wae_sos_isotopes_2017-2020_davis.csv')

# select necessary columns 
iso %<>% select(-c("Analysis","Internal.ID","Analysis.Number","Mass.Spec")) %>%
  rename(id_original_iso = id_original,
         id_simple_iso = id_simple)

# create new isotope sample id consistent fish attribute ids
iso$id_year = paste(iso$id_simple, iso$year, sep="_")

# load fish attribute data
fish = read.csv('data/fish_processing_all_thru_2021.csv')
fish$id_year = paste(fish$id_simple, fish$Sample.Year, sep="_")

fish %<>% select(-c("Sample.Date","Processing.Date","Gear","Site","Time","gonad.wt..only.M.BG.","age","X","unknown","Notes")) %>%
  rename(id_original_fish = id_original,
         id_simple_fish = id_simple,
         year = Sample.Year,
         tl.mm = Total.length..mm.,
         wt.g = Weight..g.,
         diet.wt.g = diet.weight..g.,
         diet.contents.note = diet.contents....)



# want to do a left join of attributes to those fish took iso on 
iso.att = left_join(iso, fish, by=c("id_year","year"))

# write out dataset to deal with NAs manually 
#write.csv(iso.att, 'data/iso_att_fix.csv', row.names = F)


#==========
# read in competed attribute dataset

iso.att = read.csv('data/iso_attributes_complete.csv')








