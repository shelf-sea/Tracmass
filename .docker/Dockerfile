# base image
ARG BASE_CONTAINER=ubuntu:20.04
FROM $BASE_CONTAINER
LABEL "maintainer"="ezra.eisbrenner@gmail.com"
LABEL "author"="Ezra Eisbrenner"
LABEL "version"="2021.1"

# set up the system
# mostly Tracmass dependencies
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update \
    && apt-get install -yq --no-install-recommends \
    build-essential \
    gcc \
    gfortran \
    make \
    locales \
    libnetcdf-dev \
    libnetcdff-dev \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Configure environment
RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && \
    locale-gen
ENV SHELL=/bin/bash \
    LC_ALL=en_US.UTF-8 \
    LANG=en_US.UTF-8 \
    LANGUAGE=en_US.UTF-8

RUN mkdir /Tracmass && \
    mkdir /input && \
    mkdir /output
ENV HOME=/Tracmass
WORKDIR /Tracmass

# build TRACMASS
ARG PROJECT=Theoretical
ARG CASE=Theoretical
COPY ./src /Tracmass/src
COPY ./projects/${PROJECT} /Tracmass/projects/${PROJECT}
COPY ./Makefile /Tracmass/Makefile

RUN sed -i "s/^\s*PROJECT\s*=.*/PROJECT=${PROJECT}/g" /Tracmass/Makefile && \
    sed -i "s/^\s*CASE\s*=.*/CASE=${CASE}/g" /Tracmass/Makefile

RUN cd /Tracmass && \
    make --file=Makefile

RUN cp /Tracmass/projects/${PROJECT}/seedfile_${CASE}.txt /Tracmass/seedfile.txt && \
    sed -i "s!^\s*seedfile\s*=.*!seedfile='seedfile.txt'!g" /Tracmass/namelist.in && \
    sed -i "s!^\s*physDataDir\s*=.*!physDataDir='/input/',!g" /Tracmass/namelist.in && \
    sed -i "s!^\s*outDataDir\s*=.*!outDataDir='/output/',!g" /Tracmass/namelist.in

CMD [ "./runtracmass" ]
