#! /usr/bin/env python3

'''

 Filename: pre_process.py
 Author: Kai Zheng
 Date: 10/13/2022
 Function: Preprocess the spike timestamps. Divide the samples to small samples.

'''
 
import numpy as np
import matplotlib.pyplot as plt

n_samp_long = 6

in_length = 600000
out_length = 2000       # * ms each sample
step = 1000             # sliding window step *ms

edge = int(out_length / step - 1)
n_samp_short = int(in_length / step - edge) # number of short samples, for each input long sample
print((edge, n_samp_short))

dt_in = 1   # ms
dt_out = 4  # ms
dec = int(dt_out / dt_in)   # set decimation factor, do max pooling
out_length_dec = int(out_length / dt_out)

n_chan = 16

filename = "loc_600s_1ms_6.txt"
# input format: 16 x 600,000
#1 x coordinate
#2 y coordinate
#3 v_x velocity
#4 v_y velocity
#5-16 spike data - 12 channels

input_data = np.zeros((n_chan, in_length))

# setup output file
out_file = open("loc_3594_2s_4ms.txt", "w")
if (not out_file):
    print("Open file error!")
    exit(1)

# process the raw data
with open(filename, "r") as in_file:
    for i in range(n_samp_long):

        # read in 16 lines first.
        for j in range(n_chan):
            line = in_file.readline()            
            items = np.array(line.split(' '))
            #print(items[-5:])
            input_data[j, :] = items[:-1].astype(np.float64)
        line = in_file.readline()               # '\n'

        # split the long samples into short samples, and write to a file
        for j in range(n_samp_short):
            # spike data
            for k in range(4, 16):
                start = j * step
                out_line = input_data[k, start : start + out_length]
                for p in range(out_length_dec):
                    # max pooling for spikes
                    s = max(out_line[p * dec : (p + 1) * dec])
                    out_file.write("%d " % s)
            # location and velocity data
            for k in range(4):
                start = j * step
                out_line = input_data[k, start : start + out_length]
                for p in range(out_length_dec):
                    # average pooling for location
                    l = sum(out_line[p * dec : (p + 1) * dec]) / dec
                    out_file.write("%0.2f " % l)
            out_file.write("\n")

out_file.close()
