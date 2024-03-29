![FFmpeg Snippets](FFMPEG-Snippets.png)

## List of useful ffmpeg commands for common tasks

> FFMPEG is a video and audio converter as well as a live video/audio capture program with on-the-fly conversion capabilities.

Installation: [Windows](https://www.wikihow.com/Install-FFmpeg-on-Windows) | [Linux](https://askubuntu.com/questions/426543/install-ffmpeg-in-ubuntu-12-04-lts?rq=1) | [Mac](https://github.com/fluent-ffmpeg/node-fluent-ffmpeg/wiki/Installing-ffmpeg-on-Mac-OS-X)

General Syntax: `ffmpeg [input file options] -i <input_file> [output file options] <outfile>`

References: [19 ffmpeg commands for all needs
](https://www.catswhocode.com/blog/19-ffmpeg-commands-for-all-needs)

Table of contents
=================

   * [Get Video Information](#get-video-information)
   * [Grab Frame Thumbnail](#grab-frame-thumbnail)
   * [Add Audio Track](#add-audio-track)
   * [Format Conversion](#format-conversion)
      * [Convert Video to MP3](#convert-video-to-mp3)
   * [Join / Concatenate MP3 Files](#join--concatenate-mp3-files)
   * [Mix a Video with a Sound File](#mix-a-video-with-a-sound-file)
   * [Trim and Cut](#trim-and-cut)
   * [Resizing Video](#resizing-video)
   * [Capture Video](#capture-video) [Linux]
   * [Crop Video](#crop-video) [Linux]
   * [Export Audio](#export-audio)
   * [Show Video Information as JSON](#show-video-information-as-json)
   * [Encode Video Portion](#encode-video-portion)
   * [Replace Audio in a Video File](#replace-audio-in-a-video-file)
   * [Audio Slow Down](#audio-slow-down)
   * [Create a Video with Audio from an Image Still](#create-a-video-with-audio-from-an-image-still)
   * [Extract Images from a Video](#extract-images-from-a-video)
   * [Convert VIDEO_TS folder to video](#convert-video_ts-folder-to-video)
   * [From left or right-only stereo to mono](#from-left-or-right-only-stereo-to-mono)
   * [Normalize/Boost audio](#normalize-boost-audio)
   * [Convert Images into a Video](#convert-images-into-a-video)
   * [Adding sound wave overlays to videos and pictures](#adding-sound-wave-overlays-to-videos-and-pictures) (Source: [Christian Heilmann](https://christianheilmann.com/2023/08/31/adding-sound-wave-overlays-to-videos-and-pictures-using-ffmpeg/))

[![](./assets/The.Code.FFMpeg.Scene.jpg)](https://www.youtube.com/embed/lsCrY2vWSr8?si=uir7ltKSuvi6YdJ3&amp;start=205&end=290)

[_(FFMpeg in the movies)_](https://www.youtube.com/embed/lsCrY2vWSr8?si=uir7ltKSuvi6YdJ3&amp;start=205&end=290)

---

<details>

<summary><h2>Get Video Information</h2></summary>

`$ ffmpeg -i filename.flv`

`$ ffmpeg -ao dummy -vo dummy -identify filename.flv`

`$ ffprobe -hide_banner -stats -i toggle-custom-post-types.mp4`

GET SPECIFIC INFORMATION:

`$ ffprobe -v error -select_streams v:0 -show_entries stream=codec_name -of default=nokey=1:noprint_wrappers=1 input.mp4` 

Will output: `h264`

`ffprobe -v error -select_streams v:0 -show_entries stream=width -of default=nokey=1:noprint_wrappers=1 toggle-custom-post-types.mp4`

Will output: `1280`

Other stream keys include: 

  codec_name=h264
  codec_long_name=H.264 / AVC / MPEG-4 AVC / MPEG-4 part 10
  width=1280
  height=772
  r_frame_rate=8/1

**References:** 

[Is there a way to use ffmpeg to determine the encoding of a file before transcoding?](https://stackoverflow.com/questions/5618363/is-there-a-way-to-use-ffmpeg-to-determine-the-encoding-of-a-file-before-transcod)

</details>

<details>

<summary><h2>Grab Frame Thumbnail</h2></summary>

`$ ffmpeg -i input.mov -vframes 1 -s 320x240 -ss 10 thumb.jpg`

-vframes  *Single Frame*<br/>
-ss       *Offset*

`$ ffmpeg -i rtmp://streamurl -r 1 frames/%04d-frame.png`

This will consume the stream at rtmp://streamurl and output it as one PNG per second.

</details>

<details>
<summary><h2>Add Audio Track</h2></summary>

`$ ffmpeg.exe -i input.flv -i input.audio.m4a -vcodec copy -acodec copy -map 0:0 -map 1:0 output.flv`

</details>

<details>
<summary><h2>Format Conversion</h2></summary>

  AAC to WAV

  `$ ffmpeg -i input.aac output.wav`

  FLV to MPEG4
  
  `$ ffmpeg -i input.flv -acodec copy output.mp4`

</details>

<details>
<summary><h2>Convert Video to MP3</h2></summary>

MP3 Quality => 320k 

`$ ffmpeg -i video.flv -ab 320k output.mp3`

`$ ffmpeg -i video.avi -f mp3 audio.mp3`

-f <fmt> *Force the format*

</details>

<details>
<summary><h2>Join / Concatenate MP3 Files</h2></summary>

`$ ffmpeg -i "concat:file1.mp3|file2.mp3" -acodec copy output.mp3`

</details>

<details>
<summary><h2>Join / Concatenate Video Files</h2></summary>

USING concat VIDEO FILTER (Performs re-encoding. Problem when dealing with videos of different resolution)

`$ ffmpeg -i opening.mp4 -i content.mp4 -i ending.mp4 -filter_complex "[0:v] [0:a] [1:v] [1:a] [2:v] [2:a] concat=n=3:v=1:a=1 [v] [a]" -map "[v]" -map "[a]" output.mp4`

  Use if your inputs do not have the same parameters (width, height, etc), or are not the same formats/codecs, or if you want to perform any filtering. (You could re-encode just the inputs that don't match so they share the same codec and other parameters, then use the concat demuxer to avoid re-encoding the other inputs).

USING concat DEMUXER ()

  $ cat mylist.txt
  file '/path/to/file1'
  file '/path/to/file2'
  file '/path/to/file3'

  $ ffmpeg -f concat -i mylist.txt -c copy output

  Use when you want to avoid a re-encode and your format does not support file level concatenation (most files used by general users do not support file level concatenation).

USING concat PROTOCOL

  $ ffmpeg -i "concat:input1|input2" -codec copy output

  This method does not work for many formats, including MP4, due to the nature of these formats and the simplistic concatenation performed by this method.

  Use with formats that support file level concatenation (MPEG-1, MPEG-2 PS, DV). Do not use with MP4.

Reference: [How to concatenate two MP4 files using FFmpeg?](https://stackoverflow.com/questions/7333232/how-to-concatenate-two-mp4-files-using-ffmpeg)

</details>

<details>
<summary><h2>Mix a Video with a Sound file</h2></summary>

`$ ffmpeg -i audio.wav -i video.avi output.mpg`

</details>

<details>
<summary><h2>Trim and Cut</h2></summary>

REMOVE LAST 30" FROM A VIDEO FILE

Note: Video is 130"

`ffmpeg -i input.mp4 -c:v copy -c:a copy -to 100 output.mp4`

REMOVE FIRST 30" FROM AN MP3 FILE

`$ ffmpeg -i input.mp3 -ss 30 -acodec copy output.mp3`

Or (using the -c shortcut):

`$ ffmpeg -i input.mp3 -ss 30 -c:a copy output.mp3`

KEEP FIRST 30" OF A VIDEO FILE

`$ ffmpeg -i input.mkv -t 30 -acodec copy -vcodec copy output.mkv`

KEEP FIRST 30" OF AN MP3 FILE

-t 30 *Keep only first 30 seconds*

`$ ffmpeg -i input.mp3 -t 30 -acodec copy output.mp3`

TRIM USING START AND END POSITION

`$ ffmpeg -i input.mp4 -ss 00:00:03.000 -to 00:00:11.000 -c copy output.mp4`

-ss and -to *Using start and end position*

General Syntax: 
`$ ffmpeg -i [input file] -ss hh:mm:ss[.xxx] -t [duration in seconds or 
hh:mm:ss[.xxx]] -vcodec copy -acodec copy [output file]`

</details>

<details>
<summary><h2>Resizing Video</h2></summary>

`$ ffmpeg -i input.avi -vf scale=320:240 output.avi`

Reference: [Scaling](https://trac.ffmpeg.org/wiki/Scaling)

</details>

<details>
<summary><h2>Capture Video</h2></summary>

[Linux]

`$ ffmpeg -f x11grab -s wxga -r 25 -i :0.0 -sameq /tmp/output.mpg`

</details>
 
<details>
<summary><h2>Crop Video</h2></summary>

`$ ffmpeg -i input.mp4 -filter:v "crop=out_w:out_h:x:y" out.mp4`

For parameters out_w, out_h, x and y see [this SO answer](https://video.stackexchange.com/a/4571/42182)

</details>

<details>
<summary><h2>Export Audio</h2></summary>

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

</details>

<details>
<summary><h2>Show Video Information as JSON</h2></summary>

`$ ffprobe -v quiet -print_format json -show_format -show_streams somefile.asf` 

</details>

<details>
<summary><h2>Encode Video Portion</h2></summary>

`$ ffmpeg -i move.avi -ss <StartTime> -t <Duration> OutPutFile.avi`

</details>

<details>
<summary><h2>Replace Audio in a Video File</h2></summary>

`$ ffmpeg -i video.avi -i audio.mp3  -map 0.0:1 -map 1:0 -f avi -vcodec copy -acodec copy output.avi`

</details>

<details>
<summary><h2>Audio Slow Down</h2></summary>

`$ ffmpeg -i input.mp4 -filter:a "atempo=0.5" -vn output.aac`

</details>

<details>
<summary><h2>Create a Video with Audio from an Image Still</h2></summary>

Given an image and an audio file, creates a video which is basically a still from the image with the audio file in the background.

The 66 below represents the length of the audio in seconds. 

CREATE A 66" VIDEO FROM THE IMAGE

```$ cat `for i in $(seq 1 66); do echo -n " black_still.jpg "; done;` | ffmpeg -r 1 -f mjpeg -i - -r 1 out1.mp4```

TRIM THE MP3 FILE TO KEEP THE FIRST 66" OF AUDIO

`$ ffmpeg -i audio.mp3 -t 66 -acodec copy output.mp3`

MIX AUDIO AND VIDEO

`$ ffmpeg -i out1.mp4 -i output.mp3 -vcodec copy finish.mp4`

</details>

<details>
<summary><h2>Extract Images from a Video</h2></summary>

`$ ffmpeg -i input.mpg image%d.jpg`

This will create 25 images for every 1 second, but it may serve us to have more or less images, this can be achieved with the parameter -r

-r fps *Set frame rate (default 25)*

`$ ffmpeg -i test.mpg -r 1 image%d.jpg`

With this command you’ll get 1 image for every second.

You can also give a start time and the duration with the flags:

-ss position Seek to given time position in seconds. “hh:mm:ss[.xxx]” syntax is also supported.

-t duration Restrict the transcoded/captured video sequence to the duration specified in seconds. “hh:mm:ss[.xxx]” syntax is also supported.

This command will take 25 images images every second beginning at the tenth second, and continuing for 5 seconds

`$ ffmpeg -i test.mpg -r 25 -ss 00:00:10 -t 00:00:05 images%05d.png`

</details>

<details>
<summary><h2>Convert VIDEO_TS folder to video</h2></summary>

`$ cat ./VIDEO_TS/*.VOB | ffmpeg -i - <out_name>.<out_format>`

[References](https://askubuntu.com/questions/86320/how-to-convert-video-ts-folder-to-video-format)

</details>

<details>
<summary><h2>From left or right only stereo to mono</h2></summary>

`ffmpeg -i INPUT.mp4 -c:v copy -ac 1 OUTPUT.mp4`

[References](https://www.youtube.com/watch?v=IyQD6mYqrYA)

</details>

<details>
<summary><h2>Normalize (boost) audio</h2></summary>

VIDEO: `ffmpeg -i original.mov -af "volume=18dB" -c:v copy -c:a aac -b:a 192k normalized.mov`

**Important:** watch out for the typos, e.g. `18db` will fail, since the correct syntax is `18dB` (uppercase B). 

We also have created a handy shell (zsh) script that will normalize a file like this:

```bash
normalize file.mov
# Will create a file file.normalized.mov, normalized at 16dB (default)
normalize --db 12 movie.mp4
# Will create a file movie.normalized.mp4, normalized at 12dB
```

You can find the file here: [./scripts/normalize.sh](./scripts/normalize.sh)

[References](https://superuser.com/questions/323119/how-can-i-normalize-audio-using-ffmpeg)

</details>

<details>
<summary><h2>Convert Images into a Video</h2></summary>

Suppose you have images in the format: `frame01.jpg`, `frame02.jpg`, `frame03.jpg`, etc.

`ffmpeg -f image2 -i frame%d.jpg output.mp4`

</details>

<details>
<summary><h2>Adding Sound Wave Overlays to Videos and Pictures</h2></summary>

Adding sound wave overlay to a video:

`ffmpeg -i Understandable.mp4 \
-filter_complex "[0:a]showwaves=colors=0xff1646@0.3\
:scale=sqrt:mode=cline,format=yuva420p[v];\
[v]scale=1280:400[bg];\
[v][bg]overlay=(W-w)/2:H-h[outv]"\
-map "[outv]" -map 0:a -c:v libx264 -c:a copy \
waveform-sqrt-cline.mp4`

You can find a detailed explanation for each of the parameters [here](https://christianheilmann.com/2023/08/31/adding-sound-wave-overlays-to-videos-and-pictures-using-ffmpeg/).

Adding sound wave overlay to a picture:

`ffmpeg -i Understandable.mp4  -i chris.jpg\
-filter_complex "[0:a]showwaves=colors=0xff1646@0.3\
:scale=sqrt:mode=cline,format=yuva420p[v];\
[1:v]scale=400:400[bg];\
[bg][v]overlay=(W-w)/2:(H-h)/2[outv]"\
-map "[outv]" -map 0:a -c:v libx264 -c:a copy \
static-image.mp4`

</details>

---

TODO
====

- Add entry about detecting the volume. Based on [this post](https://creatomate.com/blog/how-to-change-the-volume-of-a-media-file-using-ffmpeg) 

---

If you found this resource useful, please consider [supporting our cause](https://ko-fi.com/intechgration).

For more information [visit our website](https://intechgration.io/).
