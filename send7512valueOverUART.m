function send7512valueOverUART ( value2send, serialConn )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

    fwrite(serialConn, revBitOrder( 1)) %this is SOH
    fwrite(serialConn, revBitOrder( 18)) %this is DC1 (=17) for 5504 or DC2 (=18) for 7512

    fwrite(serialConn, revBitOrder( dec2ascii( fix(value2send/ (16^3))) )) %this is the lead 0 in 0x0XYZ (for 7512) or 1 in 0x1EF2 (for 5504)
    value2send = value2send - fix(value2send/ (16^3)) * 16^3;

    fwrite(serialConn, revBitOrder( dec2ascii( fix(value2send/ (16^2))) )) %this is the most significant byte of the DAC value 0x1EF2 it is the E
    value2send = value2send - fix(value2send/ (16^2)) * 16^2;

    fwrite(serialConn, revBitOrder( dec2ascii( fix(value2send/ (16^1))) )) %this is the middle byte of the DAC value 0x1EF2 it is the F
    value2send = value2send - fix(value2send/ (16^1)) * 16^1;

    fwrite(serialConn, revBitOrder( dec2ascii( fix(value2send/ (16^0))) )) %this is the most Least Significant byte of the DAC value 0x1EF2 it is the 2
     

end

%Packet