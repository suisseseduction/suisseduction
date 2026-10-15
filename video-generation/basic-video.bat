@echo off
set FFMPEG=C:\Users\marty\AppData\Local\Microsoft\WinGet\Packages\Gyan.FFmpeg_Microsoft.Winget.Source_8wekyb3d8bbwe\ffmpeg-9.0.2-full_build\bin\ffmpeg.exe

echo Creating basic graphic video for Suisseduction...

rem Create simple color clips without complex text
%FFMPEG% -f lavfi -i "color=c=222222:s=1280x720:d=3" -c:v libx264 -pix_fmt yuv420p -r 30 title.mp4
%FFMPEG% -f lavfi -i "color=c=f8f9fa:s=1280x720:d=3" -c:v libx264 -pix_fmt yuv420p -r 30 services.mp4
%FFMPEG% -f lavfi -i "color=c=ffffff:s=1280x720:d=3" -c:v libx264 -pix_fmt yuv420p -r 30 process.mp4
%FFMPEG% -f lavfi -i "color=c=ff6b6b:s=1280x720:d=3" -c:v libx264 -pix_fmt yuv420p -r 30 benefits.mp4
%FFMPEG% -f lavfi -i "color=c=4ecdc4:s=1280x720:d=3" -c:v libx264 -pix_fmt yuv420p -r 30 contact.mp4

echo Creating file list...
echo file 'title.mp4' > filelist.txt
echo file 'services.mp4' >> filelist.txt
echo file 'process.mp4' >> filelist.txt
echo file 'benefits.mp4' >> filelist.txt
echo file 'contact.mp4' >> filelist.txt

echo Combining sections...
%FFMPEG% -f concat -safe 0 -i filelist.txt -c copy suisseduction-basic-video.mp4

echo Cleaning up...
del title.mp4 services.mp4 process.mp4 benefits.mp4 contact.mp4 filelist.txt

echo Basic video created: suisseduction-basic-video.mp4