# Python image to use.
FROM nvidia/cuda:11.1.1-devel-ubuntu20.04

ENV DEBIAN_FRONTEND=noninteractive

RUN --mount=type=cache,target=/var/cache/apt \
    apt update && \
    apt -y upgrade && \
    #apt-get install -y jupyterlab && \
    apt -y install python3-pip

# Set the working directory to /app
WORKDIR /app

# copy the requirements file used for dependencies
COPY requirements.txt .

# Install any needed packages specified in requirements.txt
RUN pip3 install --trusted-host pypi.python.org -r requirements.txt

RUN --mount=type=cache,target=/var/cache/apt \
    apt update && \
    apt-get install -y vim

# Copy the rest of the working directory contents into the container at /app
COPY . .

# Run app.py when the container launches
ENTRYPOINT ["python3", "app.py"]
