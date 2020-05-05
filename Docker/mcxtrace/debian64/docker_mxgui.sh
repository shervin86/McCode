#!bin/bash
containername="mcxtrace:1.5"
XSOCK=/tmp/.X11-unix

docker image build --tag $containername .

#a simple version with out xauth gynmastics
#docker run -u docker -ti -e DISPLAY=$DISPLAY -v $XSOCK:$XSOCK $containername /usr/bin/mxgui

#more sophisticated version which seem to work
XAUTH=/tmp/.docker.xauth
xauth nlist :0 | sed -e 's/^..../ffff/' | xauth -f $XAUTH nmerge -
docker run -u docker -ti -e DISPLAY=$DISPLAY -v $XSOCK:$XSOCK -v $XAUTH:$XAUTH -e XAUTHORITY=$XAUTH $containername /usr/bin/mxgui
