clc

for i= 1:20
    s = serial('COM4', 'BAUD', 9600); 
    fopen(s)
    %fprintf(s, '%s', 'G')
   % sum(uint8(bitset(0,1:8,bitget(uint8(X), 8:-1:1)))) %x is the thing that will get bit reversed
   %FIXME do this by indexing through an array
    
    fwrite(s, revBitOrder(1))  %start byte 'STX' 
    fwrite(s, revBitOrder(112)) %MostSignificantWord of the 5504 = 0x70 
    fwrite(s, revBitOrder(04))  %LeastSignificantWord of the 5504 = 0x04
    fwrite(s, revBitOrder(29)) % 'Group Seperator'
    fwrite(s, revBitOrder(8))   %MostSignificantWord of the 7512 = 0x08
    fwrite(s, revBitOrder(15))  %LeastSignificantWord of the 7512 = 0x0F
    fwrite(s, revBitOrder(4))   %End of Transmist = 0x04
    
    pause(0.01)
    %now increase the 5004 channel 1 to about 50%
    fwrite(s, revBitOrder(1)) %start byte 'STX'
    fwrite(s, revBitOrder(24)) %MostSignificantWord of the 5504 = 0x70
    fwrite(s, revBitOrder(15))  %LeastSignificantWord of the 5504 = 0x04
    fwrite(s, revBitOrder(29)) % 'Group Seperator'
    fwrite(s, revBitOrder(8))   %MostSignificantWord of the 7512 = 0x08
    fwrite(s, revBitOrder(15))  %LeastSignificantWord of the 7512 = 0x0F
    fwrite(s, revBitOrder(4))   %End of Transmist = 0x04    

    %this is just for debug
    pause(.1) %jan 14, this appears to be smallest time to correctly get everything
    fwrite(s, revBitOrder(82))  %turn Red LED ON
    fwrite(s, revBitOrder(71)) %turn Green LED On
    

    %fwrite(s, revBitOrder(114))  %turn Red LED Off
    %fwrite(s, revBitOrder(103)) %turn Green LED Off

    
    %fprintf(s, A )
    %fprintf(s, ['r' char(1)])
    %fprintf(s, ['w' ch2 '0' value2 char(13)])
    %out = fscanf(s)
    %pause(.5)
    
    
    
    %{
    fprintf(s, '%s', 'R')
    %fprintf(s, ['r' char(1)])
    %fprintf(s, ['w' ch2 '0' value2 char(13)])
    out = fscanf(s)
    pause(.5)
    
    fprintf(s, '%s', 'g')
    pause(.5)
    out = fscanf(s)
    
    fprintf(s, '%s', 'r')
    pause(.5)
    out = fscanf(s)
    
    pause(5)
    %}
    fclose(s)
    
    
    
   
    
    
    
end