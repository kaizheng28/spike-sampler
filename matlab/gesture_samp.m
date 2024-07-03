%% spike sampling 
% Receive the UART packets sent from FPGA
close all;
clear;

% Sampling configuration
max_frames = 4000;
n_channels = 16;

f = 12e6;       % clock frequency = 12MHz
T = 1/f;
T_max = T * (2^28-1);

frame = zeros(1, max_frames, 'uint32');
timestamp = zeros(n_channels, max_frames);

% Create a serial port handler and reads continously 
samp_start = 2380;     % number of samples already captaured.
n_data = 20;     % number of data samples to capture. 
t_total = 1.5;    % length of the sampling time.

gesture = 12;    % 1-12 12 different gesture. 
descriptions = ["Swipe-left", "Swipe-right", "Swipe-up", "Swipe-down", ...
    "Push", "pull", "Circle-clockwise", "circle-counter-clockwise", ...
    "Open Hands", "Close Hands", "Worship", "Wrist Rotation"];
for kk = 1:n_data        
    sprintf("Ready... %d %s", gesture, descriptions(gesture))
    sprintf("3") 
    pause(1); 
    sprintf("2") 
    pause(1); 
    sprintf("1") 
    pause(1); 
   
    s=[];
    s = serialport("COM14", 115200);
    sprintf("Go!")
    
    tic;
    ii = 1;
    while (toc < t_total)
        if (s.NumBytesAvailable >= 1)
            if (ii == 1)    % time of the first spike. 
                tictoc = toc;
            end
            data = read(s, 1, "uint32");
            sprintf("%x", data)
            frame(ii) = data;
            ii = ii + 1;
        end
    end    
    n_spk = ii-1;
    
    % for each spike, write down the channel-id and time. 
    cnt = zeros(1, n_channels);
    % id 0-15
    for jj = 1:n_spk
        id = bitsra(frame(jj), 28); % highest 4bit
        cnt(id+1) = cnt(id+1) + 1;
        timestamp(id+1, cnt(id+1)) = bitand(frame(jj), 0x0fffffff);
        %sprintf("id=%d, time=%.4f", id, T * timestamp(id+1, cnt(id+1)))
        if (id > 6)
            sprintf("Error")
            break;
        end
        if (jj == 1) 
           t_first = T * timestamp(id+1, cnt(id+1)); 
           sprintf("t_first = %0.4f", t_first)
        end
    end
    timestamp = T * timestamp;
    
    % Remove the offset and plot
    timestamp = timestamp - t_first;
    for ii = 1:n_channels
        for jj = 1:cnt(ii)
            if (timestamp(ii, jj) < 0)
                timestamp(ii, jj) = timestamp(ii, jj) + T_max;
            end
        end
    end
    timestamp = timestamp + tictoc;
    
    % Create a file. 
    filename = sprintf("gesture_data/gesture_%d.txt", kk + samp_start);
    outFile = fopen(filename, 'w');
    fprintf(outFile, "%d\n", gesture);   % first tline for gesture index.
    
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
    ylim([0, 8]);
    xlabel("Time(s)");
    grid on;
    
    pause(3);
    close all;
end

    % Close Serial port. 
    s=[];
    close all;

