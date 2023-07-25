# Use the image base-notebook to build our image on top of it
FROM python:3.10.9-slim

# Change to root user
USER root

# Set Environment to ignore sudo warning for pip
ENV PIP_ROOT_USER_ACTION=ignore

# Copy data from the current directory into the docker image
COPY . /app

# Set Workdir
WORKDIR /app

# Install package requirements
RUN pip3 install --upgrade pip
#RUN apt-get update && apt-get install -y ffmpeg libsm6 libxext6 pkg-config build-essential && apt-get clean

# Install Python dependencies from requirements.txt
RUN pip3 install -r requirements.txt

# Expose the Gradio server port
EXPOSE 7860

# Set the environment variable for Gradio
ENV GRADIO_SERVER_NAME 0.0.0.0
ENV NVIDIA_VISIBLE_DEVICES=all

# Set the command to run the app
CMD python -u app.py --listen 0.0.0.0 --server_port 7860
