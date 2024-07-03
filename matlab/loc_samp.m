%% spike sampling 
% Receive the UART packets sent from FPGA
close all;
clear;

%% Generate a 5sec audio for sample capturing
%tones = [220, 246.94, 261.63, 293.66, 329.63, 349.23, 392.00];
tones = [440, 466.16, 493.88, 523.25, 554.37, 587.33, ...
    622.25, 659.25, 698.46, 739.99, 783.99, 830.61];
notes = tones([1, 3, 5, 6, 8]);
Fs = 44100;
t = linspace(0, 1, Fs);
audio = [];
for ii = 1:3
    f = notes(ii);
    wave = sin(2*pi*f*t);
    audio = [audio wave];
end

%sound(audio, Fs);

%% Sampling configuration
max_frames = 100000;
n_channels = 16;

f = 12e6;       % clock frequency = 12MHz
T = 1/f;
T_max = T * (2^28-1);

frame = zeros(1, max_frames, 'uint32');
timestamp = zeros(n_channels, max_frames);

% Create a serial port handler and reads continously 
t_total = 600;    % length of the sampling time.
file_id = 6;

s = serialport("COM14", 115200);


sprintf("5") 
pause(1); 
sprintf("4") 
pause(1); 

sound(audio, Fs);
pause(0.6); 

sprintf("3") 
pause(1); 
sprintf("2") 
pause(1); 
sprintf("1") 
pause(1); 

sprintf("Go!") 
flush(s);

tic;
ii = 1;
flush(s);
while (toc < t_total)
    if (s.NumBytesAvailable >= 1)
        if (ii == 1)    % time of the first spike. 
            tictoc = toc;
        end
        data = read(s, 1, "uint32");
        %sprintf("%x", data)
        frame(ii) = data;
        ii = ii + 1;
    end
end    
n_spk = ii-1;

% for each spike, write down the channel-id and time. 
cnt = zeros(1, n_channels);
n_wrap = 0;
ts = 0.0;
ts_prev = -1.0;
% id 0-15
for jj = 1:n_spk
    id = bitsra(frame(jj), 28); % channel id, highest 4bit
    cnt(id+1) = cnt(id+1) + 1;
    stamp = double(bitand(frame(jj), 0x0fffffff));
    ts = stamp * T + n_wrap * T_max;

    % check if there is wrapping
    if (ts_prev > ts) 
        n_wrap = n_wrap + 1;
        disp(n_wrap);
        ts = ts + T_max;
    end
    ts_prev = ts;
    timestamp(id+1, cnt(id+1)) = ts;

    % check if id is valid
    if (id >= 12)
        sprintf("id=%d, time=%.4f", id, T * timestamp(id+1, cnt(id+1)))
        sprintf("Error")
       % break;
    end
    if (jj == 1) 
       t_first = ts; 
       sprintf("t_first = %0.4f", t_first)
    end
end

% Remove the offset
timestamp = timestamp - t_first;
timestamp = timestamp + tictoc;

% Create a file. 
filename = sprintf("loc_data/loc_%d.txt", file_id);
outFile = fopen(filename, 'w');
%      % first line for location ground truth
%     fprintf(outFile, "\n");
% For each spike, record channel+timestamp
for ii = 1:n_channels
    if (cnt(ii) ~= 0)
        for jj = 1:cnt(ii)
            fprintf(outFile, "%d %.4f\n", ii, timestamp(ii, jj));
        end 
    end
end
fclose(outFile);

% Configure Color.
color = ['r', 'g', 'b', 'k']; 
color = repmat(color, 1, 4);

% plot figure. 
figure; hold on;
for ii = 1:n_channels
    if (cnt(ii) ~= 0)
        t = timestamp(ii, 1:cnt(ii));
        y1 = ii * ones(cnt(ii), 1);
        y0 = (ii-1) * ones(cnt(ii), 1);
        plot([t; t], [y0.'; y1.'], color(ii));
    end
end
xlim([0, t_total]);
ylim([0, 16]);
xlabel("Time(s)");
grid on;
    

   % Close Serial port. 
   s=[];
   % close all;

