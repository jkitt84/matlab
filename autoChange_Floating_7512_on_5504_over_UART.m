%write the 5504 or 7512
%remember 0xFFF = 4095
%need to add 2^12 to any of the 5504's to select channel 1
%the pause after the fwrite appear unneeded, unless missing values later on
%the pause calls are longer then they say b/c they wait on the OS
%a better explanation exists in the other autoChange m file
clc
%x=3581+2^12;%need +2^12 to select ch1 on the 5504

s = serial('COM4', 'BAUD', 9600); 
fopen(s)
%for the 5504 need to start at 2^12 -->> x= 2^12:(2^12+100) to go 100
%counts on the 5504
for x= (2^12+1000):(2^12+1003)
    
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
    
    fwrite(s, revBitOrder( 1)) %this is SOH
    fwrite(s, revBitOrder( 18)) %this is DC1 (=17) for 5504 or DC2 (=18) for 7512

    fwrite(s, revBitOrder( dec2ascii( fix(y/ (16^3))) )) %this is the lead 0 in 0x0XYZ (for 7512) or 1 in 0x1EF2 (for 5504)
    y = y - fix(y/ (16^3)) * 16^3;

    fwrite(s, revBitOrder( dec2ascii( fix(y/ (16^2))) )) %this is the most significant byte of the DAC vale 0x1EF2 it is the E
    y = y - fix(y/ (16^2)) * 16^2;

    fwrite(s, revBitOrder( dec2ascii( fix(y/ (16^1))) )) %this is the most significant byte of the DAC vale 0x1EF2 it is the F
    y = y - fix(y/ (16^1)) * 16^1;

    fwrite(s, revBitOrder( dec2ascii( fix(y/ (16^0))) )) %this is the most significant byte of the DAC vale 0x1EF2 it is the F
    %pause(.01) 
    pause(1)
    end

%pause(2)

end

fclose(s)