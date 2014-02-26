%try to plot from a txt file
%the monotonic limit is DNL of -1 LSB

%DEFINE PARAMETERS
CH1_5504_OFFSET = 2^12; %needed to place a 1 on the 12th byte of the 5504 word
COARSE_VREF = 60; %60V reference
FINE_VREF = 3.361; %this is just the floating supply voltage

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

commandedVoltage = COARSE_VREF*(command5504/2^12) + FINE_VREF*(command7512/2^12);

for i = 2 : numberOfSamples %note DNL for the first measurement is 0
    DNL(i) = (measuredVoltage(i) - measuredVoltage(i-1))-FINE_VREF/2^12;
end

tDNL = transpose( DNL);

for i = 2 : numberOfSamples %note deltaCurrent for the first measurement is 0
    deltaCurrent(i) = (measuredCurrent(i) - measuredCurrent(i-1));
end


tdeltaCurrent = transpose( deltaCurrent);

startXaxis = COARSE_VREF*(command5504(1)/2^12)+FINE_VREF*(command7512(1)/2^12);
endXaxis = COARSE_VREF*(command5504(numberOfSamples)/2^12)+FINE_VREF*(command7512(numberOfSamples)/2^12);

monotonicLimit(1:numberOfSamples) = -.0005;
tmonotonicLimit = transpose( monotonicLimit);

figure(1);
clf;

subplot(3,1,1)
hold on
plot( commandedVoltage, tDNL);
plot([startXaxis endXaxis],[-FINE_VREF/(2^12) -FINE_VREF/(2^12)],'r--','LineWidth',3);
xlabel('Voltage');
ylabel('DNL (Volts)');
title({'Single Channel Test Board', 'Differential Non-Linearity'}, 'FontWeight', 'bold');
axis([startXaxis endXaxis LOWER_DNL_LIMIT UPPER_DNL_LIMIT]);
hold off

subplot(3,1,2)
plot( commandedVoltage, tdeltaCurrent)
xlabel('Voltage');
ylabel('\Delta(CURRENT) Amps');
title('\Delta(Floating Side Current)', 'FontWeight', 'bold');
axis([startXaxis endXaxis LOWER_DELTA_CURRENT_LIMIT UPPER_DELTA_CURRENT_LIMIT]);

subplot(3,1,3)
plot( commandedVoltage, measuredCurrent)
xlabel('Voltage');
ylabel('Current (A)');
title('Total Floating Side Current', 'FontWeight', 'bold');
axis([startXaxis endXaxis LOWER_CURRENT_LIMIT UPPER_CURRENT_LIMIT]);

%subplot(4,1,4)
figure(2);
basevalue = -.002;
clf;
hold on;
scatter( deltaCurrent, DNL,'x')
plot([LOWER_DELTA_CURRENT_LIMIT UPPER_DELTA_CURRENT_LIMIT],[-FINE_VREF/(2^12) -FINE_VREF/(2^12)],'r--','LineWidth',3);
xlabel('\Delta(CURRENT) Amps');
ylabel('DNL (V)');
title({'Single Channel Test Board','Correlation','\Delta(CURRENT) to DNL'}, 'FontWeight', 'bold');
axis([LOWER_DELTA_CURRENT_LIMIT UPPER_DELTA_CURRENT_LIMIT LOWER_DNL_LIMIT UPPER_DNL_LIMIT]);
hold off;
