FROM debian:bookworm-slim

## MATLAB variables
ENV MCR_VERSION R2024b
ENV MCRROOT /opt/mcr/${MCR_VERSION}
ENV INSTALLER  https://ssd.mathworks.com/supportfiles/downloads/${MCR_VERSION}/Release/0/deployment_files/installer/complete/glnxa64/MATLAB_Runtime_${MCR_VERSION}_glnxa64.zip

RUN apt-get -y update
RUN apt-get install -y wget unzip libxt6
RUN mkdir -p /mcr-install \
  && mkdir -p /opt/mcr \
  && wget -O /mcr-install/mcr.zip ${INSTALLER} \
  && cd /mcr-install \
  && unzip mcr.zip \
  && ./install -destinationFolder /opt/mcr -agreeToLicense yes -mode silent \
  && cd / \
  && rm -rf mcr-install \
  && test -e /usr/bin/ldd && ldd --version | grep -q '(Debian GLIBC 2.36-9+deb12u9)' 
## Set the current directory to /challenge
RUN mkdir /challenge
COPY . /challenge
WORKDIR /challenge

## This environment variable is necessary for the MCR
ENV LD_LIBRARY_PATH ${LD_LIBRARY_PATH}:/opt/mcr/${MCR_VERSION}/runtime/glnxa64:/opt/mcr/${MCR_VERSION}/bin/glnxa64:/opt/mcr/${MCR_VERSION}/sys/os/glnxa64:/opt/mcr/${MCR_VERSION}/extern/bin/glnxa64
