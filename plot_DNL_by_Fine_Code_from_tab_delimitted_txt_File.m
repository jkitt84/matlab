%try to plot from a txt file
%the monotonic limit is DNL of -1 LSB

%DEFINE PARAMETERS
CH1_5504_OFFSET = 2^12; %needed to place a 1 on the 12th byte of the 5504 word
COARSE_VREF = 60; %60V reference
FINE_VREF = 3.361; %this is just the floating supply voltage
FINE_VALUES = 18; %includes both the ends

%DEFINE PLOT Y-AXIS BOUND
LOWER_DNL_LIMIT = -0.002;
UPPER_DNL_LIMIT = 0.002;
LOWER_CURRENT_LIMIT = .000114;
UPPER_CURRENT_LIMIT = .000124;
LOWER_DELTA_CURRENT_LIMIT = -.000002;
UPPER_DELTA_CURRENT_LIMIT = .000002;



%values.txt is tab delimitted predicted TAB step \r\n

load full_sweep_single_channel_board_10_PLC.txt
command5504 = full_sweep_single_channel_board_10_PLC(:,1);
command7512 = full_sweep_single_channel_board_10_PLC(:,2);
measuredVoltage = full_sweep_single_channel_board_10_PLC(:,3);
measuredCurrent = full_sweep_single_channel_board_10_PLC(:,4);

numberOfSamples = numel( measuredVoltage)

numberOf5504steps = numberOfSamples / 18

for i = 2 : numberOfSamples %note DNL for the first measurement is 0
    DNL(i) = (measuredVoltage(i) - measuredVoltage(i-1))-FINE_VREF/2^12;
end
tDNL = transpose( DNL);

%DNL matrix will store all the DNL values, with column headings like 7512
%commands
jeffsJitterAmount = 0.00009;
%DNL matrix is 3997 Row X 18

dnlMatrix = zeros( numberOf5504steps, FINE_VALUES);

dnlByFineCommand = zeros( numberOfSamples, 2);

for i = 1 : numberOfSamples
    dnlByFineCommand( i, 1) = mod( i - 1, 18);
    dnlByFineCommand( i, 2) = tDNL(i) + (rand(size(tDNL(i)))-0.5)*(2*jeffsJitterAmount);
end
hold on;
scatter( dnlByFineCommand(:,1), dnlByFineCommand(:,2),'.', 'jitter','on', 'jitterAmount', 0.2);
plot([-1 18],[-FINE_VREF/(2^12) -FINE_VREF/(2^12)],'r--','LineWidth',3);
%plot([startXaxis endXaxis],[-FINE_VREF/(2^12) -FINE_VREF/(2^12)],'r--','LineWidth',3);
xlabel({'(Fine DAC Command - 2000)','note- jittered to display relative frequency'});
ylabel('DNL (Volts)');
title({'Fine DAC Command v.s. Differential Non-Linearity', 'Single Channel Test Board', 'Coarse DAC full sweep (50-4046)', 'Fine DAC stepping 2000...2017 -> 2000'}, 'FontWeight', 'bold');
axis([-1 18 LOWER_DNL_LIMIT UPPER_DNL_LIMIT]);
set(gca,'XTick',[0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17])
set(gca,'XGrid','on')

hold off;