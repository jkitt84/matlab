% Define's parameters of the DACs

CH1_5504_OFFSET = 2^12; %needed to place a 1 on the 12th byte of the 5504 word
COARSE_VREF = 60; %60V reference
FINE_VREF = 3.361; %this is just the floating supply voltage

%not sure these are really needed
COARSE_SETTLING_TIME = 0.5; %this is not needed, because a FINE_DAC change is done everytime before the read, even when Coarse moves (fine has to reset)
FINE_SETTLING_TIME = .2;

%FINE_DAC_START is technically arbitrary, somewhere in the middle is OK
FINE_DAC_START = 2000;

%FINE_DAC_STEPS needs to be (COARSE DAC LSB)/ (FINE DAC LSB)
FINE_DAC_STEPS = 17;