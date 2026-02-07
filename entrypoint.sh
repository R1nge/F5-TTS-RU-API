#!/bin/bash
set -e

# Optional: if HUGGINGFACE_HUB_TOKEN provided, configure
if [ -n "${HUGGINGFACE_HUB_TOKEN}" ]; then
  mkdir -p /root/.huggingface
  echo -n "${HUGGINGFACE_HUB_TOKEN}" > /root/.huggingface/token
  export HUGGINGFACE_HUB_TOKEN="${HUGGINGFACE_HUB_TOKEN}"
  export HF_TOKEN="${HUGGINGFACE_HUB_TOKEN}"
fi


# create data folders
mkdir -p /data/input /data/output /data/voices

# --- Автоматическая загрузка модели и копирование yaml-конфига ---


#MODEL_REPO="Misha24-10/F5-TTS_RUSSIAN"
#MODEL_CACHE="/root/.cache/huggingface/hub"
# Скачиваем модель, если не скачана
#python3 -u -c "from huggingface_hub import snapshot_download; snapshot_download(repo_id='${MODEL_REPO}', cache_dir='${MODEL_CACHE}', allow_patterns=['F5TTS_v1_Base/*','F5TTS_v1_Base_v2/*'], local_dir_use_symlinks=False)"
#python3 -u -c "from ruaccent import RUAccent; accentizer = RUAccent(); accentizer.download()"
# run the API
exec uvicorn app:app --host 0.0.0.0 --port ${PORT:-4123} --workers 1
