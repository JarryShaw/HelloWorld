# basic info
FROM ubuntu:16.04
LABEL description "HelloWrold"

# echo statement
RUN echo "Across the Great Wall, we can reach every corner in the world."

# set up environment
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y \
        build-essential \
        git \
        python \
        python3 \
        python-pip \
        python3-pip \
        libpython-dev \
        libpython3-dev \
        wget
RUN wget https://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb && \
    dpkg -i erlang-solutions_1.0_all.deb && \
    apt-get update && \
    apt-get install -y esl-erlang && \
    apt-get install -y elixir

# clone repository
RUN git clone --recurse-submodules https://github.com/JarryShaw/HelloWrold.git
