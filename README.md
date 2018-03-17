![FFmpeg Snippets](/FFMPEG-Snippets.png)

## List of useful ffmpeg commands for common tasks

> FFMPEG is a video and audio converter as well as a live video/audio capture program with on-the-fly conversion capabilities.

Installation: [Windows](https://www.wikihow.com/Install-FFmpeg-on-Windows) | [Linux](https://askubuntu.com/questions/426543/install-ffmpeg-in-ubuntu-12-04-lts?rq=1) | [Mac](https://github.com/fluent-ffmpeg/node-fluent-ffmpeg/wiki/Installing-ffmpeg-on-Mac-OS-X)

References: [19 ffmpeg commands for all needs
](https://www.catswhocode.com/blog/19-ffmpeg-commands-for-all-needs)

Table of contents
=================

   * [Get Video Information](#get-video-information)
   * [Grab Frame Thumbnail](#grab-frame-thumbnail)
   * [Add Audio Track](#add-audio-track)
   * [Format Conversion](#format-conversion)
   * [Join MP3 Files](#join-mp3-files)
   * [Mix a Video with a Sound File](#mix-a-video-with-a-sound-file)
   * [Trim and Cut](#trim-and-cut)
   * [Capture Video](#capture-video) [Linux]
   * [Export Audio](#export-audio)
   * [Show Video Information as JSON](#show-video-information-as-json)
   * [Encode Video Portion](#encode-video-portion)
   * [Replace Audio in a Video File](#replace-audio-in-a-video-file)
   * [Audio Slow Down](#audio-slow-down)


Get Video Information
=====================

  `$ ffmpeg -i filename.flv`

  `$ ffmpeg -ao dummy -vo dummy -identify filename.flv`


Grab Frame Thumbnail    
====================

  `$ ffmpeg -i input.mov -vframes 1 -s 320x240 -ss 10 thumb.jpg`

  -vframes  *Single Frame*<br/>
  -ss       *Offset*

  `$ ffmpeg -i rtmp://streamurl -r 1 frames/%04d-frame.png`

  This will consume the stream at rtmp://streamurl and output it as one PNG per second.


Add Audio Track
===============

  `$ ffmpeg.exe -i input.flv -i input.audio.m4a -vcodec copy -acodec copy -map 0:0 -map 1:0 output.flv`


Format Conversion
=================

  AAC to WAV

  `$ ffmpeg -i input.aac output.wav`

  FLV to MPEG4
  
  `$ ffmpeg -i input.flv -acodec copy output.mp4`


Join MP3 Files
==============

  `$ ffmpeg -i "concat:file1.mp3|file2.mp3" -acodec copy output.mp3`


Mix a Video with a Sound file
=============================

  `$ ffmpeg -i audio.wav -i video.avi output.mpg`


Trim and Cut
============

  REMOVE FIRST 30" FROM AN MP3 FILE

  `$ ffmpeg -i input.mp3 -ss 30 -acodec copy output.mp3`

  KEEP FIRST 30" OF A VIDEO FILE

  `$ ffmpeg -i input.mkv -t 30 -acodec copy -vcodec copy output.mkv`

  KEEP FIRST 30" OF AN MP3 FILE

  -t 30 *Keep only first 30 seconds*

  `$ ffmpeg -i input.mp3 -t 30 -acodec copy output.mp3`

  General Syntax: 
  `$ ffmpeg -i [input file] -ss hh:mm:ss[.xxx] -t [duration in seconds or 
  hh:mm:ss[.xxx]] -vcodec copy -acodec copy [output file]`


Capture Video 
============= 

  [Linux]

  `$ ffmpeg -f x11grab -s wxga -r 25 -i :0.0 -sameq /tmp/output.mpg`


Export Audio
============ 

  `$ ffmpeg -i audio.aac outpuf.aiff`
  
  `$ ffmpeg -i video.avi -vcodec copy -acodec copy -ss 00:00:00 -t 00:00:04 trimmed_video.avi`

  FLV -> MP3              

  `$ ffmpeg -i input.flv -acodec libmp3lame -aq 4 output.mp3`

  FLV -> WAV             
  
  `$ ffmpeg -i input.flv -vn -f wav output.wav`

  MP4 -> MP4-AUDIO        

  `$ ffmpeg -i input.flv -c copy -map 0:a output_audio.mp4`

  MP4 -> MP3

  `$ ffmpeg -i input.flv [-b:a 192K -vn] music.mp3`

  MP4 -> FLAC             

  `$ ffmpeg -i audio.xxx -c:a flac audio.flac`


Show Video Information as JSON
==============================

  `$ ffprobe -v quiet -print_format json -show_format -show_streams somefile.asf` 


Encode Video Portion
====================

  `$ ffmpeg -i move.avi -ss <StartTime> -t <Duration> OutPutFile.avi`


Replace Audio in a Video File
=============================

  `$ ffmpeg -i video.avi -i audio.mp3  -map 0.0:1 -map 1:0 -f avi -vcodec copy -acodec copy output.avi`


Audio Slow Down
===============

  `$ ffmpeg -i input.mp4 -filter:a "atempo=0.5" -vn output.aac`
