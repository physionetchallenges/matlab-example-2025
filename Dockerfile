FROM rockylinux:8

## Update packages from dnf
RUN dnf -y update

## Install Python 3.9
RUN dnf install -y python39 \
    && unlink /usr/bin/python || echo "No existing python link" \
    && ln -s /usr/bin/python3.9 /usr/bin/python

## MATLAB variables
ENV MCR_VERSION R2024b
## ENV MCR_NUM     v913
ENV MCRROOT /opt/mcr/${MCR_VERSION}
ENV INSTALLER  https://ssd.mathworks.com/supportfiles/downloads/${MCR_VERSION}/Release/0/deployment_files/installer/complete/glnxa64/MATLAB_Runtime_${MCR_VERSION}_glnxa64.zip

## Install the MCR
RUN dnf install -y wget curl unzip which xorg-x11-utils xorg-x11-server-Xorg xorg-x11-server-common xorg-x11-xauth xorg-x11-xinit \
     && mkdir -p /mcr-install \
     && mkdir -p /opt/mcr \
     && wget  -O /mcr-install/mcr.zip ${INSTALLER} \
     && cd /mcr-install \
     && unzip mcr.zip \
     && ./install -destinationFolder /opt/mcr -agreeToLicense yes -mode silent \
     && cd / \
     && rm -rf mcr-install \
     && test -e /usr/bin/ldd && ldd --version | grep -q "(GNU libc) 2.28"

## Set the current directory to /challenge
RUN mkdir /challenge
COPY . /challenge
WORKDIR /challenge

## Install requirements.txt for ecg_image_kit
RUN python -m pip install --upgrade setuptools
RUN python -m pip install -r requirements.txt

## This environment variable is necessary for the MCR
ENV LD_LIBRARY_PATH ${LD_LIBRARY_PATH}:/opt/mcr/${MCR_VERSION}/runtime/glnxa64:/opt/mcr/${MCR_VERSION}/bin/glnxa64:/opt/mcr/${MCR_VERSION}/sys/os/glnxa64:/opt/mcr/${MCR_VERSION}/extern/bin/glnxa64
