FROM python:3.10-slim as builder

WORKDIR /home/epic

COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

RUN apt update -y \
    && apt install -y wget

COPY src ./

RUN wget -P model/ https://github.com/QIN2DIM/hcaptcha-challenger/releases/download/model/yolov5n6.onnx \
    && wget -P model/ https://github.com/QIN2DIM/hcaptcha-challenger/releases/download/model/rainbow.yaml \
    && wget -P model/ https://github.com/QIN2DIM/hcaptcha-challenger/releases/download/model/elephants_drawn_with_leaves.onnx \
    && wget -P model/ https://github.com/QIN2DIM/hcaptcha-challenger/releases/download/model/seaplane.onnx

ARG CHROME_VERSION="100.0.4896.127-1"
RUN wget --no-verbose -O /tmp/chrome.deb https://dl.google.com/linux/chrome/deb/pool/main/g/google-chrome-stable/google-chrome-stable_${CHROME_VERSION}_amd64.deb \
  && apt install -y /tmp/chrome.deb \
  && rm /tmp/chrome.deb

# docker pull ech0sec/awesome-epic:mami && docker image prune && docker-compose up