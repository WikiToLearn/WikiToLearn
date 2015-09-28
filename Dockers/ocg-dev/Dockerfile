FROM wikifm/ocg
MAINTAINER wikitolearn sysadmin@wikitolearn.org

RUN rm /var/lib/ocg/* -Rf
ADD mw-ocg/mw-ocg-service /var/lib/ocg/
ADD mw-ocg/mw-ocg-bundler /var/lib/ocg/
ADD mw-ocg/mw-ocg-latexer /var/lib/ocg/
ADD mw-ocg/mw-ocg-texter /var/lib/ocg/
WORKDIR /var/lib/ocg/mw-ocg-service
RUN npm install
WORKDIR /var/lib/ocg/mw-ocg-bundler
RUN npm install
WORKDIR /var/lib/ocg/mw-ocg-latexer
RUN npm install
WORKDIR /var/lib/ocg/mw-ocg-texter
RUN npm install
