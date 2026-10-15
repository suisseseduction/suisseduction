@echo off
set FFMPEG=C:\Users\marty\AppData\Local\Microsoft\WinGet\Packages\Gyan.FFmpeg_Microsoft.Winget.Source_8wekyb3d8bbwe\ffmpeg-9.0.2-full_build\bin\ffmpeg.exe

echo Creating final working video for Suisseduction...

rem Create title section with text - using drawtext properly
%FFMPEG% -f lavfi -i "color=c=222222:s=1280x720:d=3" -vf "drawtext=fontfile=C\:/Windows/Fonts/arialbd.ttf: text='Suisseduction': fontcolor=white: fontsize=80: x=(w-text_w)/2: y=h/3, drawtext=fontfile=C\:/Windows/Fonts/arial.ttf: text='Coach privé de séduction': fontcolor=white: fontsize=40: x=(w-text_w)/2: y=h/2" -c:v libx264 -pix_fmt yuv420p -r 30 -y title.mp4

rem Create services section
%FFMPEG% -f lavfi -i "color=c=f8f9fa:s=1280x720:d=3" -vf "drawtext=fontfile=C\:/Windows/Fonts/arialbd.ttf: text='Nos Services': fontcolor=black: fontsize=60: x=(w-text_w)/2: y=h/3, drawtext=fontfile=C\:/Windows/Fonts/arial.ttf: text='Théorie, Nightgame, Textgame': fontcolor=black: fontsize=30: x=(w-text_w)/2: y=h/2" -c:v libx264 -pix_fmt yuv420p -r 30 -y services.mp4

rem Create process section
%FFMPEG% -f lavfi -i "color=c=ffffff:s=1280x720:d=3" -vf "drawtext=fontfile=C\:/Windows/Fonts/arialbd.ttf: text='Notre Processus': fontcolor=black: fontsize=60: x=(w-text_w)/2: y=h/3, drawtext=fontfile=C\:/Windows/Fonts/arial.ttf: text='1. Appel gratuit': fontcolor=black: fontsize=30: x=(w-text_w)/2-150: y=h/2-30, drawtext=fontfile=C\:/Windows/Fonts/arial.ttf: text='2. Programme perso': fontcolor=black: fontsize=30: x=(w-text_w)/2-150: y=h/2, drawtext=fontfile=C\:/Windows/Fonts/arial.ttf: text='3. Sorties pratiques': fontcolor=black: fontsize=30: x=(w-text_w)/2-150: y=h/2+30" -c:v libx264 -pix_fmt yuv420p -r 30 -y process.mp4

rem Create benefits section
%FFMPEG% -f lavfi -i "color=c=ff6b6b:s=1280x720:d=3" -vf "drawtext=fontfile=C\:/Windows/Fonts/arialbd.ttf: text='Pourquoi choisir Suisseduction?': fontcolor=white: fontsize=50: x=(w-text_w)/2: y=h/3, drawtext=fontfile=C\:/Windows/Fonts/arial.ttf: text='12+ ans d''expérience': fontcolor=white: fontsize=30: x=(w-text_w)/2-150: y=h/2-30, drawtext=fontfile=C\:/Windows/Fonts/arial.ttf: text='300+ réussites': fontcolor=white: fontsize=30: x=(w-text_w)/2-150: y=h/2+30" -c:v libx264 -pix_fmt yuv420p -r 30 -y benefits.mp4

rem Create contact section
%FFMPEG% -f lavfi -i "color=c=4ecdc4:s=1280x720:d=3" -vf "drawtext=fontfile=C\:/Windows/Fonts/arialbd.ttf: text='Prêt à transformer votre vie?': fontcolor=white: fontsize=50: x=(w-text_w)/2: y=h/3, drawtext=fontfile=C\:/Windows/Fonts/arial.ttf: text='info@suisseduction.ch': fontcolor=white: fontsize=40: x=(w-text_w)/2: y=h/2, drawtext=fontfile=C\:/Windows/Fonts/arial.ttf: text='www.suisseduction.ch': fontcolor=white: fontsize=30: x=(w-text_w)/2: y=h/2+50" -c:v libx264 -pix_fmt yuv420p -r 30 -y contact.mp4

echo Creating file list...
echo file 'title.mp4' > filelist.txt
echo file 'services.mp4' >> filelist.txt
echo file 'process.mp4' >> filelist.txt
echo file 'benefits.mp4' >> filelist.txt
echo file 'contact.mp4' >> filelist.txt

echo Combining sections...
%FFMPEG% -f concat -safe 0 -i filelist.txt -c copy suisseduction-final-video.mp4

echo Cleaning up...
del title.mp4 services.mp4 process.mp4 benefits.mp4 contact.mp4 filelist.txt

echo Final video created: suisseduction-final-video.mp4