FROM nvidia/cuda:12.2.0-runtime-ubuntu20.04

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1


# Install nessesary packages
# TODO: @Chris see https://grigorkh.medium.com/fix-tzdata-hangs-docker-image-build-cdb52cc3360d
ENV TZ=Europe/Berlin
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    build-essential \
    ffmpeg \
    git \
    python3-pip \
    sudo && \
    apt-get clean

RUN pip install --no-cache-dir --upgrade pip

# CUDA 11.8
RUN pip install torch==2.0.0+cu118 torchvision==0.15.1+cu118 torchaudio==2.0.1 --index-url https://download.pytorch.org/whl/cu118

# Clone the repository
#WORKDIR /workspace/audiocraft
RUN cd home && git clone -b v1.0 https://github.com/camenduru/audiocraft

# # Install Python dependencies from requirements.txt
RUN pip3 install -r /home/audiocraft/requirements.txt

# Expose the Gradio server port
EXPOSE 7860

# Set the environment variable for Gradio
ENV GRADIO_SERVER_NAME 0.0.0.0
ENV NVIDIA_VISIBLE_DEVICES=all

# Set the command to run the app
CMD cd /home/audiocraft && python3 -u app.py --listen 0.0.0.0 --server_port 7863
