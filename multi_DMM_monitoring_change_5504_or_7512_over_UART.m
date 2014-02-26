%write the 5504 and 7512 and record the results of the DMM
clc

defineDACparameters;
defineASCIIandUART;
defineInstrumentParameters;

%DEFINE bounds of sweep
COARSE_START = 50;
COARSE_END = (4096-50);

%open a csv file for recording the values
fileINcsv = fopen('values.csv','w'); %csv for recording values and 
fileINtab = fopen('values.txt','w'); %tab delimmitted txt for plottings

%configure the DMMs over TCP and create target TCP objects
voltageDMM = openDMMoverTCPgivenIP( '192.168.0.102' ); %Agilent 34461A
currentDMM = openDMMoverTCPgivenIP( '192.168.0.104' ); %Agilent 34401A

%configure the DMM ranges
fprintf( voltageDMM, strcat('CONF:VOLT:DC', VOLTAGE_RANGE));
fprintf( currentDMM, strcat('CONF:CURR:DC', CURRENT_RANGE));

usb2uartMSP430launchpad = serial('COM4', 'BAUD', 9600); 
fopen(usb2uartMSP430launchpad);

oldVoltageValue = ((COARSE_START)/ 4096)*COARSE_VREF + (FINE_DAC_START/ 4096) * FINE_VREF; % makes the first DNL data point approximately correct
oldCurrentValue = 0 ; %the deltaCurrent will not be correct.

%FIXME how to make this a function but without so many arguments?

for coarseCommand= (CH1_5504_OFFSET + COARSE_START):(CH1_5504_OFFSET + COARSE_END )

sendDACvalueOverUART( coarseCommand, DAC5504, usb2uartMSP430launchpad ); 

    for fineCommand = FINE_DAC_START : (FINE_DAC_START + FINE_DAC_STEPS)
    
    sendDACvalueOverUART(fineCommand, DAC7512, usb2uartMSP430launchpad);
    %sendDACvalueOverUART(1001, DAC7512, usb2uartMSP430launchpad);
    pause( FINE_SETTLING_TIME );

    %DO NOT delete this query syntax
    %rawVoltageRead = query(voltageDMM, 'READ?'); %FIXME, this should be a query
    %with parameters, not a query
    fprintf( voltageDMM, strcat('VOLT:DC:NPLC', VOLTAGE_PLC));
    fprintf( voltageDMM, 'READ?');
    rawVoltageRead = fscanf( voltageDMM);
    
    fprintf( currentDMM, strcat('CURR:DC:NPLC', CURRENT_PLC ));
    fprintf( currentDMM, 'READ?');
    rawCurrentRead = fscanf( currentDMM);
    
    writeData2terminalAndFiles ( rawVoltageRead, oldVoltageValue, rawCurrentRead, oldCurrentValue, coarseCommand, fineCommand, FINE_VREF, COARSE_VREF, CH1_5504_OFFSET, fileINcsv, fileINtab );
    
    oldVoltageValue = str2double(rawVoltageRead); %needed for DNL, could likely get from file though, but more complicated
    oldCurrentValue = str2double(rawCurrentRead); %needed for deltaCurrent

    end

end

%close the serial port
fclose(usb2uartMSP430launchpad);

%close the TCP/IP sockets
fclose(voltageDMM);
delete(voltageDMM);
fclose(currentDMM);
delete(currentDMM);

%close the txt and csv files
fclose(fileINcsv);
fclose(fileINtab);

plotVoltageDNL ( COARSE_START, COARSE_END, COARSE_VREF, FINE_DAC_START, FINE_DAC_STEPS, FINE_VREF );
