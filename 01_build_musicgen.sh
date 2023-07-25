# This script is used to load the docker image and run the container
git clone -b v1.0 https://github.com/camenduru/audiocraft

# Copy the dockerfile to the audiocraft folder
cp dockerfile audiocraft/dockerfile

# cd into the audiocraft folder
cd audiocraft

# Build the docker image
docker build -t musicgen .
