FROM rootproject/root:6.26.10-conda

WORKDIR /analysis

RUN apt-get update && \
    apt-get install -y \
    build-essential \
    python3-pip \
    wget \
    git \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN pip3 install --no-cache-dir \
    numpy \
    matplotlib \
    scipy \
    pandas

COPY . /analysis/

RUN if [ -f skim.cxx ]; then \
    COMPILER=$(root-config --cxx) && \
    FLAGS=$(root-config --cflags --libs) && \
    $COMPILER -g -O3 -Wall -Wextra -Wpedantic -o skim skim.cxx $FLAGS; \
    fi
    
RUN chmod +x *.sh

WORKDIR /analysis

CMD ["/bin/bash"]
