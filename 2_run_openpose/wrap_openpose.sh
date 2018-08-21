#!/bin/sh

module load system
module load singularity

for vid in $SCRATCH/dvcam-final/*/*; do
if [[ $vid == *_16* ]]; then

	#vid=$PI_HOME/rotated_1208.mov	
	echo "Video: $vid"
	time=5:00:00
	memory=8G

	processed_video=$PI_HOME/curiobaby/processed_videos/$(basename $vid).avi
    	json_output_folder=$PI_HOME/curiobaby/json_output/$(basename $vid)
	
	mkdir -p $json_output_folder
	
	sbatch -p gpu --gres gpu:1 -t $time --mem $memory --mail-type=FAIL --mail-user=sanchez7@stanford.edu --wrap="singularity exec --nv $SINGULARITY_CACHEDIR/openpose.simg bash -c 'cd /openpose-master && ./build/examples/openpose/openpose.bin --no_display true --write_video $processed_video --video $vid'"
#--write_keypoint_json $json_output_folder
sleep 1
fi

done
