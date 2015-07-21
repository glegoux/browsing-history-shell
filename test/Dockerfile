# Dockerfile browsing-history-shell
FROM ubuntu:14.04
MAINTAINER Gilles Legoux <gilles.legoux@gmail.com>

# environment variable
ENV USER user
ENV HOME /home/$USER
ENV BHIST_FILE .bashrc_bhist
ENV BHIST_ALIAS_FILE .bash_aliases_bhist

# build environment
RUN adduser --disabled-password --gecos "" user
COPY $BHIST_FILE $HOME/$BHIST_FILE
RUN chown user:user $HOME/$BHIST_FILE
COPY $BHIST_ALIAS_FILE $HOME/$BHIST_ALIAS_FILE
RUN chown user:user $HOME/$BHIST_ALIAS_FILE
RUN echo "\n" \
  "# enable browsing history\n" \
  "if [ -f ~/$BHIST_FILE ]; then\n" \
  "  . ~/$BHIST_FILE\n" \
  "fi\n" \
  "\n" \
  "# enable browsing history shell\n" \
  "if [ -f ~/$BHIST_ALIAS_FILE ]; then\n" \
  "  . ~/$BHIST_ALIAS_FILE\n" \
  "fi\n" >> /home/user/.bashrc
