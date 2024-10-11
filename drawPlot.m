function drawPlot(properties,state)
if(~strcmp(state,'error'))
    if(strcmp(state,'compressed liquid'))
        %data = readmatrix('C:\handase\semestre 4\Matlab\matlab project\thermo tables\compressed\Temp saturation table.txt');
        
        url = 'https://raw.githubusercontent.com/MhmdHammoudGithub/ThermodynamicsWaterSimulation/refs/heads/master/ThermoTables/compressed/Temp%20saturation%20table.txt';
        fileContent = webread(url);
        cleanContent = regexprep(fileContent, ',', '');
        data = str2num(cleanContent);
        
        subplot(2,2,1),plot(data(:,3),data(:,1),'.'),hold on,plot(properties(3),properties(2),'o'),xlabel('v (in m3/kg)'),ylabel('T (in C)'),title('T-v diagram'),grid on;
        subplot(2,2,2),plot(data(:,5),data(:,1),'.'),hold on,plot(properties(4),properties(2),'o'),xlabel('u (in kJ/kg)'),ylabel('T (in C)'),title('T-u diagram'),grid on;
        subplot(2,2,3),plot(data(:,8),data(:,1),'.'),hold on,plot(properties(5),properties(2),'o'),xlabel('h (in kJ/kg)'),ylabel('T (in C)'),title('T-h diagram'),grid on;
        subplot(2,2,4),plot(data(:,11),data(:,1),'.'),hold on,plot(properties(6),properties(2),'o'),xlabel('s (in kJ/kg.k)'),ylabel('T (in C)'),title('T-s diagram'),grid on;
    else
        if(strcmp(state,'superheated vapor'))
            pressureVector = [0.01 0.05 0.1 0.2 0.3 0.4 0.5 0.6 0.8 1 1.2 1.4 1.6 1.8 2 2.5 3 3.5 4 4.5 5 6 7 8 9 10 12.5 15 17.5 20 25 30 35 40 50 60];
            pressureVector = pressureVector*1000;
            p2 = 0;
            i=1;
            while (p2<properties(1) && i<=numel(pressureVector))
                 p1 = p2;
                 p2 = pressureVector(i);
                 i=i+1;
            end
            if (p2==properties(1))
                data = readSuperheatedTable(properties(1));
                subplot(2,2,1),plot(data(:,2),data(:,1),'.'),hold on,plot(properties(3),properties(2),'o'),xlabel('v (in m3/kg)'),ylabel('T (in C)'),title('T-v diagram'),grid on;
                subplot(2,2,2),plot(data(:,3),data(:,1),'.'),hold on,plot(properties(4),properties(2),'o'),xlabel('u (in kJ/kg)'),ylabel('T (in C)'),title('T-u diagram'),grid on;
                subplot(2,2,3),plot(data(:,4),data(:,1),'.'),hold on,plot(properties(5),properties(2),'o'),xlabel('h (in kJ/kg)'),ylabel('T (in C)'),title('T-h diagram'),grid on;
            	subplot(2,2,4),plot(data(:,5),data(:,1),'.'),hold on,plot(properties(6),properties(2),'o'),xlabel('s (in kJ/kg.k)'),ylabel('T (in C)'),title('T-s diagram'),grid on;
            else
                data1 = readSuperheatedTable(p1);          
                data2 = readSuperheatedTable(p2);        
                lenght = min(numel(data1(:,1)),numel(data2(:,1)));
                data = zeros(lenght, 5);
                for i=1:lenght
                    v1 = interp1(data1(:,1),data1(:,2),data1(i,1));
                    u1 = interp1(data1(:,1),data1(:,3),data1(i,1));
                    h1 = interp1(data1(:,1),data1(:,4),data1(i,1));
                    s1 = interp1(data1(:,1),data1(:,5),data1(i,1));
                    v2 = interp1(data2(:,1),data2(:,2),data2(i,1));
                    u2 = interp1(data2(:,1),data2(:,3),data2(i,1));
                    h2 = interp1(data2(:,1),data2(:,4),data2(i,1));
                    s2 = interp1(data2(:,1),data2(:,5),data2(i,1));
                    data(i,1)= data2(i,1);
                    data(i,2) = v1 + (v2-v1)*(properties(1)-p1)/(p2-p1);
                    data(i,3) = u1 + (u2-u1)*(properties(1)-p1)/(p2-p1);
                    data(i,4) = h1 + (h2-h1)*(properties(1)-p1)/(p2-p1);
                    data(i,5)= s1 + (s2-s1)*(properties(1)-p1)/(p2-p1);
                end
            subplot(2,2,1),plot(data(:,2),data(:,1),'.'),hold on,plot(properties(3),properties(2),'o'),xlabel('v (in m3/kg)'),ylabel('T (in C)'),title('T-v diagram'),grid on;
            subplot(2,2,2),plot(data(:,3),data(:,1),'.'),hold on,plot(properties(4),properties(2),'o'),xlabel('u (in kJ/kg)'),ylabel('T (in C)'),title('T-u diagram'),grid on;
            subplot(2,2,3),plot(data(:,4),data(:,1),'.'),hold on,plot(properties(5),properties(2),'o'),xlabel('h (in kJ/kg)'),ylabel('T (in C)'),title('T-h diagram'),grid on;
            subplot(2,2,4),plot(data(:,5),data(:,1),'.'),hold on,plot(properties(6),properties(2),'o'),xlabel('s (in kJ/kg.k)'),ylabel('T (in C)'),title('T-s diagram'),grid on;
            end
        end
    end
end
end
        