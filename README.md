![FFmpeg Snippets](/FFMPEG-Snippets.png)

## List of useful ffmpeg commands for common tasks

> FFMPEG is a video and audio converter as well as a live video/audio capture program with on-the-fly conversion capabilities.

Table of contents
=================

   * [Get Video Information](#get-video-information)
   * [Grab Frame Thumbnail](#grab-frame-thumbnail)
   * [Add Audio Track](#add-audio-track)
   * [Format Conversion](#format-conversion)


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
