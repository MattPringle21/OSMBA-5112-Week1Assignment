install.packages("haven")
library(tidyverse)
library(haven)
#import data, assign dataframe to "nfhs"
nfhs <- read_dta("IAHR52FL.dta")

#this project will look at households with children under the age of 6 
#it will compare the households with or without electricity

df_rural <- nfhs %>%
  select(hhid:hv208) %>%
  rename(survey_month = hv006) %>%
  filter(survey_month == 1 ) %>%
  mutate(rural = hv025 == 2)

#create a new dataframe to subset and filter data. Filter for has electricity
new_df <- nfhs %>% 
  select(hhid:hv206) %>% 
  rename(children_under6 = hv014) %>% 
  rename(electricity = hv206) %>% 
  filter(electricity == 1)

#using new_df, plot number of children in household with electricity 
ggplot(data = new_df, mapping = aes(x = children_under6)) +
  geom_histogram(binwidth = 1) +
  xlab("number of children in household with electricity")

#create a new dataframe to subset and filter data. Filtering for no electricity
new_df2 <- nfhs %>% 
  select(hhid:hv206) %>% 
  rename(children_under6 = hv014) %>% 
  rename(electricity = hv206) %>% 
  filter(electricity == 0)

#using new_df2, plot number of children in household without electricity 
ggplot(data = new_df2, mapping = aes(x = children_under6)) +
  geom_histogram(binwidth = 1) +
  xlab("number of children in household without electricity")

nfhs %>% 
  group_by(hv206) %>% 
  count()