mexico_table = readtable("big_mexico.csv");
city_coords = readtable("mexico_coords.csv");

results = 1:date2num(datetime(2020, 8, 2));
results = results';
titles = "Day";


for i = 1:height(city_coords)
    state = city_coords(i, 1);
    city = city_coords(i, 2);
    name = city_coords(i, 3);
    name = name.name;
    name = char(name);

    %subtable is the table of all data for city, state
    subtable = mexico_table(str2double(mexico_table.ENTIDAD_RES) == state.state, :);
    subtable = subtable(str2double(subtable.MUNICIPIO_RES) == city.city, :);
    
    subresults = zeros(date2num(datetime(2020, 8, 2)), 3);
    % col 1 = symptoms, col 2 = positive test, col 3 = total test
    
    for k = 1:height(subtable)
        if subtable.RESULTADO(k) == 1
            subresults(date2num(subtable.FECHA_SINTOMAS(k)), 1) ...
                = subresults(date2num(subtable.FECHA_SINTOMAS(k)), 1) + 1;
            subresults(date2num(subtable.FECHA_INGRESO(k)), 2) ...
                = subresults(date2num(subtable.FECHA_INGRESO(k)), 2) + 1;
        end
        if subtable.RESULTADO(k) ~= 3
            subresults(date2num(subtable.FECHA_INGRESO(k)), 3) = ...
              subresults(date2num(subtable.FECHA_INGRESO(k)), 3) + 1;  
        end
    end
    
    results = [results, subresults];
    
    x = [name + "_Symptomatic", name + "_PositiveTests", name + "_TotalTest"];
    titles = [titles, x];    
end

final_array = array2table(results,...
    'VariableNames', titles);

writetable(final_array, "Mexico_timeseries.csv");


function f = date2num(d)
start_day = datetime(2020, 1, 1);
start_day = datenum(start_day);
f = datenum(d) - start_day + 1;
end