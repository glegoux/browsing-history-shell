# Dockerfile browsing-history-shell
FROM ubuntu:14.04
MAINTAINER Gilles Legoux <gilles.legoux@gmail.com>

# environment variable
ENV BHIST_USER user
ENV BHIST_HOME /home/$BHIST_USER
ENV BHIST_FILENAME .bashrc_bhist
ENV BHIST_ALIAS_FILENAME .bash_aliases_bhist

# build environment
RUN adduser --disabled-password --gecos "" $BHIST_USER
COPY $BHIST_FILENAME $BHIST_HOME/$BHIST_FILENAME
RUN chown $BHIST_USER:$BHIST_USER $BHIST_HOME/$BHIST_FILENAME
COPY $BHIST_ALIAS_FILENAME $BHIST_HOME/$BHIST_ALIAS_FILENAME
RUN chown $BHIST_USER:$BHIST_USER $BHIST_HOME/$BHIST_ALIAS_FILENAME
RUN echo "\n" \
  "# enable browsing history\n" \
  "if [ -f ~/$BHIST_FILENAME ]; then\n" \
  "  . ~/$BHIST_FILENAME\n" \
  "fi\n" \
  "\n" \
  "# enable browsing history shell\n" \
  "if [ -f ~/$BHIST_ALIAS_FILENAME ]; then\n" \
  "  . ~/$BHIST_ALIAS_FILENAME\n" \
  "fi\n" >> $BHIST_HOME/.bashrc
