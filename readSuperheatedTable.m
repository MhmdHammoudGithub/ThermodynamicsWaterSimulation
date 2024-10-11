function table = readSuperheatedTable(p)
p = p / 1000;
baseUrl = 'https://raw.githubusercontent.com/MhmdHammoudGithub/ThermodynamicsWaterSimulation/refs/heads/master/ThermoTables/superheated/';

% Define the pressure values and corresponding file names
pressures = [0.01, 0.05, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.8, 1, 1.2, 1.4, 1.6, 1.8, 2, 2.5, 3, 3.5, 4, 4.5, 5, 6, 7, 8, 9, 10, 12.5, 15, 17.5, 20, 25, 30, 35, 40, 50, 60];
fileNames = {
    'P=0.01 MPa.txt', 'P=0.05 MPa.txt', 'P=0.10 MPa.txt', 'P=0.20 MPa.txt', 'P=0.30 MPa.txt', ...
    'P=0.40 MPa.txt', 'P=0.50 MPa.txt', 'P=0.60 MPa.txt', 'P=0.80 MPa.txt', 'P=1.00 MPa.txt', ...
    'P=1.20 MPa.txt', 'P=1.40 MPa.txt', 'P=1.60 MPa.txt', 'P=1.80 MPa.txt', 'P=2.00 MPa.txt', ...
    'P=2.50 MPa.txt', 'P=3.00 MPa.txt', 'P=3.50 MPa.txt', 'P=4.00 MPa.txt', 'P=4.50 MPa.txt', ...
    'P=5.00 MPa.txt', 'P=6.00 MPa.txt', 'P=7.00 MPa.txt', 'P=8.00 MPa.txt', 'P=9.00 MPa.txt', ...
    'P=10.00 MPa.txt', 'P=12.50 MPa.txt', 'P=15.00 MPa.txt', 'P=17.50 MPa.txt', 'P=20.00 MPa.txt', ...
    'P=25.00 MPa.txt', 'P=30.00 MPa.txt', 'P=35.00 MPa.txt', 'P=40.00 MPa.txt', 'P=50.00 MPa.txt', ...
    'P=60.00 MPa.txt'};

% Find the index corresponding to the given pressure
index = find(pressures == p, 1);

if ~isempty(index)
    % Construct the full URL for the table file
    url = [baseUrl, fileNames{index}];
    
    % Read the table from the URL
    fileContent = webread(url);
    
    % Convert the file content into a matrix
    table = str2num(fileContent); %#ok<ST2NM>
else
    error('Pressure value not found.');
end
end
