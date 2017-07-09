# Dockerfile
FROM ubuntu:16.04
MAINTAINER Gilles Legoux <gilles.legoux@gmail.com>

# environment variable
ENV BHIST_USER bhist_test
ENV BHIST_HOME /home/$BHIST_USER
ENV BHIST_FILENAME $BHIST_HOME/.bashrc_bhist

# build environment
RUN adduser --disabled-password --gecos "" $BHIST_USER
COPY .bashrc_bhist $BHIST_FILENAME
RUN chown $BHIST_USER:$BHIST_USER $BHIST_FILENAME
RUN echo "\n" \
  "# enable browsing history\n" \
  "if [ -f ~/$BHIST_FILENAME ]; then\n" \
  "  . ~/$BHIST_FILENAME\n" \
  "fi\n" \
  "\n" >> $BHIST_HOME/.bashrc
