We will be creatinga three-tier application using a multi-container setup using Docker

# What is a Three-tier architecture?

Three-Tier Architecture is an is an well established software application design pattern which will organizes the application in the three logical and physical computing tiers as following:

-   Presentation Tier (eg. HTML, CSS)
-   Application Tier (eg. Flask)
-   Data Tier (eg. MongoDB)

![Three Tier Architecture](https://miro.medium.com/v2/resize:fit:720/format:webp/0*G-7HIcMgLH89QXvh.png)

# Creating an Isolated Network

```
docker network create myflaskmongonet
```

![All Docker Networks](https://miro.medium.com/v2/resize:fit:828/format:webp/1*LVkJ06WwsDTl3cQcAHe3Rg.png)

# Creating a MongoDB Container

Dockerhub: https://hub.docker.com/_/mongo

```
docker pull mongo:latest
```

![Docker pull output](https://miro.medium.com/v2/resize:fit:828/format:webp/1*dlByTOVsOSfeV3k4zpAcOA.png)

# Running Mongo Container

```
docker run -d -p 27017:27017 --network myflaskmongonet --name 21bcp359_mongo mongo:latest
```

![Mongo container running](https://miro.medium.com/v2/resize:fit:828/format:webp/1*9TptUff4Ze2hP5qYqldLkg.png)

![Docker GUI: mongo](https://miro.medium.com/v2/resize:fit:828/format:webp/1*c9sGrWdQARxiy_gVnWVkdg.png)

![MongoDB Compass](https://miro.medium.com/v2/resize:fit:828/format:webp/1*T4oyUAmSy_JgM_g3_GfJvg.png)

# Project Setup

Project used: https://github.com/Soumi7/Mongo-Docker

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

# Create Dockerfile in the root of your project

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

Difference between RUN and CMD in Dockerfile:

RUN is used to execute commands during the build process of a Docker image, while CMD is used to specify the default command to run when a Docker container is started from the image.

**Build Docker image using the following command**

```
docker build --tag 21bcp359_flask_mongo .
```

![Building Image from Dockerfile](https://miro.medium.com/v2/resize:fit:828/format:webp/1*W2Glnv4ghUjIqXxcO-mmCQ.png)

# Run the Flask App Container

```
docker run -dit -p 5000:5000 --name=21bcp359_flaskapp 21bcp359_flask_mongo
```

![Running your own image](https://miro.medium.com/v2/resize:fit:828/format:webp/1*Jicj8EibXfdwJgkKp_40Bw.png)

![Flask app running](https://miro.medium.com/v2/resize:fit:828/format:webp/1*qcN7xoW358y8F3p0KBUeHQ.png)

![Docker Images Running](https://miro.medium.com/v2/resize:fit:828/format:webp/1*2sHHdv5W9u_taAQkENs45w.png)

**Web App Snapshots**

![Web App: Home Page](https://miro.medium.com/v2/resize:fit:828/format:webp/1*0RImt5O_u4L2m-B7pn7a-w.png)
![Web App: Add Student Data](https://miro.medium.com/v2/resize:fit:828/format:webp/1*szx5nOSzo6GNjqOtSfcTmA.png)
![Web App: Student Data Added](https://miro.medium.com/v2/resize:fit:828/format:webp/1*sU7qj9k3GdOagZgnY8LirQ.png)
![Web App: Details of all students](https://miro.medium.com/v2/resize:fit:828/format:webp/1*IJb9sjGUS4zw04hhvBsWug.png)
![Web App: Editing Student details
](https://miro.medium.com/v2/resize:fit:828/format:webp/1*EVJCXSq6zTXHFk-srinjTw.png)
![Web App: Edited Details](https://miro.medium.com/v2/resize:fit:828/format:webp/1*frAmhTvLuWaNoTMldgjsuQ.png)
![MongoDB Compass](https://miro.medium.com/v2/resize:fit:828/format:webp/1*pJBq_h38P3gXt3nUqRvipA.png)

# Push to Dockerhub

```
docker tag 21bcp359_flask_mongo shaharsh624/21bcp359_flaskapp
```

```
docker push shaharsh624/21bcp359_flaskapp
```

![Pushing to Dockerhub](https://miro.medium.com/v2/resize:fit:828/format:webp/1*k8YtraawujMXE9Rx3Cfgig.png)

![Pushed Dockerhub image](https://miro.medium.com/v2/resize:fit:828/format:webp/1*paj_mEaUxBbOh0NjhVC6Jg.png)

Dockerhub Link: https://hub.docker.com/r/shaharsh624/21bcp359_flaskapp

GitHub Project Link: https://github.com/shaharsh624/Cloud-Computing-IA-2

---

Topics: Docker, Flask, Mongodb, Multi Container Setup
