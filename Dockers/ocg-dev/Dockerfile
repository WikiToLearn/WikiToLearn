FROM wikitolearn/ocg-dev-base:0.1
MAINTAINER wikitolearn sysadmin@wikitolearn.org
ENV DEBIAN_FRONTEND noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN true

ADD ./install_ocg.sh /root/
ADD mw-ocg-full/mw-ocg-latexer/ /var/lib/ocg/mw-ocg-latexer/

RUN /bin/chmod +x /root/install_ocg.sh
RUN /root/install_ocg.sh
RUN rm /root/install_ocg.sh

ADD ./run_ocg.sh /root/
RUN chmod +x /root/run_ocg.sh

CMD ["/root/run_ocg.sh"]
