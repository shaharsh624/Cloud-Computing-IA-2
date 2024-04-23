# Three-Tier Architecture with Docker

This guide will walk you through creating a three-tier application using a multi-container setup with Docker.

**Author:** Harsh Shah (21BCP359)

**Medium Article:** <a href="https://harshshahdev.medium.com/dockerise-flask-app-with-mongodb-09427f4af8da" target="_blank">Dockerise Flask App with MongoDB</a>

## What is a Three-Tier Architecture?

A three-tier architecture is a well-established software application design pattern that organizes the application into three logical and physical tiers:

-   **Presentation Tier (e.g., HTML, CSS)**: This tier handles the user interface and presentation logic.
-   **Application Tier (e.g., Flask)**: This tier implements the business logic and interacts with the data tier.
-   **Data Tier (e.g., MongoDB)**: This tier stores and manages the application data.

<img src="https://miro.medium.com/v2/resize:fit:720/format:webp/0*G-7HIcMgLH89QXvh.png" alt="Three Tier Architecture" width="500" height="auto">

## Creating an Isolated Network

This command creates a new Docker network named `myflaskmongonet` that will be used by our application containers.

```
docker network create myflaskmongonet
```

<img src="https://miro.medium.com/v2/resize:fit:828/format:webp/1*LVkJ06WwsDTl3cQcAHe3Rg.png" alt="All Docker Networks" width="500" height="auto">

## Creating a MongoDB Container

You can pull the official MongoDB image from Docker Hub: https://hub.docker.com/_/mongo

```
docker pull mongo:latest
```

<img src="https://miro.medium.com/v2/resize:fit:828/format:webp/1*dlByTOVsOSfeV3k4zpAcOA.png" alt="Docker pull output" width="500" height="auto">

## Running Mongo Container

This command runs a MongoDB container in detached mode (`-d`), maps the container's port 27017 to the host's port 27017 (`-p`), connects the container to the `myflaskmongonet` network (`--network`), and assigns the name `21bcp359_mongo` to the container.

```
docker run -d -p 27017:27017 --network myflaskmongonet --name 21bcp359_mongo mongo:latest
```

<img src="https://miro.medium.com/v2/resize:fit:828/format:webp/1*9TptUff4Ze2hP5qYqldLkg.png" alt="Mongo container running" width="500" height="auto">

<img src="https://miro.medium.com/v2/resize:fit:828/format:webp/1*c9sGrWdQARxiy_gVnWVkdg.png" alt="Docker GUI: mongo" width="500" height="auto">

<img src="https://miro.medium.com/v2/resize:fit:828/format:webp/1*T4oyUAmSy_JgM_g3_GfJvg.png" alt="MongoDB Compass" width="500" height="auto">

## Project Setup

For this example, we'll use a project from GitHub: https://github.com/Soumi7/Mongo-Docker

These commands clone the `Mongo-Docker` repository, install the required Python packages, and run the Flask application. You should be able to access the application at http://localhost:5000/.

```
git clone https://github.com/Soumi7/Mongo-Docker.git
```

```
cd Mongo-Docker/
```

```
python -m pip install -r requirements.txt
```

```
python app.py
```

Navigate to http://localhost:5000/

## Create Dockerfile in the root of your project

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

**Difference between _RUN_ and _CMD_ in Dockerfile:**

RUN is used to execute commands during the build process of a Docker image, while CMD is used to specify the default command to run when a Docker container is started from the image.

## Build Docker image using the following command

This command builds the image from the Dockerfile in the current directory and tags it with the name `21bcp359_flask_mongo`.

```
docker build --tag 21bcp359_flask_mongo .
```

<img src="https://miro.medium.com/v2/resize:fit:828/format:webp/1*W2Glnv4ghUjIqXxcO-mmCQ.png" alt="Building Image from Dockerfile" width="500" height="auto">

## Run the Flask App Container

This command runs a container from the `21bcp359_flask_mongo` image:

-   Runs in detached mode (`-d`)
-   Maps the container's port `5000` to the host's port 5000 (`-p`)
-   Connects the container to the `myflaskmongonet` network (`--network`)
-   Assigns the name `21bcp359_flaskapp` to the container
-   Runs the application in the background (`-i`) and allocates a pseudo-TTY (`-t`)

You should now be able to access your Flask application at http://localhost:5000/

```
docker run -dit -p 5000:5000 --name=21bcp359_flaskapp 21bcp359_flask_mongo
```

<img src="https://miro.medium.com/v2/resize:fit:828/format:webp/1*Jicj8EibXfdwJgkKp_40Bw.png" alt="Running your own image" width="500" height="auto">

<img src="https://miro.medium.com/v2/resize:fit:828/format:webp/1*qcN7xoW358y8F3p0KBUeHQ.png" alt="Flask app running" width="500" height="auto">

<img src="https://miro.medium.com/v2/resize:fit:828/format:webp/1*2sHHdv5W9u_taAQkENs45w.png" alt="Docker Images Running" width="500" height="auto">

### Web App Snapshots

<img src="https://miro.medium.com/v2/resize:fit:828/format:webp/1*0RImt5O_u4L2m-B7pn7a-w.png" alt="Web App: Home Page" width="500" height="auto">
<img src="https://miro.medium.com/v2/resize:fit:828/format:webp/1*szx5nOSzo6GNjqOtSfcTmA.png" alt="Web App: Add Student Data" width="500" height="auto">
<img src="https://miro.medium.com/v2/resize:fit:828/format:webp/1*sU7qj9k3GdOagZgnY8LirQ.png" alt="Web App: Student Data Added" width="500" height="auto">
<img src="https://miro.medium.com/v2/resize:fit:828/format:webp/1*IJb9sjGUS4zw04hhvBsWug.png" alt="Web App: Details of all students" width="500" height="auto">
<img src="https://miro.medium.com/v2/resize:fit:828/format:webp/1*EVJCXSq6zTXHFk-srinjTw.png" alt="Web App: Editing Student details" width="500" height="auto">
<img src="https://miro.medium.com/v2/resize:fit:828/format:webp/1*frAmhTvLuWaNoTMldgjsuQ.png" alt="Web App: Edited Details" width="500" height="auto">
<img src="https://miro.medium.com/v2/resize:fit:828/format:webp/1*pJBq_h38P3gXt3nUqRvipA.png" alt="MongoDB Compass" width="500" height="auto">

## Push to Dockerhub

```
docker tag 21bcp359_flask_mongo shaharsh624/21bcp359_flaskapp
```

```
docker push shaharsh624/21bcp359_flaskapp
```

<img src="https://miro.medium.com/v2/resize:fit:828/format:webp/1*k8YtraawujMXE9Rx3Cfgig.png" alt="Pushing to Dockerhub" width="500" height="auto">

<img src="https://miro.medium.com/v2/resize:fit:828/format:webp/1*paj_mEaUxBbOh0NjhVC6Jg.png" alt="Pushed Dockerhub image" width="500" height="auto">

<br>

[Dockerhub Link](https://hub.docker.com/r/shaharsh624/21bcp359_flaskapp)

[GitHub Project Link](https://github.com/shaharsh624/Cloud-Computing-IA-2)

---

**Connect with me:**

**Portfolio:** [shaharsh.vercel.app](https://shaharsh.vercel.app/)  
**LinkedIn:** [harshshahdev](https://www.linkedin.com/in/harshshahdev/)  
**GitHub:** [shaharsh624](https://github.com/shaharsh624)

---
