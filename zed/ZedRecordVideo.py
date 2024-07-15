import sys
import os
import pyzed.sl as sl

start_flag = True
class VideoRecorder:
	def __init__(self, output_path):
		self.zed = sl.Camera()

		self.init_params = sl.InitParameters()
		self.init_params.camera_resolution = sl.RESOLUTION.HD720
		self.init_params.coordinate_system = sl.COORDINATE_SYSTEM.RIGHT_HANDED_Y_UP
		self.init_params.coordinate_units = sl.UNIT.METER
		self.init_params.depth_mode = sl.DEPTH_MODE.ULTRA
		self.init_params.camera_fps = 60

		err = self.zed.open(self.init_params)
		if err != sl.ERROR_CODE.SUCCESS:
			print('ERROR1')
			exit(1)

		self.recording_param = sl.RecordingParameters(output_path, sl.SVO_COMPRESSION_MODE.H264)
		err = self.zed.enable_recording(self.recording_param)
		if err != sl.ERROR_CODE.SUCCESS:
			print('ERROR2')
			exit(1)

		self.runtime_parameters = sl.RuntimeParameters()

	def startRecord(self):
		frame_recorded = 0
		while start_flag:
			if self.zed.grab(self.runtime_parameters) == sl.ERROR_CODE.SUCCESS:
				# state = self.zed.record()
				# if state['status']:
				frame_recorded += 1
				if frame_recorded % self.init_params.camera_fps == 0:
					print('Recording %d Second' % (frame_recorded/self.init_params.camera_fps))
		return frame_recorded

	def stopRecord(self):
		self.zed.disable_recording()
		self.zed.close()

def main():
	dp = sys.argv[1]
	if not os.path.isdir(dp):
		os.mkdir(dp)
	fp = dp + '\\zed.svo'

	mc = VideoRecorder(fp)

	print('Wait for start.')
	input()

	mc.startRecord()
	mc.stopRecord()

if __name__ == "__main__":
    main()