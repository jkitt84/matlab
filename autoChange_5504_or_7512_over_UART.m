%write the 5504 or 7512
%remember 0xFFF = 4095
%need to add 2^12 to any of the 5504's to select channel 1
%the pause after the fwrite appear unneeded, unless missing values later on
%the pause calls are longer then they say b/c they wait on the OS
clc
%x=3581+2^12;%need +2^12 to select ch1 on the 5504

s = serial('COM4', 'BAUD', 9600); 
fopen(s)
%for the 5504 need to start at 2^12 -->> x= 2^12:(2^12+100) to go 100
%counts on the 5504
for x= 1000:1050
    
fwrite(s, revBitOrder( 1)) %this is SOH
%pause(.001) 
    
fwrite(s, revBitOrder( 18)) %this is DC1 (=17) for 5504 or DC2 (=18) for 7512
%pause(.001) 


charMSB = fix(x/ (16^3));
byteMSB = dec2ascii( charMSB);
fwrite(s, revBitOrder( byteMSB )) %this is the lead 0 in 0x0XYZ (for 7512) or 1 in 0x1EF2 (for 5504)
%pause(.01) 
x = x - charMSB * 16^3;


char3 = fix(x/ (16^2));
byte3 = dec2ascii( char3);
fwrite(s, revBitOrder( byte3 )) %this is the most significant byte of the DAC vale 0x1EF2 it is the E
%pause(.01) 
x = x - char3 * 16^2;


char2 = fix(x/ (16^1));
byte2 = dec2ascii( char2);
fwrite(s, revBitOrder( byte2 )) %this is the most significant byte of the DAC vale 0x1EF2 it is the F
%pause(.01) 
x = x - char2 * 16^1;



charLSB = fix(x/ (16^0));
byteLSB = dec2ascii( charLSB);
fwrite(s, revBitOrder( byteLSB )) %this is the most significant byte of the DAC vale 0x1EF2 it is the F
%pause(.01) 
pause(.5)
end

fclose(s)