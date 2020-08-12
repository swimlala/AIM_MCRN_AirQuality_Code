library(dplyr)
library(readr)

modena_full <- read_csv("modena_full.csv")
modena_rtresult <- read_csv("modena_rtresult.csv")

modena_full$Date <- as.Date(modena_full$Date, "%m/%d/%y")
modena_rtresult$Date <- modena_rtresult$date
modena_all <- left_join(modena_full, modena_rtresult)
write.csv(modena_all, "modena_airRT.csv") 






