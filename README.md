![FFmpeg Snippets](/FFMPEG-Snippets.png)

## List of useful ffmpeg commands for common tasks

> FFMPEG is a video and audio converter as well as a live video/audio capture program with on-the-fly conversion capabilities.

### GRAB FRAME THUMBNAIL    

  `ffmpeg -i vid.mov -vframes 1 -s 320x240 -ss 10 thumb.jpg`

  -vframes  Single Frame
  -ss       Offset

  `ffmpeg -i rtmp://streamurl -r 1 frames/%04d-frame.png`

  This will consume the stream at rtmp://streamurl and output it as one PNG per second.
