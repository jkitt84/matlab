    clc

    s = serial('COM4', 'BAUD', 9600); 
    fopen(s)
    fprintf(s, ['r'])
    %fprintf(s, ['r' char(1)])
    %fprintf(s, ['w' ch2 '0' value2 char(13)])
    out = fscanf(s)
    pause(.1)
    out = fscanf(s)
    out = fscanf(s)
    %{
    pause(.1)
    
    fprintf(s, ['R'])
    %fprintf(s, ['r' char(1)])
    %fprintf(s, ['w' ch2 '0' value2 char(13)])
    out = fscanf(s)
    pause(.1)
    
    fprintf(s, ['g'])
    pause(0.1)
    out = fscanf(s)
    
    fprintf(s, ['r'])
    pause(0.1)
    out = fscanf(s)
    %}
    
    fclose(s)