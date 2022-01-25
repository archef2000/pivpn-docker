FROM debian:stretch-20211011
RUN mkdir /old
COPY run /old/run
RUN chmod +x /old/run
WORKDIR /old
CMD ["bash" "run"]  
