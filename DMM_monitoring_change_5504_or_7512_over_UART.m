%write the 5504 or 7512
%remember 0xFFF = 4095
%need to add 2^12 to any of the 5504's to select channel 1
%the pause after the fwrite appear unneeded, unless missing values later on
%the pause calls are longer then they say b/c they wait on the OS
%a better explanation exists in the other autoChange m file

%DEFINE PARAMETERS
CH1_5504_OFFSET = 2^12; %needed to place a 1 on the 12th byte of the 5504 word
COARSE_VREF = 60; %60V reference
FINE_VREF = 3.361; %this is just the floating supply voltage

%DEFINE BOUNDS
COARSE_START = 0500;
COARSE_END = 0502;
FINE_START = 1000;
FINE_STEPS = 17;

%DEFINE CORRECTIONS
%does nothing now FIRST_INL_CORRECTOR = 0.0025; %this corrects the first plotted point by the INL at that point, not used after first point, FIXME, take this point off graph

clc
%x=3581+2^12;%need +2^12 to select ch1 on the 5504

%open a csv file for recording the values
fileINcsv = fopen('values.csv','w');
%open a txt file tab delimitted for plotting
fileINtab = fopen('values.txt','w');

%configure the DMM over TCP and set obj1 as the TCP object
obj1 = configOpenDMMoverTCP( );

s = serial('COM4', 'BAUD', 9600); 
fopen(s)
%for the 5504 need to start at 2^12 -->> x= 2^12:(2^12+100) to go 100
%counts on the 5504

step = 0;

oldValue = ((COARSE_START)/ 4096)*COARSE_VREF + (FINE_START/ 4096) * FINE_VREF; 

for x= (CH1_5504_OFFSET + COARSE_START):(CH1_5504_OFFSET + COARSE_END )
    
preserveX = x; %need to keep the value of X undisturbed so it can be printed out later
    
fwrite(s, revBitOrder( 1)) %this is SOH
fwrite(s, revBitOrder( 17)) %this is DC1 (=17) for 5504 or DC2 (=18) for 7512

fwrite(s, revBitOrder( dec2ascii( fix(x/ (16^3))) )) %this is the lead 0 in 0x0XYZ (for 7512) or 1 in 0x1EF2 (for 5504)
x = x - fix(x/ (16^3)) * 16^3;

fwrite(s, revBitOrder( dec2ascii( fix(x/ (16^2))) )) %this is the most significant byte of the DAC vale 0x1EF2 it is the E
x = x - fix(x/ (16^2)) * 16^2;

fwrite(s, revBitOrder( dec2ascii( fix(x/ (16^1))) )) %this is the most significant byte of the DAC vale 0x1EF2 it is the F
x = x - fix(x/ (16^1)) * 16^1;

fwrite(s, revBitOrder( dec2ascii( fix(x/ (16^0))) )) %this is the most significant byte of the DAC vale 0x1EF2 it is the F
%pause(.01) 


    for y= 1000:1017
    
    preserveY = y; %need to keep the value of Y undisturbed so it can be printed out later
    
    fwrite(s, revBitOrder( 1)) %this is SOH
    fwrite(s, revBitOrder( 18)) %this is DC1 (=17) for 5504 or DC2 (=18) for 7512

    fwrite(s, revBitOrder( dec2ascii( fix(y/ (16^3))) )) %this is the lead 0 in 0x0XYZ (for 7512) or 1 in 0x1EF2 (for 5504)
    y = y - fix(y/ (16^3)) * 16^3;

    fwrite(s, revBitOrder( dec2ascii( fix(y/ (16^2))) )) %this is the most significant byte of the DAC vale 0x1EF2 it is the E
    y = y - fix(y/ (16^2)) * 16^2;

    fwrite(s, revBitOrder( dec2ascii( fix(y/ (16^1))) )) %this is the most significant byte of the DAC vale 0x1EF2 it is the F
    y = y - fix(y/ (16^1)) * 16^1;

    fwrite(s, revBitOrder( dec2ascii( fix(y/ (16^0))) )) %this is the most significant byte of the DAC vale 0x1EF2 it is the F
     
    pause(.5)
    % Communicating with instrument object, obj1.
    % Appears the Matlab code waits here for the DMM to return a value
    % (will not proceed until measurement is done
    data2 = query(obj1, 'READ?');

    %i dont think think this Pause would do anything
    %pause(2)
    measuredValue = str2double(data2); 
    
    step = measuredValue - oldValue;
    
    DNL = (measuredValue - oldValue)-(FINE_VREF/ 4096);
    
    predictedValue = ((preserveX - CH1_5504_OFFSET)/ 4096)*60 + (preserveY/ 4096) * 3.3; 
    
    INL = predictedValue - measuredValue;
    
    %print to the terminal
    fprintf('C=%d, F=%d, Meas=%.4f, Pred=%.4f, INL=%.4f, step=%.5f, DNL=%.5f\n', (preserveX - CH1_5504_OFFSET), preserveY, measuredValue, predictedValue, INL, step, DNL)
    
    fprintf(fileINcsv, 'C=%d, F=%d, Meas=%.4f, Pred=%.4f, INL=%.4f, step=%.5f, DNL=%.5f\n', (preserveX - CH1_5504_OFFSET), preserveY, measuredValue, predictedValue, INL, step, DNL);
    fprintf(fileINtab, '%.4f\t%.5f\r\n', predictedValue, DNL);
   
    oldValue = measuredValue;
    
    %pause(.5)
    end

%pause(2)

end

%close the serial port
fclose(s)

%close the TCP/IP socket
fclose(obj1);
delete(obj1);

%close the txt file
fclose(fileINcsv);
fclose(fileINtab);

%for fun just do the plot right now, FIXME make this a function later
pause(.5)
load values.txt
x = values(:,1);
y = values(:,2);

startXaxis = ((COARSE_START)/ 4096)*COARSE_VREF + (FINE_START/ 4096) * FINE_VREF + 0.002;
endXaxis = ((COARSE_END)/ 4096)*COARSE_VREF + ((FINE_START + FINE_STEPS) / 4096) * FINE_VREF -.002;


plot(x,y);
hold on;
%plot a line at +LSB and -LSB because inside there guarentees monotinicity
%( although not logically "if and only if")
plot([startXaxis endXaxis],[FINE_VREF/(2^12) FINE_VREF/(2^12)],':');
plot([startXaxis endXaxis],[-FINE_VREF/(2^12) -FINE_VREF/(2^12)],':');

%plot line at 2LSB and -2LSB
plot([startXaxis endXaxis],[2*FINE_VREF/(2^12) 2*FINE_VREF/(2^12)],':');
plot([startXaxis endXaxis],[2*-FINE_VREF/(2^12) 2*-FINE_VREF/(2^12)],':');

%plot line at 3LSB and -3LSB
plot([startXaxis endXaxis],[3*FINE_VREF/(2^12) 3*FINE_VREF/(2^12)],':');
plot([startXaxis endXaxis],[3*-FINE_VREF/(2^12) 3*-FINE_VREF/(2^12)],':');

%plot line at 4LSB and -4LSB
plot([startXaxis endXaxis],[4*FINE_VREF/(2^12) 4*FINE_VREF/(2^12)],':');
plot([startXaxis endXaxis],[4*-FINE_VREF/(2^12) 4*-FINE_VREF/(2^12)],':');

%plot line at 5LSB and -5LSB
plot([startXaxis endXaxis],[5*FINE_VREF/(2^12) 5*FINE_VREF/(2^12)],':');
plot([startXaxis endXaxis],[5*-FINE_VREF/(2^12) 5*-FINE_VREF/(2^12)],':');


%hold off;
axis([startXaxis endXaxis -0.005 0.005]);
xlabel('Voltage');
ylabel({'DNL (Volts)'; 'Dotted lines at (+,-)*n*LSB, for n=1,2,3,4,5'});
title({'Differential Non-Linearity'; '16 Channel Board'; '1 of ADuM1300, low power LDO and DAC7512'; 'Range=100V, PLC= 10'});
set(gca, 'YTickLabel',get(gca,'YTick'))

%this is an attempt to put a y-axis label in LSBs on the right hand Y-axis,
%does not work yet.
%axes('Yaxislocation','right','YLim',[0 2],'Color','none','Xtick',[]);
