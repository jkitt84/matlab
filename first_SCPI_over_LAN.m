%trying to read a value from Agilent 34416A


%get the IP address by hitting "HELP" on the Multimeter
t=tcpip('192.168.0.102', 30000, 'NetworkRole', 'server');
fopen(t);

pause(5);

fclose(t);