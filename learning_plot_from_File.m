%try to plot from a txt file

%DEFINE PARAMETERS
CH1_5504_OFFSET = 2^12; %needed to place a 1 on the 12th byte of the 5504 word
COARSE_VREF = 60; %60V reference
FINE_VREF = 3.361; %this is just the floating supply voltage

%DEFINE BOUNDS
COARSE_START = 32;
COARSE_END = 4064;
FINE_START = 1000;
FINE_STEPS = 17;

%values.txt is tab delimitted predicted TAB step \r\n

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

axis([startXaxis endXaxis -0.005 0.005]);
xlabel('Voltage');
ylabel({'DNL (Volts)'; 'Dotted lines at (+,-)*n*LSB, for n=1,2,3,4,5'});
title({'Differential Non-Linearity'; 'Single Channel Test Board'; '3 of ADuM1100s, low power LDO and DAC7512'; 'Instrument Settings: Range=100V, PLC= 10'});
set(gca, 'YTickLabel',get(gca,'YTick'))