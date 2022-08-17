FROM rocker/verse:4.2

RUN apt update -qq -y

RUN apt install -y software-properties-common dirmngr libcurl4-openssl-dev \
    libssl-dev libssh2-1-dev libxml2-dev zlib1g-dev make git-core \
    libcurl4-openssl-dev libxml2-dev libpq-dev cmake \
    r-base r-base-dev libsodium-dev libsasl2-dev npm

RUN npm install -g sass


RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
RUN unzip awscliv2.zip
RUN ./aws/install

RUN R -e "install.packages(c('renv'))"

ENV LC_ALL C.UTF-8
ENV LANG C.UTF-8

WORKDIR /app/

COPY renv.lock .
RUN R -e "renv::restore()"

