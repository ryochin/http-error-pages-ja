FROM debian:buster-slim

ENV APP_DIR /app
WORKDIR $APP_DIR

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get install -y --no-install-recommends \
  build-essential libssl-dev ca-certificates curl \
  && apt-get clean

RUN curl -L https://cpanmin.us | /usr/bin/perl - App::cpanminus \
  && /usr/local/bin/cpanm --notest Carton

COPY cpanfile $APP_DIR
COPY cpanfile.snapshot $APP_DIR

RUN /usr/local/bin/carton install --deployment \
  && rm -rf /root/.cpanm/

COPY . $APP_DIR

EXPOSE 10080

CMD ["/usr/local/bin/carton", "exec", "perl", "local/bin/plackup", "--port", "10080", "server.psgi"]
