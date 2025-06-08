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

RUN sudo pip3 install sqlglot

# Copy scripts
COPY scripts scripts

# Copy scripts.zip
COPY scripts.zip .

# Copy reducer
COPY reducer.sh reducer

# Copy queries-to-minimize
COPY queries-to-minimize queries-to-minimize

# COPY all python piles used for reducing the test case
COPY controller.py .
COPY get_sql_statements.py .
COPY delta_reduce_single_statements.py .
COPY remove_redundant_parentheses.py .
COPY simple_changes_single_statement.py .
COPY remove_where_args.py .
COPY remove_select_args.py .
COPY replace_nth_bracket_expression_random.py .
COPY remove_redundant.py .

# make all script files runnable
RUN sudo chmod -R +x scripts
RUN sudo chmod +x reducer
RUN sudo chmod +x controller.py
RUN sudo chmod +x get_sql_statements.py
RUN sudo chmod +x delta_reduce_single_statements.py
RUN sudo chmod +x remove_redundant_parentheses.py
RUN sudo chmod +x simple_changes_single_statement.py
RUN sudo chmod +x remove_where_args.py
RUN sudo chmod +x remove_select_args.py
RUN sudo chmod +x replace_nth_bracket_expression_random.py
RUN sudo chmod +x remove_redundant.py

# Set the default command (you can change this based on your testing)
CMD ["/bin/bash" ]
