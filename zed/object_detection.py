#!/usr/bin/env python3

########################################################################
#
# Copyright (c) 2022, STEREOLABS.
#
# All rights reserved.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
# "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
# LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
# A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
# OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
# SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
# LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
# DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
# THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
# OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#
########################################################################

import pyzed.sl as sl
import cv2
import numpy as np
import sys
import re
import matplotlib.pyplot as plt
from mpl_toolkits import mplot3d

def main():

    if (len(sys.argv) < 3):
        print("Usage: ./object_detection.py FILENAME.svo start_frame")
        exit(1)
    filename = sys.argv[1]
    start_frame = int(sys.argv[2])
    frame_rate = 15
    t_sample = 600
    end_frame = start_frame + frame_rate * t_sample

    # Create a Camera object
    zed = sl.Camera()

    # Create a InitParameters object and set configuration parameters
    init_params = sl.InitParameters()
    init_params.camera_resolution = sl.RESOLUTION.HD720  # Use HD720 video mode
    init_params.depth_mode = sl.DEPTH_MODE.PERFORMANCE
    init_params.coordinate_units = sl.UNIT.METER
    init_params.sdk_verbose = True
    init_params.set_from_svo_file(filename)

    # Open the camera
    err = zed.open(init_params)
    if err != sl.ERROR_CODE.SUCCESS:
        exit(1)

    obj_param = sl.ObjectDetectionParameters()
    obj_param.enable_tracking=True
    obj_param.image_sync=True
    obj_param.enable_mask_output=True

    camera_infos = zed.get_camera_information()
    if obj_param.enable_tracking :
        positional_tracking_param = sl.PositionalTrackingParameters()
        positional_tracking_param.set_as_static = True
        positional_tracking_param.set_floor_as_origin = True
        zed.enable_positional_tracking(positional_tracking_param)

    print("Object Detection: Loading Module...")

    err = zed.enable_object_detection(obj_param)
    if err != sl.ERROR_CODE.SUCCESS :
        print (repr(err))
        zed.close()
        exit(1)

    objects = sl.Objects()
    obj_runtime_param = sl.ObjectDetectionRuntimeParameters()
    obj_runtime_param.detection_confidence_threshold = 66

    x = []
    y = []
    z = []

    v_x = []
    v_y = []
    v_z = []

    while zed.grab() == sl.ERROR_CODE.SUCCESS:
        err = zed.retrieve_objects(objects, obj_runtime_param)
        if objects.is_new :
            obj_array = objects.object_list
            #print(str(len(obj_array))+" Object(s) detected\n")
            if len(obj_array) > 0 :
                first_object = obj_array[0]
                #print("First object attributes:")
                #print(" Label '"+repr(first_object.label)+"' (conf. "+str(int(first_object.confidence))+"/100)")
                #if obj_param.enable_tracking :
                #    print(" Tracking ID: "+str(int(first_object.id))+" tracking state: "+repr(first_object.tracking_state)+" / "+repr(first_object.action_state))
                position = first_object.position
                velocity = first_object.velocity
                #dimensions = first_object.dimensions
                #print(" 3D position: [{0},{1},{2}]\n Velocity: [{3},{4},{5}]\n 3D dimentions: [{6},{7},{8}]".format(position[0],position[1],position[2],velocity[0],velocity[1],velocity[2],dimensions[0],dimensions[1],dimensions[2]))

                x.append(position[0])
                y.append(position[1])
                z.append(position[2])

                v_x.append(velocity[0])
                v_y.append(velocity[1])
                v_z.append(velocity[2])

                #if first_object.mask.is_init():
                #    print(" 2D mask available")

                #print(" Bounding Box 2D ")
                #bounding_box_2d = first_object.bounding_box_2d
                #for it in bounding_box_2d :
                #    print("    "+str(it),end='')
                #print("\n Bounding Box 3D ")
                #bounding_box = first_object.bounding_box
                #for it in bounding_box :
                #    print("    "+str(it),end='')

                #input('\nPress enter to continue: ')
            else:
                print(filename + " error!")
                exit(2)
                #print("Error!")

    # Close the camera
    zed.close()

    plt.figure()
    plt.plot(x[:start_frame], z[:start_frame], 'black')
    plt.plot(x[start_frame:end_frame], z[start_frame:end_frame], 'blue')
    plt.plot(x[end_frame:], z[end_frame:], 'green')
    plt.title('2D Location tracking')

    print((v_x[start_frame], v_y[start_frame], v_z[start_frame]))
    print((v_x[end_frame], v_y[end_frame], v_z[end_frame]))


    fig = plt.figure()
    ax = plt.axes(projection='3d')
    ax.plot3D(x[:start_frame], y[:start_frame], z[:start_frame])
    ax.plot3D(x[start_frame:end_frame], y[start_frame:end_frame], z[start_frame:end_frame])
    ax.plot3D(x[end_frame:], y[end_frame:], z[end_frame:])
    ax.set_title('3D Location tracking')
    plt.show()

    ################################ File Output #####################################
    strs = re.split('_|\.', filename)
    #print(strs)
    file_index = strs[2]
    out_name = "../zed_data/zed_"+file_index+".txt"
    out_file = open(out_name, 'w')
    if (not out_file):
        print("File open error!")
        quit()
    npts = t_sample * 1000  # dt = 0.001 -- spike temporal resolution 
    x_vec = interpolate(x[start_frame:end_frame], npts)
    z_vec = interpolate(z[start_frame:end_frame], npts)
    vx_vec = interpolate(v_x[start_frame:end_frame], npts)
    vz_vec = interpolate(v_z[start_frame:end_frame], npts)
    for i in range(npts):
        out_file.write("%0.2f " % x_vec[i])
    out_file.write("\n")
    for i in range(npts):
        out_file.write("%0.2f " % z_vec[i])
    out_file.write("\n")
    for i in range(npts):
        out_file.write("%0.2f " % vx_vec[i])
    out_file.write("\n")
    for i in range(npts):
        out_file.write("%0.2f " % vz_vec[i])
    out_file.write("\n")
   
def interpolate(x, pts):
    dat = np.zeros(pts)
    x_len = len(x)
    for i in range(pts):
        j = int(x_len / pts * i)
        dat[i] = x[j]
    return dat

if __name__ == "__main__":
    main()
