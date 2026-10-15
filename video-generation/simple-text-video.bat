@echo off
set FFMPEG=C:\Users\marty\AppData\Local\Microsoft\WinGet\Packages\Gyan.FFmpeg_Microsoft.Winget.Source_8wekyb3d8bbwe\ffmpeg-9.0.2-full_build\bin\ffmpeg.exe

echo Creating simple text video for Suisseduction...

rem Create a simple video with text using drawtext - basic version
%FFMPEG% -f lavfi -i "color=c=222222:s=1280x720:d=3" -vf "drawtext=text='Suisseduction': fontcolor=white: fontsize=60: box=1: boxcolor=0x00000099: boxborderw=5: x=(w-text_w)/2: y=(h-text_h)/2" -c:v libx264 -pix_fmt yuv420p -r 30 -y title.mp4

%FFMPEG% -f lavfi -i "color=c=f8f9fa:s=1280x720:d=3" -vf "drawtext=text='Nos Services': fontcolor=black: fontsize=60: box=1: boxcolor=0xFFFFFF99: boxborderw=5: x=(w-text_w)/2: y=(h-text_h)/2" -c:v libx264 -pix_fmt yuv420p -r 30 -y services.mp4

%FFMPEG% -f lavfi -i "color=c=ffffff:s=1280x720:d=3" -vf "drawtext=text='Notre Processus': fontcolor=black: fontsize=60: box=1: boxcolor=0xFFFFFF99: boxborderw=5: x=(w-text_w)/2: y=(h-text_h)/2" -c:v libx264 -pix_fmt yuv420p -r 30 -y process.mp4

%FFMPEG% -f lavfi -i "color=c=ff6b6b:s=1280x720:d=3" -vf "drawtext=text='Pourquoi choisir Suisseduction?': fontcolor=white: fontsize=50: box=1: boxcolor=0x00000099: boxborderw=5: x=(w-text_w)/2: y=(h-text_h)/2" -c:v libx264 -pix_fmt yuv420p -r 30 -y benefits.mp4

%FFMPEG% -f lavfi -i "color=c=4ecdc4:s=1280x720:d=3" -vf "drawtext=text='Prêt à transformer votre vie?': fontcolor=white: fontsize=50: box=1: boxcolor=0x00000099: boxborderw=5: x=(w-text_w)/2: y=(h-text_h)/2" -c:v libx264 -pix_fmt yuv420p -r 30 -y contact.mp4

echo Creating file list...
echo file 'title.mp4' > filelist.txt
echo file 'services.mp4' >> filelist.txt
echo file 'process.mp4' >> filelist.txt
echo file 'benefits.mp4' >> filelist.txt
echo file 'contact.mp4' >> filelist.txt

echo Combining sections...
%FFMPEG% -f concat -safe 0 -i filelist.txt -c copy suisseduction-simple-text-video.mp4

echo Cleaning up...
del title.mp4 services.mp4 process.mp4 benefits.mp4 contact.mp4 filelist.txt

echo Simple text video created: suisseduction-simple-text-video.mp4