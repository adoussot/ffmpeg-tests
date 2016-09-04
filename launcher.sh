#!/usr/bin/bash

declare -a Folder=("TestPreset" "TestProfile" "TestSize" "TestBitrate" "TestCrf" "TestTune")

function launch {
    echo "**** launch FFMPEG ****"
    input=$1
    bitrate=$2
    size=$3
    profile=$4
    level=$5
    preset=$6
    crf=$7
    folder=$8
    tune=$9
    ./mediapeer.sh "$1" "$bitrate" "$size" "$profile" "$level" "$preset" "$crf" "$folder" "$tune" 
}

function launchQuality {
    input=$1
    echo "**** launch QUALITY ****"
    folder=$1
    analyser=$2
    #./qpsnr -s 300 -m 500 -r ../03_150414_AirFrance_1920x1080-24p_VO-51_Uncompressed.mov $(ls -1 $folder/*) -a $analyser  > $folder"/arfr_"$folder"_"$analyser".csv"
    ./qpsnr -s 300 -m 500 -a $analyser -o fpa=500 -r $input  $(ls -1 $folder/*) >  $folder"/arfr_"$folder"_"$analyser".csv"     
    # analysis=$(cut -d, -f 2 temp.csv | grep -v ".m")
    # echo "${analysis}"
}

##  *********************  
##  ********************* CREATE FOLDERS
##  *********************  


for i in "${Folder[@]}"
do 
    echo "$i"
    mkdir -p "$i"
done


##  *********************  
##  ********************* CREATE FOLDERS
##  *********************  

function computePreset {
    echo "**** COMPUTE PRESET ****"
    rm "${Folder[0]}/"*
    ## Preset tests
    launch  $1      "4500k"     "1920x1080"     high        4.0     slow        20      "${Folder[0]}/"     ""
    launch  $1      "4500k"     "1920x1080"     high        4.0     veryslow    20      "${Folder[0]}/"     ""
    launch  $1      "4500k"     "1920x1080"     high        4.0     medium      20      "${Folder[0]}/"     ""
    launch  $1      "4500k"     "1920x1080"     high        4.0     fast        20      "${Folder[0]}/"     ""
    launch  $1      "4500k"     "1920x1080"     high        4.0     placebo     20      "${Folder[0]}/"     ""
}           
            
function computeProfile {               
    echo "**** COMPUTE PROFILE ****"            
    rm "${Folder[1]}/"*
    ## Profile test20               
    launch  $1      "4500k"     "1920x1080"     baseline    4.0     slow        20      "${Folder[1]}/"     ""
    launch  $1      "4500k"     "1920x1080"     main        4.0     slow        20      "${Folder[1]}/"     ""
    launch  $1      "4500k"     "1920x1080"     high        4.0     slow        20      "${Folder[1]}/"     ""
    launch  $1      "4500k"     "1920x1080"     high10      4.0     slow        20      "${Folder[1]}/"     ""
    launch  $1      "4500k"     "1920x1080"     high422     4.0     slow        20      "${Folder[1]}/"     ""
    launch  $1      "4500k"     "1920x1080"     high444     4.0     slow        20      "${Folder[1]}/"     ""
}           
        
function computeSize {              
    echo "**** COMPUTE SIZE ****"   
    rm "${Folder[2]}/"*     
    ## Size test20          
    launch  $1      "8000k"     "1920x1080"     high        4.0     slow        20      "${Folder[2]}/"     ""
    launch  $1      "5000k"     "1280x720"      main        3.1     slow        20      "${Folder[2]}/"     ""
    launch  $1      "3500k"     "1024x576"      main        3.1     slow        20      "${Folder[2]}/"     ""
    launch  $1      "2500k"     "853x480"       baseline    3.0     slow        20      "${Folder[2]}/"     ""
    launch  $1      "1000k"     "640x360"       baseline    3.0     slow        20      "${Folder[2]}/"     ""
    launch  $1      "500k"      "426x240"       baseline    2.1     slow        20      "${Folder[2]}/"     ""
}               
                
function computeBitrate {               
    echo "**** COMPUTE BITRATE ****"
    rm "${Folder[3]}/"*         
    ## Bitrate test20               
    launch  $1      "8000k"     "1920x1080"     high        4.0     slow        20      "${Folder[3]}/"     ""
    launch  $1      "7000k"     "1920x1080"     high        4.0     slow        20      "${Folder[3]}/"     ""
    launch  $1      "6000k"     "1920x1080"     high        4.0     slow        20      "${Folder[3]}/"     ""
    launch  $1      "5000k"     "1920x1080"     high        4.0     slow        20      "${Folder[3]}/"     ""
    launch  $1      "4000k"     "1920x1080"     high        4.0     slow        20      "${Folder[3]}/"     ""
    launch  $1      "3000k"     "1920x1080"     high        4.0     slow        20      "${Folder[3]}/"     ""
    launch  $1      "2000k"     "1920x1080"     high        4.0     slow        20      "${Folder[3]}/"     ""
    launch  $1      "1000k"     "1920x1080"     high        4.0     slow        20      "${Folder[3]}/"     ""
}       
        
function computeCrf {           
    echo "**** COMPUTE SIZE ****" 
    rm "${Folder[4]}/"*         
    ## Size test20      4.0     
    launch  $1      "4500k"     "1920x1080"     high        4.0     slow        16      "${Folder[4]}/"     ""
    launch  $1      "4500k"     "1920x1080"     high        4.0     slow        17      "${Folder[4]}/"     ""
    launch  $1      "4500k"     "1920x1080"     high        4.0     slow        18      "${Folder[4]}/"     ""
    launch  $1      "4500k"     "1920x1080"     high        4.0     slow        19      "${Folder[4]}/"     ""
    launch  $1      "4500k"     "1920x1080"     high        4.0     slow        20      "${Folder[4]}/"     ""
    launch  $1      "4500k"     "1920x1080"     high        4.0     slow        21      "${Folder[4]}/"     ""
}           
            
function computeTune {          
    echo "**** COMPUTE TUNE ****"   
    rm "${Folder[5]}/"*     
    ## Tune Test20              
    launch  $1      "4500k"         "1920x1080"     high        4.0     slow        20      "${Folder[5]}/"     "-tune film"
    launch  $1      "4500k"         "1920x1080"     high        4.0     slow        20      "${Folder[5]}/"     "-tune animation"
    launch  $1      "4500k"         "1920x1080"     high        4.0     slow        20      "${Folder[5]}/"     "-tune grain"
    launch  $1      "4500k"         "1920x1080"     high        4.0     slow        20      "${Folder[5]}/"     "-tune stillimage"
    launch  $1      "4500k"         "1920x1080"     high        4.0     slow        20      "${Folder[5]}/"     "-tune psnr"
    launch  $1      "4500k"         "1920x1080"     high        4.0     slow        20      "${Folder[5]}/"     "-tune ssim"
}

function computeQuality {
    input=$1
    echo "**** COMPUTE QUALITY ****"    
    for i in "${Folder[@]}"
    do 
        launchQuality $input "$i" avg_psnr
        launchQuality $input "$i" avg_ssim
    done
}


computePreset       $1
computeProfile      $1
computeSize         $1
                        
computeBitrate      $1
computeCrf          $1
computeTune         $1
computeQuality      $1

#launchQuality "Preset" avg_psnr


