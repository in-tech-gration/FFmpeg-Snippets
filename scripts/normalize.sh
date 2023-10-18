#!/bin/zsh

function normalize(){

  dB="16"
  input=""
  arg_count=$#
    
  case "$arg_count" in
    1)
      echo "No --db argument passed. Normalizing $1 at $dB"
      input="$1"
      ;;
    2)
      echo "Invalid number of arguments."
      return 1;
      ;;
    3)
      echo "Three arguments are passed: $1, $2, and $3"
      if [ "$1" == "--db" ]; then
        dB="$2"
        input="$3"
        echo "Normalizing at $dB"
      else
        dB="$3"
        input="$1"
        echo "Normalizing at $dB"
      fi
      ;;
    *)
      echo "Invalid number of arguments."
      return 1;
      ;;
  esac

  cmd="ffmpeg -i $input -af \"volume="$dB"dB\" -c:v copy -c:a aac -b:a 192k ${input%.*}.normalized.${input##*.}"

  echo $cmd
  eval "$cmd"

}