# =============================
# ビルドコマンド:
# docker build -t comfyui .
#
# =============================

FROM pytorch/pytorch:2.2.0-cuda12.1-cudnn8-runtime

WORKDIR /app

# よく使うツール・エディタ・ダウンロード系・OpenCV依存ライブラリをまとめてインストール
RUN apt-get update && apt-get install -y \
    git wget curl unzip zip vim nano \
    libgl1-mesa-dev libglib2.0-0 \
    && rm -rf /var/lib/apt/lists/*

# Pythonツールのアップグレード
RUN pip install --upgrade pip setuptools wheel

COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

EXPOSE 8188

CMD ["python", "main.py", "--listen", "0.0.0.0"]