library(readr)
library(dplyr)
library(ggplot2)
theme_set(theme_minimal())
library(broom)

# Data
drivers <- read_csv("Data/bad-drivers.csv")
# - clean names
drivers <- drivers %>% 
  select(State, 
         fatal_per_bmiles = `Number of drivers involved in fatal collisions per billion miles`,
         perc_fatal_Speeding = `Percentage Of Drivers Involved In Fatal Collisions Who Were Speeding`,
         perc_fatal_Alcohol = `Percentage Of Drivers Involved In Fatal Collisions Who Were Alcohol-Impaired`,
         perc_fatal_Not_Distracted = `Percentage Of Drivers Involved In Fatal Collisions Who Were Not Distracted`,
         perc_fatal_No_Previous_Accidents = `Percentage Of Drivers Involved In Fatal Collisions Who Had Not Been Involved In Any Previous Accidents`,
         premium = `Car Insurance Premiums ($)`,
         lossess_per_insured_driver = `Losses incurred by insurance companies for collisions per insured driver ($)`)



# Exploratory Data Analysis
# - summary
drivers %>% skimr::skim()
# Corrplot
drivers %>% select(-State) %>% cor() %>% 
  ggcorrplot::ggcorrplot(type = "lower", 
                         lab = TRUE, lab_col = "gray50")
# - 0.2 = weak
# - 0.5 = medium
# - 0.8 = strong
# - 0.9 = very strong
lm(fatal_per_bmiles ~ perc_fatal_Alcohol + perc_fatal_Speeding + perc_fatal_No_Previous_Accidents + perc_fatal_Not_Distracted,
   data = drivers) %>% tidy()
