clc
x=2581;

fprintf( 'As a decimal number\nx=%d\n',x)

charMSB = fix(x/ (16^3));

x = x - charMSB * 16^3;

fprintf( 'charMSB=%d\n', charMSB);
byteMSB = dec2ascii( charMSB);
fprintf( 'So the MSB ascii byte is ascii =%d\n', byteMSB);




char3 = fix(x/ (16^2));

x = x - char3 * 16^2;

fprintf( 'char3=%d\n', char3);
byte3 = dec2ascii( char3);
fprintf( 'So the Third ascii byte is ascii =%d\n', byte3);



char2 = fix(x/ (16^1));

x = x - char2 * 16^1;

fprintf( 'char2=%d\n', char2);
byte2 = dec2ascii( char2);
fprintf( 'So the second ascii byte is ascii =%d\n', byte2);




charLSB = fix(x/ (16^0));

fprintf( 'charLSB=%d\n', charLSB);
byteLSB = dec2ascii( charLSB);
fprintf( 'So the second LSB byte is ascii =%d\n', byteLSB);