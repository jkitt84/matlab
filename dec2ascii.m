function [ decAsASCIIbyte ] = dec2ascii( decimalIn )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
if decimalIn >= 0 && decimalIn <= 9
    decAsASCIIbyte = decimalIn + '0';
    
elseif decimalIn >= 10 && decimalIn <= 15
        decAsASCIIbyte = decimalIn + 'A' -10; %need the -10 because A starts at 10


%should have "ELSE" that throws an exception
end    
    


end

