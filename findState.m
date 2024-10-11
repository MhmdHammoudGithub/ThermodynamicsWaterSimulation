function state = findState(p,t)
%data = readmatrix('C:\handase\semestre 4\Matlab\matlab project\thermo tables\saturation\pressure saturation table.txt');

url = 'https://raw.githubusercontent.com/MhmdHammoudGithub/ThermodynamicsWaterSimulation/master/ThermoTables/saturation/pressure%20saturation%20table.txt';
fileContent = webread(url);
data = str2num(fileContent)
        

T_sat = interp1(data(:,1),data(:,2),p);
if (isnan(T_sat))
    state = 'error';
elseif(abs(t-T_sat)<0.5)
    state = 'saturation zone';
else
    if (t>T_sat)
        state = 'superheated vapor';
    else 
        state = 'compressed liquid';
    end
end
end

