![FFmpeg Snippets](/FFMPEG-Snippets.png)

## List of useful ffmpeg commands for common tasks

> FFMPEG is a video and audio converter as well as a live video/audio capture program with on-the-fly conversion capabilities.

Installation: [Windows](https://www.wikihow.com/Install-FFmpeg-on-Windows) | [Linux](https://askubuntu.com/questions/426543/install-ffmpeg-in-ubuntu-12-04-lts?rq=1) | [Mac](https://github.com/fluent-ffmpeg/node-fluent-ffmpeg/wiki/Installing-ffmpeg-on-Mac-OS-X)

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

