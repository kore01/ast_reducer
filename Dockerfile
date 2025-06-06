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
    python3 \
    python3-pip \
    && sudo rm -rf /var/lib/apt/lists/*


#RUN sudo apt update && sudo apt install -y default-jre
#RUN sudo apt update && sudo apt install -y openjdk-21-jre
RUN sudo pip3 install sqlglot

# Copy run_queries.sh
COPY test.sh test_eq

# Copy scripts
COPY scripts scripts

# Copy reducer
COPY reducer.sh reducer

# Copy queries-to-minimize
COPY queries-to-minimize queries-to-minimize

# COPY reducer_helper.java
COPY controller.py .

COPY run_sqlite.py run_sqlite

# COPY get_sql_statements.py
COPY get_sql_statements.py .
COPY delta_reduce_single_statements.py .
COPY remove_redundant_parentheses.py .
COPY simple_changes_single_statement.py .
COPY remove_where_args.py .
COPY remove_select_args.py .

COPY run_sqlite.py .

RUN sudo chmod +x test_eq
RUN sudo chmod +x reducer
#RUN sudo chmod +x reducer_helper.class
RUN sudo chmod +x get_sql_statements.py
RUN sudo chmod +x delta_reduce_single_statements.py
RUN sudo chmod +x remove_redundant_parentheses.py

RUN sudo chmod -R +x scripts
RUN sudo chmod +x run_sqlite


# Set the default command (you can change this based on your testing)
CMD ["/bin/bash" ]
