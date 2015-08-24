# BUILD-USING: docker build -t motion-mr-dave .
# RUN-USING: docker run --name motion-mr-dave motion-mr-dave
FROM debian:jessie
MAINTAINER Sugree Phatanapherom, sugree@gmail.com

RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y git build-essential

RUN mkdir -p /tmp/build

RUN cd /tmp/build && \
    git clone git://git.videolan.org/x264.git

RUN cd /tmp/build && \
    git clone git://source.ffmpeg.org/ffmpeg.git

RUN cd /tmp/build && \
    git clone https://github.com/Mr-Dave/motion.git

RUN apt-get install -y --force-yes \
    yasm
RUN cd /tmp/build/x264 && \
    ./configure --enable-shared --disable-opencl && \
    make && \
    make install && \
    ldconfig

RUN apt-get install -y --force-yes \
    libass-dev \
    libfreetype6-dev \
    libjpeg-dev \
    libtheora-dev \
    libvorbis-dev \
    zlib1g-dev \
    libmp3lame-dev
RUN cd /tmp/build/ffmpeg && \
    ./configure --enable-gpl \
                --enable-nonfree \
                --enable-shared \
                --enable-libass \
                --enable-libfreetype \
                --enable-libmp3lame \
                --enable-libtheora \
                --enable-libvorbis \
                --enable-libx264 && \
    make && \
    make install && \
    ldconfig

RUN cd /tmp/build/motion && \
    ./configure && \
    make && \
    make install && \
    ldconfig

ADD start_motion.sh /usr/local/bin/start_motion.sh

RUN mkdir -p /data1/config /data1/storage/main /data1/tmp

VOLUME ["/data1/config"]
VOLUME ["/data1/storage"]
VOLUME ["/data1/tmp"]
WORKDIR /data1/tmp
    
EXPOSE 8080 8081

CMD ["/usr/local/bin/start_motion.sh"]
