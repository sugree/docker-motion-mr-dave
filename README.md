Mr-Dave's Motion in Docker
==========================

* Debian Jessie
* git://git.videolan.org/x264.git
* git://source.ffmpeg.org/ffmpeg.git
* https://github.com/Mr-Dave/motion.git

Volumes
-------

* /data1/config
* /data1/storage

Ports
-----

* 8080
* 8081

Environments
------------

* TIMEZONE

Example
-------

    docker run \
           -d \
           -e TIMEZONE="Asia/Bangkok" \
           --privileged \
           -v /dev/video0:/dev/video0 \
           -v /var/motion/config:/data1/config \
           -v /var/motion/storage:/data1/storage \
           --name motion \
           sugree/motion-mr-dave
