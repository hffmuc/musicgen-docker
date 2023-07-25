FROM nvcr.io/nvidia/pytorch:23.06-py3

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1


# Install nessesary packages
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    build-essential \
    ffmpeg \
    git \
    python-is-python3 \
    python3.10-dev \
    python3-pip \
    sudo && \
    apt-get clean

RUN pip install --no-cache-dir --upgrade pip


# Clone the repository
RUN git clone -b v1.0 https://github.com/camenduru/audiocraft

WORKDIR /workspace/audiocraft


RUN pip3 install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu118

# # Install Python dependencies from requirements.txt
RUN pip3 install -r requirements.txt


# Expose the Gradio server port
EXPOSE 7860

# Set the environment variable for Gradio
ENV GRADIO_SERVER_NAME 0.0.0.0
ENV NVIDIA_VISIBLE_DEVICES=all

# Set the command to run the app
CMD python -u app.py --listen 0.0.0.0 --server_port 7860
