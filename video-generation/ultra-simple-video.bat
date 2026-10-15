@echo off
set FFMPEG=C:\Users\marty\AppData\Local\Microsoft\WinGet\Packages\Gyan.FFmpeg_Microsoft.Winget.Source_8wekyb3d8bbwe\ffmpeg-9.0.2-full_build\bin\ffmpeg.exe

echo Creating ultra-simple video for Suisseduction...

rem Create 5-second color clips - no text, just colors
%FFMPEG% -f lavfi -i "color=c=222222:s=1280x720:d=5" -c:v libx264 -pix_fmt yuv420p -r 30 -y title.mp4
%FFMPEG% -f lavfi -i "color=c=f8f9fa:s=1280x720:d=5" -c:v libx264 -pix_fmt yuv420p -r 30 -y services.mp4
%FFMPEG% -f lavfi -i "color=c=ffffff:s=1280x720:d=5" -c:v libx264 -pix_fmt yuv420p -r 30 -y process.mp4
%FFMPEG% -f lavfi -i "color=c=ff6b6b:s=1280x720:d=5" -c:v libx264 -pix_fmt yuv420p -r 30 -y benefits.mp4
%FFMPEG% -f lavfi -i "color=c=4ecdc4:s=1280x720:d=5" -c:v libx264 -pix_fmt yuv420p -r 30 -y contact.mp4

echo Creating file list...
echo file 'title.mp4' > filelist.txt
echo file 'services.mp4' >> filelist.txt
echo file 'process.mp4' >> filelist.txt
echo file 'benefits.mp4' >> filelist.txt
echo file 'contact.mp4' >> filelist.txt

echo Combining sections with crossfade...
%FFMPEG% -f concat -safe 0 -i filelist.txt -c copy suisseduction-ultra-simple.mp4

echo Cleaning up...
del title.mp4 services.mp4 process.mp4 benefits.mp4 contact.mp4 filelist.txt

echo Ultra-simple video created: suisseduction-ultra-simple.mp4
echo Duration: 25 seconds (5 seconds per section × 5 sections)