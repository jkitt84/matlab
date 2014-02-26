for i= 1:20
    s = serial('COM4', 'BAUD', 9600); 
    fopen(s)
    fprintf(s, ['G' char(1)])
    %fprintf(s, ['r' char(1)])
    %fprintf(s, ['w' ch2 '0' value2 char(13)])
 
    fclose(s)
    
    fopen(s)
    fprintf(s, ['R' char(1)])
    %fprintf(s, ['r' char(1)])
    %fprintf(s, ['w' ch2 '0' value2 char(13)])
    fclose(s)
    
    fopen(s)
    fprintf(s, ['g' char(1)])
    %fprintf(s, ['r' char(1)])
    %fprintf(s, ['w' ch2 '0' value2 char(13)])
 
    fclose(s)
    
    fopen(s)
    fprintf(s, ['r' char(1)])
    %fprintf(s, ['r' char(1)])
    %fprintf(s, ['w' ch2 '0' value2 char(13)])
    fclose(s)
    
    
    
    
end