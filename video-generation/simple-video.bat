@echo off
set FFMPEG=C:\Users\marty\AppData\Local\Microsoft\WinGet\Packages\Gyan.FFmpeg_Microsoft.Winget.Source_8wekyb3d8bbwe\ffmpeg-9.0.2-full_build\bin\ffmpeg.exe

echo Creating simple graphic video for Suisseduction...

rem Create a simple color background video with text
%FFMPEG% -f lavfi -i "color=c=222222:s=1280x720:d=5" -vf "drawtext=fontfile=C\:/Windows/Fonts/arial.ttf: text='Suisseduction': fontcolor=white: fontsize=80: box=1: boxcolor=0x00000099: boxborderw=5: x=(w-text_w)/2: y=h/3, drawtext=fontfile=C\:/Windows/Fonts/arial.ttf: text='Coach privé de séduction & drague en Suisse Romande': fontcolor=white: fontsize=40: box=1: boxcolor=0x00000099: boxborderw=5: x=(w-text_w)/2: y=h/2+50" -c:v libx264 -pix_fmt yuv420p -r 30 title.mp4

%FFMPEG% -f lavfi -i "color=c=f8f9fa:s=1280x720:d=5" -vf "drawtext=fontfile=C\:/Windows/Fonts/arial.ttf: text='Nos Services': fontcolor=black: fontsize=60: box=1: boxcolor=0xFFFFFF99: boxborderw=5: x=(w-text_w)/2: y=h/4, drawtext=fontfile=C\:/Windows/Fonts/arial.ttf: text='• Théorie simplifiée - Guide exclusif': fontcolor=black: fontsize=30: box=1: boxcolor=0xFFFFFF99: boxborderw=5: x=(w-text_w)/2: y=h/2-50, drawtext=fontfile=C\:/Windows/Fonts/arial.ttf: text='• Nightgame & Daygame - Sorties pratiques': fontcolor=black: fontsize=30: box=1: boxcolor=0xFFFFFF99: boxborderw=5: x=(w-text_w)/2: y=h/2, drawtext=fontfile=C\:/Windows/Fonts/arial.ttf: text='• Text game & Apps de rencontre': fontcolor=black: fontsize=30: box=1: boxcolor=0xFFFFFF99: boxborderw=5: x=(w-text_w)/2: y=h/2+50" -c:v libx264 -pix_fmt yuv420p -r 30 services.mp4

%FFMPEG% -f lavfi -i "color=c=ffffff:s=1280x720:d=5" -vf "drawtext=fontfile=C\:/Windows/Fonts/arial.ttf: text='Notre Processus': fontcolor=black: fontsize=60: box=1: boxcolor=0xFFFFFF99: boxborderw=5: x=(w-text_w)/2: y=h/4, drawtext=fontfile=C\:/Windows/Fonts/arial.ttf: text='1. Appel découverte gratuit (20 min)': fontcolor=black: fontsize=30: box=1: boxcolor=0xFFFFFF99: boxborderw=5: x=(w-text_w)/2: y=h/2-70, drawtext=fontfile=C\:/Windows/Fonts/arial.ttf: text='2. Programme personnalisé': fontcolor=black: fontsize=30: box=1: boxcolor=0xFFFFFF99: boxborderw=5: x=(w-text_w)/2: y=h/2-20, drawtext=fontfile=C\:/Windows/Fonts/arial.ttf: text='3. Sorties pratiques & feedback': fontcolor=black: fontsize=30: box=1: boxcolor=0xFFFFFF99: boxborderw=5: x=(w-text_w)/2: y=h/2+30, drawtext=fontfile=C\:/Windows/Fonts/arial.ttf: text='4. Résultats garantis': fontcolor=black: fontsize=30: box=1: boxcolor=0xFFFFFF99: boxborderw=5: x=(w-text_w)/2: y=h/2+80" -c:v libx264 -pix_fmt yuv420p -r 30 process.mp4

%FFMPEG% -f lavfi -i "color=c=ff6b6b:s=1280x720:d=5" -vf "drawtext=fontfile=C\:/Windows/Fonts/arial.ttf: text='Pourquoi choisir Suisseduction?': fontcolor=white: fontsize=50: box=1: boxcolor=0x00000099: boxborderw=5: x=(w-text_w)/2: y=h/3, drawtext=fontfile=C\:/Windows/Fonts/arial.ttf: text='• 12+ ans d''expérience': fontcolor=white: fontsize=30: box=1: boxcolor=0x00000099: boxborderw=5: x=(w-text_w)/2: y=h/2-30, drawtext=fontfile=C\:/Windows/Fonts/arial.ttf: text='• Plus de 300 connexions réussies': fontcolor=white: fontsize=30: box=1: boxcolor=0x00000099: boxborderw=5: x=(w-text_w)/2: y=h/2+10, drawtext=fontfile=C\:/Windows/Fonts/arial.ttf: text='• Approche pratique & efficace': fontcolor=white: fontsize=30: box=1: boxcolor=0x00000099: boxborderw=5: x=(w-text_w)/2: y=h/2+50" -c:v libx264 -pix_fmt yuv420p -r 30 benefits.mp4

%FFMPEG% -f lavfi -i "color=c=4ecdc4:s=1280x720:d=5" -vf "drawtext=fontfile=C\:/Windows/Fonts/arial.ttf: text='Prêt à transformer votre vie?': fontcolor=white: fontsize=50: box=1: boxcolor=0x00000099: boxborderw=5: x=(w-text_w)/2: y=h/3, drawtext=fontfile=C\:/Windows/Fonts/arial.ttf: text='info@suisseduction.ch': fontcolor=white: fontsize=40: box=1: boxcolor=0x00000099: boxborderw=5: x=(w-text_w)/2: y=h/2, drawtext=fontfile=C\:/Windows/Fonts/arial.ttf: text='www.suisseduction.ch': fontcolor=white: fontsize=30: box=1: boxcolor=0x00000099: boxborderw=5: x=(w-text_w)/2: y=h/2+50" -c:v libx264 -pix_fmt yuv420p -r 30 contact.mp4

echo Creating file list...
echo file 'title.mp4' > filelist.txt
echo file 'services.mp4' >> filelist.txt
echo file 'process.mp4' >> filelist.txt
echo file 'benefits.mp4' >> filelist.txt
echo file 'contact.mp4' >> filelist.txt

echo Combining sections...
%FFMPEG% -f concat -safe 0 -i filelist.txt -c copy suisseduction-graphic-video.mp4

echo Cleaning up...
del title.mp4 services.mp4 process.mp4 benefits.mp4 contact.mp4 filelist.txt

echo Video created: suisseduction-graphic-video.mp4