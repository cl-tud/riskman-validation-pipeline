FROM ubuntu:latest

# build 
# docker build -t riskman-pipeline .
# docker build -t riskman-pipeline . --progress=plain

# use bash to have the "source" command and activate the environment
SHELL ["/bin/bash", "-c"] 

# install python 3.11 & java 18
RUN apt-get --yes update && \
    apt-get --yes install software-properties-common wget tar && \
    apt-add-repository --yes ppa:deadsnakes/ppa && \
    apt-get --yes update && \
    apt-get --yes install python3.11 && \
    apt-get --yes install python3.11-venv


# Download and install OpenJDK 18
RUN wget https://download.java.net/openjdk/jdk18/ri/openjdk-18+36_linux-x64_bin.tar.gz && \
    tar -xvf openjdk-18+36_linux-x64_bin.tar.gz && \
    mv jdk-18 /usr/local/jdk-18 && \
    rm openjdk-18+36_linux-x64_bin.tar.gz

# set JAVA_HOME, add java to path
ENV JAVA_HOME=/usr/local/jdk-18
ENV PATH=$JAVA_HOME/bin:$PATH

# set working directory    
WORKDIR /app

# copy all local files
COPY . .

# create python environment, install libraries
RUN python3.11 -m venv kimeds_env && \ 
    source kimeds_env/bin/activate && \
    pip install --upgrade pip && \
    pip install -r requirements.txt

# download the ontology and shapes
RUN rm -rf input && \
    mkdir input 
    # wget -O input/ontology.ttl https://w3id.org/riskman/ontology && \
    # wget -O input/shapes.ttl https://w3id.org/riskman/shapes

ENTRYPOINT ["./main.sh"]