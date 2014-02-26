function [ reversed ] = revBitOrder( X )
%reverse the order a bits in a single byte so it matchs the SPI bus, in
%other words so that MSB is transmitted first
reversed = sum(uint8(bitset(0,1:8,bitget(uint8(X), 8:-1:1))));


end

