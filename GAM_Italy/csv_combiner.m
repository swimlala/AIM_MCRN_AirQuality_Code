

%The first line of this file takes a long time to run so I would recommend
%not clearing your variables and commenting it out after you run it once
climate_table=readtable('aq3.csv','ReadVariableNames',1); %read in data table with the climate data

infection_filename = 'saopaulo_infection.csv'; %the data table with infection data for your city
output_filename = 'saopaulo_full.csv'; %whay u want ur output file to be called
%DONT U DARE MAKE IT THE SAME AS infection_filename
%Did u read the above line?
%This is important i dont want u to lose ur data if there was a mistake 
%hey
%I'm serious
%ok fine but if u accidentally overwrite ur data and have to retranscribe
%this is on u

infection_table = readtable(infection_filename, 'ReadVariableNames',1);%read in your infection data

dates = infection_table.Date; %INFECTION TABLE MUST HAVE A COLUMN CALLED "Date" AND IT MUST BE IN A STANDARD DATE FORMAT
%A common error i have seen is when the date is messed up in the infection
%table. if its not working then you should check this variable first.


city = "São Paulo"; %city you want to extract climate data from

for i = 1:length(dates)
    %Exctract each climate variable for the city youre looking at
    pm_row = (climate_table.Date == dates(i) & climate_table.City == city & climate_table.Specie == "pm25");
    temp_row = (climate_table.Date == dates(i) & climate_table.City == city & climate_table.Specie == "temperature");
    hum_row = (climate_table.Date == dates(i) & climate_table.City == city & climate_table.Specie == "humidity");
    pm10_row = (climate_table.Date == dates(i) & climate_table.City == city & climate_table.Specie == "pm10");
    co_row = (climate_table.Date == dates(i) & climate_table.City == city & climate_table.Specie == "co");
    no_row = (climate_table.Date == dates(i) & climate_table.City == city & climate_table.Specie == "no2");
    o3_row = (climate_table.Date == dates(i) & climate_table.City == city & climate_table.Specie == "o3");
    inf_row = (infection_table.Date == dates(i));
    
    infect = infection_table(inf_row, {'Daily'});
    inf_arr(i) = infect.Daily;
    
    %store the data to make a new column. If data isnt there we put in -1
   if (sum(pm_row)) == 1     
        pm = climate_table(pm_row, {'median'});
        pm_arr(i) = pm.median;
   else 
        pm_arr(i) = -1;
        inf_arr(i) = -1;
   end
   if (sum(temp_row)) == 1     
        temp = climate_table(temp_row, {'median'});
        temp_arr(i) = temp.median;
   else 
        temp_arr(i) = -1;
        inf_arr(i) = -1;
   end
   if (sum(hum_row)) == 1     
        hum = climate_table(hum_row, {'median'});
        hum_arr(i) = hum.median;
   else 
        hum_arr(i) = -1;
        inf_arr(i) = -1;
   end
   if (sum(pm10_row)) == 1     
        pm10 = climate_table(pm10_row, {'median'});
        pm10_arr(i) = pm10.median;
   else 
        pm10_arr(i) = -1;
        inf_arr(i) = -1;
   end
   if (sum(co_row)) == 1     
        co = climate_table(co_row, {'median'});
        co_arr(i) = co.median;
   else 
        co_arr(i) = -1;
        inf_arr(i) = -1;
   end
   if (sum(no_row)) == 1     
        no = climate_table(no_row, {'median'});
        no_arr(i) = no.median;
   else 
        no_arr(i) = -1;
        inf_arr(i) = -1;
   end
   if (sum(o3_row)) == 1     
        o3 = climate_table(o3_row, {'median'});
        o3_arr(i) = o3.median;
   else 
        o3_arr(i) = -1;
        inf_arr(i) = -1;
   end
   
        
end

%   Uncomment this block if you want to get rid of days where you have
%   incomplete data
    %rows = inf_arr > -1;
    % j =1;
    % for i = 1:length(dates)
    %     if pm_arr(j) == -1
    %         pm_arr(j) = [];
    %         temp_arr(j) = [];
    %         hum_arr(j) = [];
    %         inf_arr(j) = [];
    %         pm10_arr(j) = [];
    %         co_arr(j) = [];
    %         no_arr(j) = [];
    %         o3_arr(j) = [];
    %     else
    %         j = j+1;
    %     end
    % end       
    % m1 = m1(rows,:);

%add in your new columns    
infection_table.Humidity = hum_arr';
infection_table.Temperature = temp_arr';
infection_table.pm25 = pm_arr';
infection_table.pm10 = pm10_arr';
infection_table.co = co_arr';
infection_table.no2 = no_arr';
infection_table.o3 = o3_arr';


writetable(infection_table, output_filename);

