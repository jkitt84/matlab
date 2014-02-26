%learning to fprintf big numbers using for loops
for x= (2^12+1000):(2^12+1001)
    


    for y= 1000:1017
    

    fprintf('Coarse=%d, Fine=%d, Measured Value =\n', (x-2^12), y)
    %fprintf('Iteration %d of %d\n',i,N);
    
    pause(.5)
    end

%pause(2)

end