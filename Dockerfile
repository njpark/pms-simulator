FROM node:12-alpine

RUN addgroup -g 1001 pms
RUN adduser -u 1001 -G pms -h /home/pms -D pms
#RUN addgroup -g 1001 pms \
#  && adduser --uid 1001 --gid pms --shell /bin/bash --create-home pms

#Create pms directories
RUN mkdir -p /home/pms/app 

#Set run environment and user
WORKDIR /home/pms/app
RUN chown pms:pms -R /home/pms
USER pms

#Install dependencies, build and remove rest
COPY pms.tar.gz /home/pms/app
RUN tar -xvf pms.tar.gz \
  && yarn install --only=production \
  && npm run init \
  && rm pms.tar.gz

EXPOSE 9890

ENTRYPOINT ["/usr/local/bin/npm", "run", "app"]
