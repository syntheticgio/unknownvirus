FROM ubuntu:22.04

# apt is a repository manager (think of an app store, but everything is free).  We are going to run two commands here
# The first is to update the repository list.  This is so we know all the different programs that are available to download.
# The -qq flag stops the program from adding a lot of output to the screen.  This is purely for visual reasons and is
# typical in a docker build.
RUN apt -qq update

# The second is that we are going to install a program called WGET along with the git program.
# Normally when you run it asks you if you're sure - the -y automatically answers that with yes. This is normally just a nice
# to have, but in a docker build it is essential since you're not able to interact with the build process as it is running.
RUN apt install -y wget git build-essential zlib1g-dev

# Download the SRA Toolkit tools.  The download page can be found at https://github.com/ncbi/sra-tools/wiki/02.-Installing-SRA-Toolkit
# WGET is a tool that can download a file given a link to the file
RUN wget https://ftp-trace.ncbi.nlm.nih.gov/sra/sdk/3.0.7/sratoolkit.3.0.7-ubuntu64.tar.gz

# A tar package (.tar part of the extension) is an archive (i.e. a bunch of files bundled together).  The gzip (.gz) part of the extension
# is the compression of these files bundled together.  This is similar to a ZIP file which you may be more familiar with.  ZIP does both the
# archiving and the compression together.
# tar zxvf can be used to un-archive AND uncompress a file in a single step.
RUN tar zxvf sratoolkit.3.0.7-ubuntu64.tar.gz

RUN git clone https://github.com/najoshi/sickle.git
WORKDIR /sickle/
RUN make

# Since we downloaded the binaries, we will need to add the binaries' directory to our PATH variable.
# The PATH variable specifies where the operating system will look when you type a command on the command line.
# If the command executable exists in any of the directories specified in the PATH variable, it will be able to
# execute from anywhere in the system.
ENV PATH="${PATH}:/sratoolkit.3.0.7-ubuntu64.tar.gz/bin:/sickle"

# Going to set our working directory as /bioinformatics_class/
WORKDIR /bioinformatics_class/

CMD bash
