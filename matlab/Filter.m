%% Attempt to Map out the Transfer Function for Mode 1B of the LTC1067-50

% I Want to see if theres a way top access local functions 
% created in this file from other files, These could be useful later?


% For a second order band pass, assume -40dB/dec after the -3dB points
% -3dB points are located at f0 +- 1/2(BW)
% break into 4 sections: low freq roll off, low -3db to peak, peak to high
% -3db, and high freq roll off

RATIO = 50;
fclk = 318000;

% W=logspace(2,5,1000);
% W2=logspace(2, 4, 10000);
%logspace spacing from 10^a -> 10^b with c points

filter1 = FilterParams(fclk, RATIO, 267000, 4990, 255000, 4990, 7320);
filter2 = FilterParams(fclk, RATIO, 15000, 4990, 255000, 4990, 8660);
%inputs fclk, ratio, R1, R2, R3, R5, R6
%outputs 1 = f0, Q = 2, BW = 3, BpG = 4, LpG = 5

H1 = tf([filter1(4)*filter1(3)*(2*pi)^2 0],[1 filter1(3)*2*pi (filter1(1)*2*pi)^2]);
H2 = tf([filter2(5)*(filter2(1)*2*pi)^2],[1 filter2(3)*2*pi (filter2(1)*2*pi)^2]);
H = H1*H2;

figure(1)
 bp = bodeplot(H1, H2, H);
 bp.FrequencyUnit = "Hz";
 grid on
figure(2)
 bp = bodeplot(H);
 bp.FrequencyUnit = "Hz";
 grid on

%Sweeping the CLK frequency across the frequencies of interest
% ie 10^2 --> 10^6

for fclkstep = logspace(2,6,20)
 filter1 = FilterParams(fclkstep, RATIO, 267000, 4990, 255000, 4990, 7320);
 filter2 = FilterParams(fclkstep, RATIO, 15000, 4990, 255000, 4990, 8660);
 %inputs fclk, ratio, R1, R2, R3, R5, R6
 %outputs 1 = f0, Q = 2, BW = 3, BpG = 4, LpG = 5

 H1 = tf([filter1(4)*filter1(3)*(2*pi)^2 0],[1 filter1(3)*2*pi (filter1(1)*2*pi)^2]);
 H2 = tf([filter2(5)*(filter2(1)*2*pi)^2],[1 filter2(3)*2*pi (filter2(1)*2*pi)^2]);
 H = H1*H2;
 figure(3)
  hold on
  bp = bodeplot(H);
  bp.FrequencyUnit = "Hz";
  grid on
end

%Sweeping R3

for fclkstep = logspace(2,6,20)
 filter1 = FilterParams(fclkstep, RATIO, 267000, 4990, 255000, 4990, 7320);
 filter2 = FilterParams(fclkstep, RATIO, 15000, 4990, 255000, 4990, 8660);
 %inputs fclk, ratio, R1, R2, R3, R5, R6
 %outputs 1 = f0, Q = 2, BW = 3, BpG = 4, LpG = 5

 H1 = tf([filter1(4)*filter1(3)*(2*pi)^2 0],[1 filter1(3)*2*pi (filter1(1)*2*pi)^2]);
 H2 = tf([filter2(5)*(filter2(1)*2*pi)^2],[1 filter2(3)*2*pi (filter2(1)*2*pi)^2]);
 H = H1*H2;
 figure(3)
  hold on
  bp = bodeplot(H);
  bp.FrequencyUnit = "Hz";
  grid on
end


function out = QFactor(R2,R3,R5,R6)
    % Q factor calculation for Mode 1b on the LTC1067-50
    % Inputs are correllated to the LTC1067-50 Datasheet
    out = (R3/R2)*sqrt(R6/(R6+R5));
end

function out = BandPassGain(R1,R3)
    % Bandpass Transfer Gain for Mode 1b on the LTC1067-50
    % Inputs are correllated to the LTC1067-50 Datasheet
    out = -1*(R3/R1);   
end

function out = LowPassGain(R1,R2, R5, R6)
    % Lowpass Transfer Gain for Mode 1b on the LTC1067-50
    % Inputs are correllated to the LTC1067-50 Datasheet
    out = -1*(R2/R1)*((R6+R5)/R6);   
end

function out = CenterFreq(fclk, RATIO, R5, R6)
    % Center Frequency Calculation for Mode 1b on the LTC1067-50
    % Inputs are correllated to the LTC1067-50 Datasheet
    out = (fclk/RATIO)*sqrt(R6/(R6+R5));
end

function out = BandWidth(f0,Q)
    % Bandwidth calculation for Mode 1b on the LTC1067-50
    % Inputs are correllated to the LTC1067-50 Datasheet
    out = f0/Q;   
end

function out = FilterParams(fclk,RATIO, R1, R2, R3, R5, R6)
    % Filter Parameters calculation for Mode 1b on the LTC1067-50
    % Inputs are correllated to the LTC1067-50 Datasheet
    
    f0 = CenterFreq(fclk, RATIO, R5, R6);
    Q = QFactor(R2,R3,R5,R6);
    BW = BandWidth(f0,Q);
    BpG = BandPassGain(R1,R3);
    LpG = LowPassGain(R1,R2, R5, R6);

    out = [f0, Q, BW, BpG, LpG];   
end