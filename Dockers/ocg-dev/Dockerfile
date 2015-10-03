FROM wikifm/ocg
MAINTAINER wikitolearn sysadmin@wikitolearn.org

RUN rm /var/lib/ocg/* -Rf
ADD mw-ocg/ /var/lib/ocg/
WORKDIR /var/lib/ocg/mw-ocg-service
RUN npm install
WORKDIR /var/lib/ocg/mw-ocg-bundler
RUN npm install
WORKDIR /var/lib/ocg/mw-ocg-latexer
RUN npm install
WORKDIR /var/lib/ocg/mw-ocg-texter
RUN npm install
