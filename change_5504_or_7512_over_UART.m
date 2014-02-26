clc
s = serial('COM4', 'BAUD', 9600); 
fopen(s)

for i= 1:5

    %write the 7512 to value = 0x0D41
    
    
    fwrite(s, revBitOrder( 1)) %this is SOH
    pause(.01) 
    
    fwrite(s, revBitOrder( 17)) %this is DC1 (=17) for 5504 or DC2 (=18) for 7512
    pause(.01) 
    
    fwrite(s, revBitOrder('1')) %this is the lead 0 in 0x0XYZ
    pause(.01) 
    
    fwrite(s, revBitOrder('B'))
    pause(.01) 
    
    fwrite(s, revBitOrder('F'))   
    pause(.01) 
    
    fwrite(s, revBitOrder('F'))   
    pause(.01) 
    
end

fclose(s)