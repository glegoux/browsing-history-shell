# Dockerfile browsing-history-shell
FROM ubuntu:14.04
MAINTAINER Gilles Legoux <gilles.legoux@gmail.com>

# environment variable
ENV TEST test

# build environment
RUN adduser --disabled-password --gecos "" user
COPY .bashrc_browsing_history /home/user/.bashrc_browsing_history
RUN chown user:user /home/user/.bashrc_browsing_history
RUN echo "\n" \
  "# enable browsing history shell\n" \
  "if [ -f ~/.bashrc_browsing_history ]; then\n" \
  "  . ~/.bashrc_browsing_history\n" \
  "fi\n" >> /home/user/.bashrc

# define connection condition to container
# USER user
