try %[output:group:868531df]
    df = readtable('diabetes.csv');
    disp('Dataset diabetes.csv cargado exitosamente.'); %[output:334207ce]
catch
    error('No se pudo cargar diabetes.csv. Asegúrate de que el archivo esté en el directorio correcto.');
end %[output:group:868531df]
%%
columnsToClean = {'Glucose', 'BloodPressure', 'SkinThickness', 'Insulin', 'BMI'};

% Asegurarse de que las columnas a limpiar existan en la tabla
validColumnsToClean = {};
for i = 1:length(columnsToClean)
    if ismember(columnsToClean{i}, df.Properties.VariableNames)
        validColumnsToClean{end+1} = columnsToClean{i};
    else
        warning('La columna "%s" no se encontró en el dataset y será ignorada.', columnsToClean{i});
    end
end
columnsToClean = validColumnsToClean;

if isempty(columnsToClean) %[output:group:037af8aa]
    warning('No se encontraron columnas válidas para limpiar. Revisa los nombres de las columnas en el script.');
else
    disp('Reemplazando ceros con NaN en las siguientes columnas:'); %[output:7ef0550c]
    disp(columnsToClean'); %[output:43d5026f]

    %% 3. Reemplazar 0 con NaN en las columnas especificadas
    for i = 1:length(columnsToClean)
        colName = columnsToClean{i};
        % Convertir a double si la columna no lo es (necesario para NaN)
        if ~isa(df.(colName), 'double')
            df.(colName) = double(df.(colName));
        end
        % Reemplazar los ceros con NaN
        df.(colName)(df.(colName) == 0) = NaN;
    end
    disp('Ceros reemplazados con NaN.'); %[output:787b7f5c]

    %% 4. Imputar los NaN con la media de sus respectivas columnas
    % Esta es una estrategia común para manejar valores faltantes.
    % La media se calcula *después* de que los 0 se hayan convertido en NaN.
    
    for i = 1:length(columnsToClean)
        colName = columnsToClean{i};
        % Calcular la media excluyendo los NaN actuales
        colMean = nanmean(df.(colName));
        % Rellenar los NaN con la media calculada
        df.(colName)(isnan(df.(colName))) = colMean;
    end
    disp('Valores NaN imputados con la media de sus columnas.'); %[output:4986d218]
end %[output:group:037af8aa]


%% 5. Preparar datos para Classification Learner
% MATLAB Classification Learner puede trabajar directamente con una tabla.
% Asegúrate de que la columna 'Outcome' sea el predictor objetivo.

% Identifica la columna de la variable objetivo (Outcome)
% Asumiendo que tu columna objetivo se llama 'Outcome'
if ismember('Outcome', df.Properties.VariableNames) %[output:group:586f9652]
    responseVarName = 'Outcome';
    disp(['Variable objetivo identificada: ', responseVarName]); %[output:084c80e0]
else
    error('La columna "Outcome" no se encontró. Por favor, ajusta el nombre de la columna objetivo en el script.');
end %[output:group:586f9652]

% Visualiza las primeras filas de la tabla preprocesada
disp('Primeras 5 filas de los datos preprocesados:'); %[output:4396dbd6]
disp(head(df, 5)); %[output:46b8a8b4]

%% 6. Cargar los datos en Classification Learner App
disp('Datos preprocesados listos en el workspace como "df".'); %[output:8c7b04b9]

%[appendix]{"version":"1.0"}
%---
%[metadata:view]
%   data: {"layout":"onright","rightPanelPercent":42.9}
%---
%[output:334207ce]
%   data: {"dataType":"text","outputData":{"text":"Dataset diabetes.csv cargado exitosamente.\n","truncated":false}}
%---
%[output:7ef0550c]
%   data: {"dataType":"text","outputData":{"text":"Reemplazando ceros con NaN en las siguientes columnas:\n","truncated":false}}
%---
%[output:43d5026f]
%   data: {"dataType":"text","outputData":{"text":"    {'Glucose'      }\n    {'BloodPressure'}\n    {'SkinThickness'}\n    {'Insulin'      }\n    {'BMI'          }\n\n","truncated":false}}
%---
%[output:787b7f5c]
%   data: {"dataType":"text","outputData":{"text":"Ceros reemplazados con NaN.\n","truncated":false}}
%---
%[output:4986d218]
%   data: {"dataType":"text","outputData":{"text":"Valores NaN imputados con la media de sus columnas.\n","truncated":false}}
%---
%[output:084c80e0]
%   data: {"dataType":"text","outputData":{"text":"Variable objetivo identificada: Outcome\n","truncated":false}}
%---
%[output:4396dbd6]
%   data: {"dataType":"text","outputData":{"text":"Primeras 5 filas de los datos preprocesados:\n","truncated":false}}
%---
%[output:46b8a8b4]
%   data: {"dataType":"text","outputData":{"text":"    <strong>Pregnancies<\/strong>    <strong>Glucose<\/strong>    <strong>BloodPressure<\/strong>    <strong>SkinThickness<\/strong>    <strong>Insulin<\/strong>    <strong>BMI<\/strong>     <strong>DiabetesPedigreeFunction<\/strong>    <strong>Age<\/strong>    <strong>Outcome<\/strong>\n    <strong>___________<\/strong>    <strong>_______<\/strong>    <strong>_____________<\/strong>    <strong>_____________<\/strong>    <strong>_______<\/strong>    <strong>____<\/strong>    <strong>________________________<\/strong>    <strong>___<\/strong>    <strong>_______<\/strong>\n\n         6           148           72                 35        155.55     33.6             0.627              50        1   \n         1            85           66                 29        155.55     26.6             0.351              31        0   \n         8           183           64             29.153        155.55     23.3             0.672              32        1   \n         1            89           66                 23            94     28.1             0.167              21        0   \n         0           137           40                 35           168     43.1             2.288              33        1   \n\n","truncated":false}}
%---
%[output:8c7b04b9]
%   data: {"dataType":"text","outputData":{"text":"Datos preprocesados listos en el workspace como \"df\".\n","truncated":false}}
%---
