p = input('Enter p in kPa: ');
T = input('Enter T in C: ');
state = findState(p,T)
format long g
disp('Properties in order: p,t,v,u,h,s');
properties = CalculateProperties(p,T,state);
disp(properties);
    