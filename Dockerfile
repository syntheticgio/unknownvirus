FROM ubuntu:22.04

RUN apt -y -qq update && apt install -y wget

RUN wget https://ftp-trace.ncbi.nlm.nih.gov/sra/sdk/3.0.7/sratoolkit.3.0.7-ubuntu64.tar.gz
RUN tar zxvf sratoolkit.3.0.7-ubuntu64.tar.gz
RUN cp sratoolkit.3.0.7-ubuntu64.tar.gz/bin/*.*

RUN ln -s /usr/local/bin/prefetch.3.0.7 /usr/local/bin/prefetch


WORKDIR /bioinformatics_class/

CMD bash
