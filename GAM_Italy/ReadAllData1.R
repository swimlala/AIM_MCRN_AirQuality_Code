## read in all combined data at once
library(dplyr)
path <- "/Users/Laura/Documents/ResearchCode/Air Quality COVID/25cities/combined/"
files <- list.files(path=path, pattern="*.csv")
for(file in files){
  perpos <- which(strsplit(file, "")[[1]]==".")
  assign(
    gsub(" ","",substr(file, 1, perpos-1)), 
    read.csv(paste(path,file,sep="")))
}

Italy_Cities <- c()
for(i in 1:length(files)){
  perpos <- which(strsplit(files[i], "")[[1]]==".")
  Italy_Cities[i] <- gsub(" ","",substr(files[i], 1, perpos-1))
  
}

for(city in Italy_Cities){
  city_get <- get(city)
  city_name <- strsplit(city, "_")[[1]][1]
  city_name <- rep(city_name, length(city_get[,1]))
  assign(paste(city,"_all", sep = ""), cbind(city_get, city_name))
}

#Lodi and Parma have date in different format, change to same format as other dataframes
Lodi_total_all$date <- as.Date(Lodi_total_all$date, format = "%m/%d/%y")
Parma_total_all$date <- as.Date(Parma_total_all$date, format = "%m/%d/%y")
Lodi_total_all$date <- as.character(Lodi_total_all$date)
Parma_total_all$date <- as.character(Parma_total_all$date)


italy_25 <- bind_rows(Alessandria_total_all, Bergamo_total_all,     Bologna_total_all,    
                       Bolzano_total_all,     Brescia_total_all,     Como_total_all,       
                      Cremona_total_all,     Cuneo_total_all,       Firenze_total_all,    
                       Lecco_total_all,       Lodi_total_all,        Mantova_total_all,    
                       Milano_total_all,      Modena_total_all,      Monza_total_all,      
                       Napoli_total_all,      Parma_total_all,       Pavia_total_all,      
                       Piacenza_total_all,    Reggio_total_all,      Rimini_total_all,     
                       Roma_total_all,        Torino_total_all,      Varese_total_all,     
                       Verona_total_all  )
#format date as date
italy_25$date <- as.Date(italy_25$date, format = "%Y-%m-%d")
 #add number of day
italy_25$day_num = as.numeric(strftime(italy_25$date, format = "%j"))
 #add week number
 italy_25$week_num <- as.numeric(strftime(italy_25$date, format = "%V"))
 #add month number
 italy_25$month_num <- as.numeric(strftime(italy_25$date, format = "%m"))
 #add weekday

 italy_25$weekday <- weekdays(italy_25$date)
 italy_25$weekday <- as.numeric(factor(italy_25$weekday, levels = c("Monday", "Tuesday", "Wednesday",
                                                                        "Thursday", "Friday", "Saturday", "Sunday"),
                                         ordered = TRUE))

 #Create list of city names to loop through for GAM
 city_names <- rep(NA, length(Italy_Cities))
 for(i in 1:length(Italy_Cities)){
  city_names[i] <- strsplit(Italy_Cities[i], "_")[[1]][1]
  }
city_names
