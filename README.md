# Running Flask App with MongoDB using Docker :

Start the mongo server :

```
docker run -d -p 27017:27017 --name test-mongo mongo:latest
```

Install requirements :

```
python3 -m pip install -r requirments.txt
```

To run the Flask app :

```
python3 app.py
```

Navigate to `http://localhost:5000/` !

# Dockerfile Explanation

```
FROM python:3.8
ENV MONGODB_CONNSTRING="mongodb://localhost:27017"
COPY ./app_atlas.py /deploy/
COPY ./requirements.txt /deploy/
COPY ./templates /deploy/templates/
COPY ./static/css /deploy/static/css/
WORKDIR /deploy/
RUN pip3 install -r requirements.txt
EXPOSE 5000
ENTRYPOINT ["python", "app_atlas.py"]
```

### Using the Python 3.8 base image from Docker Hub

```
FROM python:3.8
```

### Copying the app_atlas.py file from the local directory to the /deploy directory in the container

```
COPY ./app_atlas.py /deploy/
```

### Copying the requirements.txt file from the local directory to the /deploy directory in the container

```
COPY ./requirements.txt /deploy/
```

### Copying the contents of the templates directory from the local directory to the /deploy/templates directory in the container

```
COPY ./templates /deploy/templates/
```

### Copying the contents of the static/css directory from the local directory to the /deploy/static/css directory in the container

```
COPY ./static/css /deploy/static/css/
```

### Setting the working directory to /deploy

```
WORKDIR /deploy/
```

### Installing the Python dependencies listed in requirements.txt using pip

```
RUN pip3 install -r requirements.txt
```

### Exposing port 80 to allow external access

```
EXPOSE 80
```

### Setting the command to run when the container starts as 'python app_atlas.py'

```
ENTRYPOINT ["python", "app_atlas.py"]
```
