function writeData2terminalAndFiles ( rawVoltageRead, oldVoltageValue, rawCurrentRead, oldCurrentValue, coarseCommand, fineCommand, FINE_VREF, COARSE_VREF, CH1_5504_OFFSET, fileINcsv, fileINtab )
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
    measuredVoltageValue = str2double(rawVoltageRead);
    measuredCurrentValue = str2double(rawCurrentRead);
    step = measuredVoltageValue - oldVoltageValue;
    DNL = (measuredVoltageValue - oldVoltageValue)-(FINE_VREF/ 4096);
    deltaCurrent = measuredCurrentValue - oldCurrentValue ;
    predictedValue = ((coarseCommand - CH1_5504_OFFSET)/ 4096)*COARSE_VREF + ( fineCommand / 4096) * FINE_VREF; 
    INL = predictedValue - measuredVoltageValue;
    
    %print to the terminal
    fprintf('C=%d, F=%d, Meas=%.4f, Pred=%.4f, INL=%.4f, step=%.6f, DNL=%.6f, Current=%.7f, deltaCurrent=%.8f\n', (coarseCommand - CH1_5504_OFFSET), fineCommand, measuredVoltageValue, predictedValue, INL, step, DNL, measuredCurrentValue, deltaCurrent)
    
    fprintf(fileINcsv, 'C=%d, F=%d, Meas=%.4f, Pred=%.4f, INL=%.4f, step=%.6f, DNL=%.6f\n', (coarseCommand - CH1_5504_OFFSET), fineCommand, measuredVoltageValue, predictedValue, INL, step, DNL);
    %fprintf(fileINtab, '%.4f\t%.6f\r\n', predictedValue, DNL);
    fprintf( fileINtab, '%d\t%d\t%.4f\t%.9f\r\n', (coarseCommand - CH1_5504_OFFSET), fineCommand, measuredVoltageValue, measuredCurrentValue );
end

