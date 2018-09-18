
FROM node:slim

RUN apt-get update && apt-get install git python make g++ -y \
  && rm -rf /var/lib/apt/lists/*

RUN cd / && git clone https://github.com/Curvytron/curvytron.git

ENV app_dir /curvytron
WORKDIR ${app_dir}

RUN npm install gulp -g \
  && npm install bower -g \
  && npm install \
  && bower install --allow-root \
  && npm cache clear

RUN gulp

RUN apt-get --purge git make && apt-get autoclean && apt-get clean

EXPOSE 8080
CMD node bin/curvytron.js
