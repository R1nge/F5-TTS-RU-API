# Dockerfile — build lightweight CPU image for F5-TTS + small API wrapper
FROM python:3.11-slim

ENV DEBIAN_FRONTEND=noninteractive
# system deps
RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    build-essential \
    ffmpeg \
    libsndfile1 \
    curl \
    wget \
    ca-certificates \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /app


# copy files
COPY requirements.txt /app/requirements.txt
COPY app.py /app/app.py
COPY entrypoint.sh /app/entrypoint.sh
COPY F5-TTS_RUSSIAN/F5TTS_v1_Base /app/
COPY F5-TTS_RUSSIAN/F5TTS_v1_Base_v2 /app/
COPY loli.wav /app/

RUN chmod +x /app/entrypoint.sh

# Python deps
RUN pip install --no-cache-dir -r /app/requirements.txt
RUN pip uninstall -y torchcodec
RUN pip install torchcodec 

# Ensure huggingface cache dir exists (models will be downloaded here)
VOLUME ["/root/.cache/huggingface", "/data"]

EXPOSE 4123

CMD ["bash", "/app/entrypoint.sh"]
