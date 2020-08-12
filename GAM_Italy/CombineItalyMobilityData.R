#load data
load("italy_full.RData")
Italy_Mobility <- read_csv("Italy_Mobility_Report.csv")

#Combine italy_full and mobility

#Change date from character to date format
Italy_Mobility$date <- as.Date(Italy_Mobility$date, "%m/%d/%y")
italy_full$Date <- as.Date(italy_full$Date, "%m/%d/%y")
#remove end of string to make plotting look nicer
names(Italy_Mobility) <- sapply(strsplit(names(Italy_Mobility), "_percent_change_from_baseline"), `[[`, 1)

#Make format the same as mobility data for easier combining
italy_full$date <- italy_full$Date
#Find day of the week from date column
italy_full$weekday <- weekdays(italy_full$date)

#Add sub_region to italy_full
italy_full$sub_region_1 <- "NA"
italy_full$sub_region_1[italy_full$City == "bologna" | italy_full$City == "modena" | italy_full$City == "parma"] = "Emilia-Romagna"
italy_full$sub_region_1[italy_full$City == "brescia"| italy_full$City == "milan"] = "Lombardy"
italy_full$sub_region_1[italy_full$City == "florence"] = "Tuscany"
italy_full$sub_region_1[italy_full$City == "rome"] = "Lazio"
italy_full$sub_region_1[italy_full$City == "turin"] = "Piedmont"

#Combine italy_full and Italy_Mobility based on their joint colnames
italy_full_mobility <- left_join(italy_full, Italy_Mobility)
save(italy_full_mobility, file = "italy_full_mobility.RData")
#Note: To load this back in just call load("italy_full_mobility.RData")
