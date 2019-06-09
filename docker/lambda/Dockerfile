FROM amazonlinux

WORKDIR /tmp

# install the dependencies.
RUN yum -y install gcc-c++ && yum -y install findutils tar zip gzip && \
    touch ~/.bashrc && chmod +x ~/.bashrc && \
    curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.5/install.sh | bash && \
    source ~/.bashrc && nvm install 8.10

# copy aws command.
COPY ./docker/lambda/cmd/thumbnail.sh /root/thumbnail.sh

# copy source code.
RUN mkdir -p /src && chmod -x /src
COPY ./src /src

WORKDIR /root
