function plotVoltageDNL ( COARSE_START, COARSE_END, COARSE_VREF, FINE_START, FINE_STEPS, FINE_VREF )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

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



end

