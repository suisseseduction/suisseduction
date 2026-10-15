@echo off
set FFMPEG=C:\Users\marty\AppData\Local\Microsoft\WinGet\Packages\Gyan.FFmpeg_Microsoft.Winget.Source_8wekyb3d8bbwe\ffmpeg-9.0.2-full_build\bin\ffmpeg.exe

echo Creating better graphic video for Suisseduction...

rem Create title section with text
%FFMPEG% -f lavfi -i "color=c=222222:s=1280x720:t=3" -vf "drawtext=fontfile=C\:/Windows/Fonts/arialbd.ttf: text='Suisseduction': fontcolor=white: fontsize=100: x=(w-text_w)/2: y=h/3, drawtext=fontfile=C\:/Windows/Fonts/arial.ttf: text='Coach privé de séduction': fontcolor=white: fontsize=50: x=(w-text_w)/2: y=h/2" -c:v libx264 -pix_fmt yuv420p -r 30 title.mp4

rem Create services section with icons (using colored shapes)
%FFMPEG% -f lavfi -i "color=c=f8f9fa:s=1280x720:t=3" -vf "drawtext=fontfile=C\:/Windows/Fonts/arialbd.ttf: text='Nos Services': fontcolor=black: fontsize=80: x=(w-text_w)/2: y=h/4, drawtext=fontfile=C\:/Windows/Fonts/arial.ttf: text='• Théorie simplifiée': fontcolor=black: fontsize=40: x=(w-text_w)/2-200: y=h/2-50, drawtext=fontfile=C\:/Windows/Fonts/arial.ttf: text='• Nightgame & Daygame': fontcolor=black: fontsize=40: x=(w-text_w)/2-200: y=h/2, drawtext=fontfile=C\:/Windows/Fonts/arial.ttf: text='• Text game & Apps': fontcolor=black: fontsize=40: x=(w-text_w)/2-200: y=h/2+50" -c:v libx264 -pix_fmt yuv420p -r 30 services.mp4

rem Create process section with steps
%FFMPEG% -f lavfi -i "color=c=ffffff:s=1280x720:t=3" -vf "drawtext=fontfile=C\:/Windows/Fonts/arialbd.ttf: text='Notre Processus': fontcolor=black: fontsize=80: x=(w-text_w)/2: y=h/5, drawtext=fontfile=C\:/Windows/Fonts/arial.ttf: text='1. Appel découverte': fontcolor=black: fontsize=40: x=(w-text_w)/2-300: y=h/2-80, drawtext=fontfile=C\:/Windows/Fonts/arial.ttf: text='2. Programme perso': fontcolor=black: fontsize=40: x=(w-text_w)/2-300: y=h/2-20, drawtext=fontfile=C\:/Windows/Fonts/arial.ttf: text='3. Sorties pratiques': fontcolor=black: fontsize=40: x=(w-text_w)/2-300: y=h/2+40, drawtext=fontfile=C\:/Windows/Fonts/arial.ttf: text='4. Résultats': fontcolor=black: fontsize=40: x=(w-text_w)/2-300: y=h/2+100" -c:v libx264 -pix_fmt yuv420p -r 30 process.mp4

rem Create benefits section
%FFMPEG% -f lavfi -i "color=c=ff6b6b:s=1280x720:t=3" -vf "drawtext=fontfile=C\:/Windows/Fonts/arialbd.ttf: text='Pourquoi choisir Suisseduction?': fontcolor=white: fontsize=60: x=(w-text_w)/2: y=h/4, drawtext=fontfile=C\:/Windows/Fonts/arial.ttf: text='12+ ans d''expérience': fontcolor=white: fontsize=40: x=(w-text_w)/2-200: y=h/2-40, drawtext=fontfile=C\:/Windows/Fonts/arial.ttf: text='300+ réussites': fontcolor=white: fontsize=40: x=(w-text_w)/2-200: y=h/2+20, drawtext=fontfile=C\:/Windows/Fonts/arial.ttf: text='Méthode éprouvée': fontcolor=white: fontsize=40: x=(w-text_w)/2-200: y=h/2+80" -c:v libx264 -pix_fmt yuv420p -r 30 benefits.mp4

rem Create contact section
%FFMPEG% -f lavfi -i "color=c=4ecdc4:s=1280x720:t=3" -vf "drawtext=fontfile=C\:/Windows/Fonts/arialbd.ttf: text='Prêt à transformer votre vie?': fontcolor=white: fontsize=60: x=(w-text_w)/2: y=h/3, drawtext=fontfile=C\:/Windows/Fonts/arial.ttf: text='info@suisseduction.ch': fontcolor=white: fontsize=50: x=(w-text_w)/2: y=h/2, drawtext=fontfile=C\:/Windows/Fonts/arial.ttf: text='www.suisseduction.ch': fontcolor=white: fontsize=40: x=(w-text_w)/2: y=h/2+60" -c:v libx264 -pix_fmt yuv420p -r 30 contact.mp4

echo Creating file list...
echo file 'title.mp4' > filelist.txt
echo file 'services.mp4' >> filelist.txt
echo file 'process.mp4' >> filelist.txt
echo file 'benefits.mp4' >> filelist.txt
echo file 'contact.mp4' >> filelist.txt

echo Combining sections...
%FFMPEG% -f concat -safe 0 -i filelist.txt -c copy suisseduction-better-video.mp4

echo Cleaning up...
del title.mp4 services.mp4 process.mp4 benefits.mp4 contact.mp4 filelist.txt

echo Better video created: suisseduction-better-video.mp4