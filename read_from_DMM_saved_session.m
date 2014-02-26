%READ_FROM_DMM_SAVED_SESSION Code for communicating with an instrument.

% Find a tcpip object.
obj1 = instrfind('Type', 'tcpip', 'RemoteHost', '192.168.0.102', 'RemotePort', 5025, 'Tag', '');

% Create the tcpip object if it does not exist
% otherwise use the object that was found.
if isempty(obj1)
    obj1 = tcpip('192.168.0.102', 5025);
else
    fclose(obj1);
    obj1 = obj1(1);
end

% Connect to instrument object, obj1.
fopen(obj1);

% Configure instrument object, obj1.
set(obj1, 'Name', 'TCPIP-192.168.0.102');
set(obj1, 'RemoteHost', '192.168.0.102');

% Communicating with instrument object, obj1.
data2 = query(obj1, 'READ?')

%using str2double for now, would like to know how to control number of
%decimal places
%x = str2num(data2)

y = str2double(data2)

% Disconnect all objects.
fclose(obj1);

% Clean up all objects.
delete(obj1);

