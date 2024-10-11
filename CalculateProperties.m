function requiredValues = CalculateProperties(p,t,state)
requiredValues =0;
if(strcmp(state,'error'))
        requiredValues = 'error';
else
    if(strcmp(state,'compressed liquid'))
        %data = readmatrix('C:\handase\semestre 4\Matlab\matlab project\thermo tables\compressed\Temp saturation table');
   
        url = 'https://raw.githubusercontent.com/MhmdHammoudGithub/ThermodynamicsWaterSimulation/refs/heads/master/ThermoTables/compressed/Temp%20saturation%20table.txt';

        fileContent = webread(url);

        cleanContent = regexprep(fileContent, ',', '');

        data = str2num(cleanContent);



        
        
        vf=interp1(data(:,1),data(:,3),t);
        uf=interp1(data(:,1),data(:,5),t);
        hf=interp1(data(:,1),data(:,8),t);
        sf=interp1(data(:,1),data(:,11),t);
    
        v=vf; %approximation
        u=uf; %approximation
        h=hf; %approximation
        s=sf; %approximation
    
    else
        if (strcmp(state,'saturation zone'))
            %data = readmatrix('C:\handase\semestre 4\Matlab\matlab project\thermo tables\saturation\pressure saturation table');
            
            url = 'https://raw.githubusercontent.com/MhmdHammoudGithub/ThermodynamicsWaterSimulation/master/ThermoTables/saturation/pressure%20saturation%20table.txt';
            fileContent = webread(url);
            data = str2num(fileContent);

            test = 0;
            while(test ~=1)
                x = input('Enter the title x: ');
                if(x<=1 && x>=0)
                    test=1;
                end
            end
            vf=interp1(data(:,1),data(:,3),p);
            vg=interp1(data(:,1),data(:,4),p);
            uf=interp1(data(:,1),data(:,5),p);
            ug=interp1(data(:,1),data(:,7),p);
            hf=interp1(data(:,1),data(:,8),p);
            hg=interp1(data(:,1),data(:,10),p);
            sf=interp1(data(:,1),data(:,11),p);
            sg=interp1(data(:,1),data(:,13),p);
    
            v =(1-x)*vf + x*vg;
            u = (1-x)*uf + x*ug;
            h = (1-x)*hf + x*hg;
            s = (1-x)*sf + x*sg;

        else  
            pressureVector = [0.01 0.05 0.1 0.2 0.3 0.4 0.5 0.6 0.8 1 1.2 1.4 1.6 1.8 2 2.5 3 3.5 4 4.5 5 6 7 8 9 10 12.5 15 17.5 20 25 30 35 40 50 60];
            pressureVector = pressureVector*1000;
            p2 = 0;
            i=1;
            while (p2<p && i<=numel(pressureVector))
                 p1 = p2;
                 p2 = pressureVector(i);
                 i=i+1;
            end
            if (i>numel(pressureVector) && p2<p)
                requiredValues = 'error';
            else
                 if (p2==p)
                    data = readSuperheatedTable(p);
                    v = interp1(data(:,1),data(:,2),t);
                    u = interp1(data(:,1),data(:,3),t);
                    h = interp1(data(:,1),data(:,4),t);
                    s = interp1(data(:,1),data(:,5),t);
                 else
                    data1 = readSuperheatedTable(p1);          
                    data2 = readSuperheatedTable(p2);        
                    v1 = interp1(data1(:,1),data1(:,2),t);
                    u1 = interp1(data1(:,1),data1(:,3),t);
                    h1 = interp1(data1(:,1),data1(:,4),t);
                    s1 = interp1(data1(:,1),data1(:,5),t);
                    v2 = interp1(data2(:,1),data2(:,2),t);
                    u2 = interp1(data2(:,1),data2(:,3),t);
                    h2 = interp1(data2(:,1),data2(:,4),t);
                    s2 = interp1(data2(:,1),data2(:,5),t);
    
                    v = v1 + (v2-v1)*(p-p1)/(p2-p1);
                    u = u1 + (u2-u1)*(p-p1)/(p2-p1);
                    h = h1 + (h2-h1)*(p-p1)/(p2-p1);
                    s = s1 + (s2-s1)*(p-p1)/(p2-p1);
                 end
            end
        end
    end
end
if(~strcmp(requiredValues,'error'))
    requiredValues = [p t v u h s];
drawPlot(requiredValues,state);
end
end