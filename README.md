# autonomous_software_testing

How to run our tool:
It should be mentioned that these instructions have worked on a Linux environment! We can not guarantee runability (based on these instructions) on other operating systems.

First pull theosotr/sqlite3-test from the docker (as stated in the project description), this is specifically needed so that we have access to the two older versions, sqlite3-3.26.0 and sqlite3-3.39.4:

sudo service docker start
sudo docker pull theosotr/sqlite3-test
sudo docker run -it theosotr/sqlite3-test

After that open another tap in your terminal.
Now for the next part you need to run the Dockerfile which we provided, resp. build the docker_image:

sudo docker build -t docker_image .

Then to run reducer.sh inside the docker container on --query and --test you can use a command like this e.g.:

sudo docker run --rm   -v "$(pwd)/queries-to-minimize:/usr/bin/queries-to-minimize"   docker_image   ./reducer --query /usr/bin/queries-to-minimize/queries/query17/original_test.sql --test /usr/bin/scripts/queries/query17/test-script.sh

For running in the container:
 docker run -it docker_image /bin/bash

