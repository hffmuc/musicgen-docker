# Run the docker container
#docker run --gpus all --ipc=host --ulimit memlock=-1 --ulimit stack=67108864 -p 7861:7860 --rm musicgen
docker run --gpus all -p 7863:7863 musicgen