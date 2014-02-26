%works with MSP430 program Echo_UART_using...
clc

for i= 1:10
    s = serial('COM4', 'BAUD', 9600); 
    fopen(s)
    fprintf(s, '%s', 'G')
    %FWRITE ALLOWS INTEGERS WITHOUT THE LF (Line Feed)
    %fwrite(s, 29)
    %fprintf(s, A )
    %fprintf(s, ['r' char(1)])
    %fprintf(s, ['w' ch2 '0' value2 char(13)])
    out = fscanf(s)
    pause(.5)
    
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
    
    pause(1)
    fclose(s)
    
    
    
   
    
    
    
end