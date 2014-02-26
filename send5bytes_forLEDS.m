clc

for i= 1:10
    s = serial('COM4', 'BAUD', 9600); 
    fopen(s)

    pause(.1)
    
    fwrite(s, revBitOrder( 1))
    pause(.1) 
    
    fwrite(s, revBitOrder(51)) 
    pause(.1) 
    
    fwrite(s, revBitOrder(65))
    pause(.1) 
    
    fwrite(s, revBitOrder(52))   
    pause(.1) 
    
    fwrite(s, revBitOrder(53))   
    pause(.1) 
    
    
    
    pause(1)
    
    fwrite(s, revBitOrder( 1))
    pause(.1) 
    
    fwrite(s, revBitOrder(70)) 
    pause(.1) 
    
    fwrite(s, revBitOrder(70))
    pause(.1) 
    
    fwrite(s, revBitOrder(48))   
    pause(.1) 
    
    fwrite(s, revBitOrder(48))   
    pause(.1) 
    
    pause(1)
    
    fwrite(s, revBitOrder( 1))
    pause(.1) 
    
    fwrite(s, revBitOrder(48)) 
    pause(.1) 
    
    fwrite(s, revBitOrder(48))
    pause(.1) 
    
    fwrite(s, revBitOrder(48))   
    pause(.1) 
    
    fwrite(s, revBitOrder(49))   
    pause(.1) 
    
    pause(1)
    
    fwrite(s, revBitOrder( 1))
    pause(.1) 
    
    fwrite(s, revBitOrder(48)) 
    pause(.1) 
    
    fwrite(s, revBitOrder(49))
    pause(.1) 
    
    fwrite(s, revBitOrder(48))   
    pause(.1) 
    
    fwrite(s, revBitOrder(49))   
    pause(.1) 
    
    
    fclose(s)
    
    
    
   
    
    
    
end