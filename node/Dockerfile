# Set the base image to Ubuntu
FROM    ubuntu

# File Author / Maintainer
MAINTAINER Anand Mani Sankar

# Install Node.js and other dependencies
RUN apt-get update && \
    apt-get -y install curl && \
#    curl -sL https://deb.nodesource.com/setup | bash - && \
    curl -sL https://deb.nodesource.com/setup_5.x | bash && \
	apt-get -y install python build-essential nodejs 

# Install nodemon
#RUN npm install -g nodemon

# Provides cached layer for node_modules
#ADD package.json /tmp/package.json
#RUN cd /tmp && npm install
#RUN mkdir -p /src && cp -a /tmp/node_modules /src/

# Define working directory
#WORKDIR /src
#ADD . /src
ADD src/ /src
WORKDIR /src
#
RUN npm install
### Expose port
EXPOSE  8080
##
### Run app using nodemon
CMD ["nodejs", "index.js"]
