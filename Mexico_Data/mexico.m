mexico_table = readtable("big_mexico.csv");
% make a table of only positives so we can go faster
positives_table = mexico_table(mexico_table.RESULTADO == 1,:); %RESULTADO = 1 means positive, 2 is negative, 3 is waiting on result

%number of cities in each state
num_cities = [11, 5, 9, 11, 38, 10, 124, 67, 17, 39, 46, 81, 84, 125, 125, 113, 35, 20, 51, 570, 217, 18, 11, 58, 18, 72, 17, 43, 60, 212, 106, 58];
i = 1;
result = [];
for state = 1:32
    %make a table every time we look at a new state so we can go faster
    state_table = positives_table(str2double(positives_table.ENTIDAD_RES) == state, :);
    for city = [1:num_cities(state),999] %city = 999 means "patient didnt disclose city
        rows = str2double(state_table.MUNICIPIO_RES) == city;
        result(i) = sum(rows);
        i =i+1;
        %remove annoying missing cities from the table
        if (state == 3 && ( city == 4 || city == 5 || city == 6 || city == 7)) || (state == 7 && city == 95) || (state == 9 && city == 1)
            i = i-1;
        end
    end
end
result = result';





% input_cities = zeros(25, 3);
% state = 1;
% city = 2;
% name = 3;
% names = ["Puebla", "Iztapalapa", "Leon", "Gustavo A Madero", "Mexicali", "Ecatepec de Morelos", "Tlalpan", "Monterrey", "Merida", "Alvaro Obregon", "Veracruz", "Coyoacan", "Nezahualcoyotl", "Xochimilco", "Guadalajara", "Culiacan", "Azcapotzalco", "Cuauhtemoc", "Toluca", "Reynosa", "Tijuana", "Iztacalco", "Juarez", "Matamoros", "Guadalupe"];
% cities = [114, 7, 20, 5, 2, 33, 12, 39, 50, 10, 193, 3, 58, 13, 39, 6, 2, 15, 106, 32, 4, 6, 37, 22, 26];
% states = [21, 9, 11, 9, 2, 15, 9, 19, 31, 9, 30, 9, 15, 9, 14, 25, 9, 9, 15, 28, 2, 9, 8, 28, 19];
% input_cities(:,name) = names';
% input_cities(:, city) = cities';
% input_cities(:, state) = states';
% 
% input_cities = array2table(input_cities, 'VariableNames', {'state', 'city', 'name'});
% input_cities.name = names';
% 
% 
% writetable(input_cities, "mexico_coords.csv")






