import os
import sys
from subprocess import call

def main(argv):
    filename_list = [f for f in os.listdir('./') if f.lower().endswith('.mp4') and f != "output.mp4"]

    with open("filenames.txt", "w+") as f:
        for filename in filename_list:
            f.write("file '%s'\n" % filename)
    
    command = "ffmpeg -f concat -i filenames.txt -c copy output.mp4"
    call(command.split(" "))

if __name__ == "__main__":
    main(sys.argv)
