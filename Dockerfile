FROM rootproject/root:6.26.10-conda

# Set working directory
WORKDIR /analysis

# Install system dependencies
RUN apt-get update && \
    apt-get install -y \
    build-essential \
    python3-pip \
    wget \
    git \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install any Python dependencies
RUN pip3 install --no-cache-dir \
    numpy \
    matplotlib \
    scipy \
    pandas

# Copy analysis scripts and code
COPY skim.sh histograms.sh plot.sh fit.sh ./
COPY src/ /analysis/src/

# Make scripts executable
RUN chmod +x *.sh

# Set default working directory
WORKDIR /analysis

# Optional: set default command
CMD ["/bin/bash"]
