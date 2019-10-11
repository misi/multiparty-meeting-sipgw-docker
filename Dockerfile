FROM node:lts

# Args
ARG BASEDIR=/opt
ARG MM_SIPGW=sipgw
#ARG NODE_ENV=production
ARG NODE_ENV=development
ARG SERVER_DEBUG='*'

WORKDIR ${BASEDIR}


RUN \
  DEBIAN_FRONTEND=noninteractive \
      apt update && apt install --assume-yes --no-install-recommends \
            build-essential \
            git \
      \
      && rm -rf /var/lib/apt/lists/*

#Alpine
#RUN apk update && apk upgrade && \
#    apk add --no-cache git bash build-base python linux-headers

#checkout code
RUN git clone --single-branch --branch master https://github.com/misi/multiparty-meeting-sipgw ${MM_SIPGW}

WORKDIR ${BASEDIR}/${MM_SIPGW}

#install app dep
RUN yarn install 

# set app in producion mode/minified/.
ENV NODE_ENV ${NODE_ENV}

# Web PORTS
EXPOSE 80 443 

# SIP PORTS
EXPOSE 5060 5060/udp

EXPOSE 9022

## run server 
ENV DEBUG ${SERVER_DEBUG}

COPY docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
