function [ obj1 ] = configOpenDMMoverTCP( )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

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
set(obj1, 'RemoteHost', '192.168.0.102')


end

