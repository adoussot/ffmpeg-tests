#!/usr/bin/bash

input=$1
bitrate=$2
size=$3
profile=$4
level=$5
preset=$6
crf=$7
output=$8
tune=$9

echo "***********"
echo "*** TUNE ****"
echo "***********"

echo "Tune : ${tune}"

if [ -z "${tune}" ]; then
    export OUTPUT="airfr_"$bitrate"_"$size"_"$profile"_"$preset"_crf"$crf
else
    arrIn=(${tune// / })
    echo "${arrIn[1]}"
    export OUTPUT="airfr_"$bitrate"_"$size"_"$profile"_"$preset"_crf"$crf"_${arrIn[1]}"
fi

outfile=${OUTPUT}.mp4
echo $outfile

ffmpeg -i $input \
    -pass 1 -passlogfile video_passlog \
    -movflags faststart \
    -vcodec libx264 \
    -profile:v $profile \
    -level $level \
    -s $size \
    -r 24 \
    -g 24 \
    -pix_fmt yuv420p \
    -crf $crf \
    -b:v $bitrate \
    -preset $preset \
    `"${tune}"` \
    -x264opts "b_adapt=2:cabac:no-interlaced" \
    -weightb 1 \
    -direct-pred auto \
    -acodec aac \
    -b:a 192k \
    -sample_rate 48k \
    -strict -2 \
    $output""$outfile

rm $output""$outfile
    
ffmpeg -i $input \
    -pass 2 -passlogfile video_passlog \
    -movflags faststart \
    -vcodec libx264 \
    -profile:v $profile \
    -level $level \
    -s $size \
    -r 24 \
    -g 24 \
    -pix_fmt yuv420p \
    -crf $crf \
    -b:v $bitrate \
    -preset $preset \
    `"${tune}"` \
    -x264opts "b_adapt=2:cabac:no-interlaced" \
    -weightb 1 \
    -direct-pred auto \
    -acodec aac \
    -b:a 192k \
    -sample_rate 48k \
    -strict -2 \
    $output""$outfile

    # 16 à 20 (??)
    #-aspect 16:9 \
    #-fast-pskip 0 \
    # -me_method umh \
    # -me_range 64 \
    # -trellis 2 \
    # -bf 5
    # -refs 3 \
    #-mixed-refs 1 \

    #-aspect 16:9 \
    #-fast-pskip 0 \
    # -me_method umh \
    # -me_range 64 \
    # -trellis 2 \  
    # -bf 5
    # -refs 3 \
    #-mixed-refs 1 \
