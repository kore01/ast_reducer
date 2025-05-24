FROM theosotr/sqlite3-test

# Set the working directory
#WORKDIR /usr/local/bin

WORKDIR /usr/bin

# Install dependencies (note: no need for sudo in Docker)
RUN sudo apt-get update && \
    sudo apt-get install -y \
    wget \
    gcc \
    lcov \
    build-essential \
    tcl \
    && sudo rm -rf /var/lib/apt/lists/*
    
    
RUN sudo apt update && sudo apt install -y default-jre
RUN sudo apt update && sudo apt install -y openjdk-21-jre

# Copy run_queries.sh
COPY test.sh test

# Copy reducer
COPY reducer.sh reducer

# Copy queries-to-minimize
COPY queries-to-minimize queries-to-minimize

# COPY reducer_helper.java
COPY reducer_helper.java .

# COPY reducer_helper.class
COPY reducer_helper.class .

RUN sudo chmod +x test
RUN sudo chmod +x reducer
RUN sudo chmod +x reducer_helper.class




# Set the default command (you can change this based on your testing)
CMD ["/bin/bash" ]
