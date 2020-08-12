%mobility_table = readtable("Global_Mobility_Report.csv");
country = "Mexico";
country_table = mobility_table(mobility_table.country_region == country, :);

%note these are sorted by state
cities = ["TiJuana", "Mexicali", "Juarez", "Tlalpan", "Alvaro Obregon", "Coyoacan", "Xochimilco", "Azcapotzalco", "Cuauhtemoc", "Iztacalco", "Iztapalapa", "Gustavo A Madero", "Leon", "Guadalajara", "Ecatepec de Morelos", "Nezahualcoyotl", "Toluca", "Monterrey", "Guadalupe", "Culiacan", "Reynosa", "Matamoros", "Veracruz", "Merida"];

%Gather data for each state
state1 = country_table(country_table.sub_region_1 == "Baja California",:);
state2 = country_table(country_table.sub_region_1 == "Chihuahua",:);
state3 = country_table(country_table.sub_region_1 == "Mexico City",:);
state4 = country_table(country_table.sub_region_1 == "Guanajuato",:);
state5 = country_table(country_table.sub_region_1 == "Jalisco",:);
state6 = country_table(country_table.sub_region_1 == "State of Mexico",:);
state7 = country_table(country_table.sub_region_1 == "Nuevo Leon",:);
state8 = country_table(country_table.sub_region_1 == "Sinaloa",:);
state9 = country_table(country_table.sub_region_1 == "Tamaulipas",:);
state10 = country_table(country_table.sub_region_1 == "Veracruz",:);
state11 = country_table(country_table.sub_region_1 == "Yucatan",:);

for i = 1:length(cities)
    %we can do this since cities are ordered by state
    if i <=2
        current_state = state1;
    elseif i <= 3
        current_state = state2;
    elseif i <= 12
        current_state = state3;
    elseif i <= 13
        current_state = state4;
    elseif i <= 14
        current_state = state5;
    elseif i <= 17
        current_state = state6;
    elseif i <= 19
        current_state = state7;
    elseif i <= 20
        current_state = state8;
    elseif i <= 22
        current_state = state9;
    elseif i <= 23
        current_state = state10;
    elseif i <= 24
        current_state = state11;
    end
    
    current_city = readtable(strcat("climate_data/", cities(i), ".csv"));
    
    %Cut off dates of climate data where we dont have mobility data
    %also remove dates of mobility data that we have no climate data (rare)
    %yes i know there is a faster way, but the file is small enough it
    %doesnt matter
    dates = current_state.date;
    city_rows = [];
    state_rows = [];
    j = 1;
    for k = 1:length(dates)
        row = find(current_city.date == dates(k));
        if ~isempty(row) 
            city_rows(j) = row;
            state_rows(j) = k;
            j = j+1;
        end
    end
    current_city = current_city(city_rows', :);
    current_state = current_state(state_rows',:);
    
    %add in mobility
    current_city.home = current_state.residential_percent_change_from_baseline;
    current_city.work = current_state.workplaces_percent_change_from_baseline;
    current_city.transit = current_state.transit_stations_percent_change_from_baseline;
    current_city.parks = current_state.parks_percent_change_from_baseline;
    current_city.grocery = current_state.grocery_and_pharmacy_percent_change_from_baseline;
    current_city.retail = current_state.retail_and_recreation_percent_change_from_baseline;
    
    %write table
    writetable(current_city, strcat("climate_data/", cities(i), ".csv"));

end







