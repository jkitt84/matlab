%FIRST_WORKING_TEST_AND_MEASUREMENT_TOOL_LOG Code for communicating with an instrument.
%
%   This is the machine generated representation of an instrument control
%   session. The instrument control session comprises all the steps you are
%   likely to take when communicating with your instrument. These steps are:
%   
%       1. Create an instrument object
%       2. Connect to the instrument
%       3. Configure properties
%       4. Write and read data
%       5. Disconnect from the instrument
% 
%   To run the instrument control session, type the name of the file,
%   first_working_test_and_measurement_tool_log, at the MATLAB command prompt.
% 
%   The file, FIRST_WORKING_TEST_AND_MEASUREMENT_TOOL_LOG.M must be on your MATLAB PATH. For additional information 
%   on setting your MATLAB PATH, type 'help addpath' at the MATLAB command 
%   prompt.
% 
%   Example:
%       first_working_test_and_measurement_tool_log;
% 
%   See also SERIAL, GPIB, TCPIP, UDP, VISA, BLUETOOTH.
% 
 
%   Creation time: 19-Jan-2014 22:14:55

% Find a tcpip object.
obj1 = instrfind('Type', 'tcpip', 'RemoteHost', '192.168.0.102', 'RemotePort', 5025, 'Tag', '');

% Create the tcpip object if it does not exist
% otherwise use the object that was found.
if isempty(obj1)
    obj1 = tcpip('192.168.0.102', 5025);
else
    fclose(obj1);
    obj1 = obj1(1)
end

% Connect to instrument object, obj1.
fopen(obj1);

% Disconnect from instrument object, obj1.
fclose(obj1);

% Configure instrument object, obj1.
set(obj1, 'Name', 'TCPIP-192.168.0.102');
set(obj1, 'RemoteHost', '192.168.0.102');

% Connect to instrument object, obj1.
fopen(obj1);

% Communicating with instrument object, obj1.
data1 = query(obj1, 'READ?');

% Disconnect all objects.
fclose(obj1);

% Clean up all objects.
delete(obj1);

