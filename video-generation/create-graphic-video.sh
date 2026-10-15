#!/bin/bash

# FFmpeg path
FFMPEG="C:\Users\marty\AppData\Local\Microsoft\WinGet\Packages\Gyan.FFmpeg_Microsoft.Winget.Source_8wekyb3d8bbwe\ffmpeg-9.0.2-full_build\bin\ffmpeg.exe"

# Create a simple graphic design video explaining Suisseduction
# Using FFmpeg with text overlays and color backgrounds

OUTPUT="suisseduction-graphic-video.mp4"
DURATION=50  # Total duration in seconds
SECTION_DURATION=8  # Duration per section

# Create temporary directory for color frames
mkdir -p temp_frames

# Define colors (in hex)
COLORS=(
    "#222222"  # Dark background (from website)
    "#f8f9fa"  # Light background
    "#ffffff"  # White
    "#ff6b6b"  # Primary color (red/pink from website)
    "#4ecdc4"  # Teal accent
    "#45b7d1"  # Blue accent
)

# Function to create a color frame with text
create_frame() {
    local bg_color=$1
    local text=$2
    local fontsize=$3
    local y_pos=$4
    local output_file=$5
    
    "$FFMPEG" -f lavfi -i "color=c=$bg_color:s=1280x720:d=$SECTION_DURATION" \
        -vf "drawtext=fontfile=/usr/share/fonts/truetype/dejavu/DejaVuSans-Bold.ttf: \
        text='$text': fontcolor=white: fontsize=$fontsize: box=1: boxcolor=0x00000099: \
        boxborderw=5: x=(w-text_w)/2: y=$y_pos" \
        -c:v libx264 -pix_fmt yuv420p -r 30 "$output_file"
}

# Create sections
echo "Creating video sections..."

# Section 1: Title
create_frame "${COLORS[0]}" "Suisseduction" 80 "h/3" "temp_frames/01_title.mp4"
create_frame "${COLORS[0]}" "Coach privé de séduction & drague en Suisse Romande" 40 "h/2+50" "temp_frames/01_subtitle.mp4"

# Section 2: What we offer
create_frame "${COLORS[1]}" "Nos Services" 60 "h/4" "temp_frames/02_services_title.mp4"
create_frame "${COLORS[1]}" "• Théorie simplifiée - Guide exclusif" 30 "h/2-50" "temp_frames/02_service1.mp4"
create_frame "${COLORS[1]}" "• Nightgame & Daygame - Sorties pratiques" 30 "h/2" "temp_frames/02_service2.mp4"
create_frame "${COLORS[1]}" "• Text game & Apps de rencontre" 30 "h/2+50" "temp_frames/02_service3.mp4"

# Section 3: The process
create_frame "${COLORS[2]}" "Notre Processus" 60 "h/4" "temp_frames/03_process_title.mp4"
create_frame "${COLORS[2]}" "1. Appel découverte gratuit (20 min)" 30 "h/2-70" "temp_frames/03_step1.mp4"
create_frame "${COLORS[2]}" "2. Programme personnalisé" 30 "h/2-20" "temp_frames/03_step2.mp4"
create_frame "${COLORS[2]}" "3. Sorties pratiques & feedback" 30 "h/2+30" "temp_frames/03_step3.mp4"
create_frame "${COLORS[2]}" "4. Résultats garantis" 30 "h/2+80" "temp_frames/03_step4.mp4"

# Section 4: Key benefits
create_frame "${COLORS[3]}" "Pourquoi choisir Suisseduction?" 50 "h/3" "temp_frames/04_benefits_title.mp4"
create_frame "${COLORS[3]}" "• 12+ ans d'expérience" 30 "h/2-30" "temp_frames/04_benefit1.mp4"
create_frame "${COLORS[3]}" "• Plus de 300 connexions réussies" 30 "h/2+10" "temp_frames/04_benefit2.mp4"
create_frame "${COLORS[3]}" "• Approche pratique & efficace" 30 "h/2+50" "temp_frames/04_benefit3.mp4"

# Section 5: Contact
create_frame "${COLORS[4]}" "Prêt à transformer votre vie?" 50 "h/3" "temp_frames/05_contact_title.mp4"
create_frame "${COLORS[4]}" "info@suisseduction.ch" 40 "h/2" "temp_frames/05_contact_info.mp4"
create_frame "${COLORS[4]}" "www.suisseduction.ch" 30 "h/2+50" "temp_frames/05_contact_web.mp4"

# Combine all sections with crossfade transitions
echo "Combining sections..."

# Create a file list for concat demuxer
echo "file 'temp_frames/01_title.mp4'" > filelist.txt
echo "file 'temp_frames/01_subtitle.mp4'" >> filelist.txt
echo "file 'temp_frames/02_services_title.mp4'" >> filelist.txt
echo "file 'temp_frames/02_service1.mp4'" >> filelist.txt
echo "file 'temp_frames/02_service2.mp4'" >> filelist.txt
echo "file 'temp_frames/02_service3.mp4'" >> filelist.txt
echo "file 'temp_frames/03_process_title.mp4'" >> filelist.txt
echo "file 'temp_frames/03_step1.mp4'" >> filelist.txt
echo "file 'temp_frames/03_step2.mp4'" >> filelist.txt
echo "file 'temp_frames/03_step3.mp4'" >> filelist.txt
echo "file 'temp_frames/03_step4.mp4'" >> filelist.txt
echo "file 'temp_frames/04_benefits_title.mp4'" >> filelist.txt
echo "file 'temp_frames/04_benefit1.mp4'" >> filelist.txt
echo "file 'temp_frames/04_benefit2.mp4'" >> filelist.txt
echo "file 'temp_frames/04_benefit3.mp4'" >> filelist.txt
echo "file 'temp_frames/05_contact_title.mp4'" >> filelist.txt
echo "file 'temp_frames/05_contact_info.mp4'" >> filelist.txt
echo "file 'temp_frames/05_contact_web.mp4'" >> filelist.txt

# Use concat demuxer to join all videos
"$FFMPEG" -f concat -safe 0 -i filelist.txt -c copy "$OUTPUT"

# Clean up
rm -f filelist.txt
rm -rf temp_frames

echo "Video created: $OUTPUT"