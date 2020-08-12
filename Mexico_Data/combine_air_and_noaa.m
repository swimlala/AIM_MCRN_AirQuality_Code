clear

cities = ["Iztapalapa", "Leon", "Gustavo A Madero", "Mexicali", "Ecatepec de Morelos", "Tlalpan", "Monterrey", "Merida", "Alvaro Obregon", "Veracruz", "Coyoacan", "Nezahualcoyotl", "Xochimilco", "Guadalajara", "Culiacan", "Azcapotzalco", "Cuauhtemoc", "Toluca", "Reynosa", "Tijuana", "Iztacalco", "Juarez", "Matamoros", "Guadalupe"];

for city = 1:length(cities)
    noaa_table = readtable(strcat("noaa_data/",cities(city),".csv"));
    aq_table = readtable(strcat("air_data/", cities(city), ".csv"));
    
    
    dates = noaa_table.date;
    rows = [];
    j = 1;
    for i = 1:length(dates)
        row = find(aq_table.date == dates(i));
        if ~isempty(row) > 0
            rows(j) = row;
            j = j+1;
        end
    end
    keep = aq_table(rows, :);
    result = outerjoin(noaa_table, keep, 'MergeKeys', true);
    writetable(result, strcat("climate_data/", cities(city), ".csv"));
end