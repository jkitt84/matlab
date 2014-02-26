%READ_FROM_DMM_SAVED_SESSION Code for communicating with an instrument.

%configure the DMM over TCP and set obj1 as the TCP object
obj1 = configOpenDMMoverTCP( );

% Communicating with instrument object, obj1.
data2 = query(obj1, 'READ?');

%using str2double for now, would like to know how to control number of
%decimal places
%x = str2num(data2)

y = str2double(data2)

% Disconnect all objects.
fclose(obj1);
% Clean up all objects.
delete(obj1);

